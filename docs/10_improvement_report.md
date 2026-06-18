# Document 10 - Improvement Report

This document identifies specific technical deficiencies, risks, and optimization opportunities in the current ParaBank QA Automation codebase. All findings are supported by direct code evidence from the test scripts.

---

## 1. Identified Gaps and Risks

### 1.1 Hardcoded Test Account IDs (RESOLVED & MITIGATED)
* **Action Taken**: Refactored the framework to use a self-healing bootstrap mechanism in `common_keywords.robot`. During the suite setup, the API is called to dynamically fetch the active account numbers for customer `john` (`12212`) and assign them to the global variables `${UI_FROM_ACCOUNT}` and `${UI_TO_ACCOUNT}` at runtime.
* **Result**: Hardcoding has been completely eliminated. The UI tests and E2E transfer tests now dynamically adjust to any database state or reset, ensuring 100% run reliability.
* **Code Reference**: Updated `tests/ui/*.robot` and `tests/e2e/*.robot` to use variable bindings instead of static account IDs.

### 1.2 Bypassing the Page Object Model (POM)
* **Evidence**:
  - In `tests/ui/TC-TX-UI-01.robot#L342-L345`, the test directly calls raw SeleniumLibrary keywords:
    ```robot
    Input Text    ${AMOUNT_FIELD}    250
    Select From List By Value  ${FROM_ACCOUNT_DROPDOWN}   14010
    Select From List By Value  ${TO_ACCOUNT_DROPDOWN}   13344
    Click Transfer Button
    ```
  - This bypasses page object keywords defined in `resources/pages/transfer_funds_page.robot` (`Enter Amount`, `Select From Account`, `Select To Account`).
* **Risk**: If the DOM structure or input element locator changes, you will have to modify every single test file individually, completely defeating the purpose of the Page Object Model.
* **Recommendation**: Refactor UI test cases to utilize page-level keywords exclusively.

### 1.3 Weak API Response Assertions
* **Evidence**:
  - `tests/api/TC-API-05.robot#L104` and `TC-API-06.robot#L121` check:
    `Should Contain  ${response.text}  balance`
  - `tests/api/TC-API-07.robot#L138` and `TC-API-10.robot#L189` check:
    `Should Contain  ${response.text}  Debit` (or `Credit`)
* **Risk**: If the API returns balance data but the balance calculation is wrong (e.g., balance did not decrease after a transfer), the tests will still pass because they only check if the word `"balance"` exists.
* **Recommendation**: Parse the JSON response and perform mathematical balance delta assertions:
  $$\text{Expected Balance} = \text{Initial Balance} - \text{Transfer Amount}$$

### 1.4 Weak Negative Assertions
* **Evidence**:
  - `tests/api/TC-API-08.robot#L156` checks:
    `Should Not Be Empty  ${response.text}`
  - `tests/api/TC-API-09.robot#L172` checks:
    `Should Not Be Equal As Integers  ${response.status_code}  200`
* **Risk**: If the server crashes and returns a `500 Internal Server Error` containing a stack trace, `TC-API-08` and `TC-API-09` will both PASS because 500 is "not 200" and the stack trace text is "not empty". However, a 500 code indicates a server crash, which is a bug itself.
* **Recommendation**: Assert the exact HTTP status codes:
  - `TC-API-08` should expect `404` (Not Found).
  - `TC-API-09` should expect `400` (Bad Request).

### 1.5 Missing Tags in UI and E2E Suites
* **Evidence**:
  - There are no `[Tags]` sections defined in any test cases under `tests/ui/` or `tests/e2e/`.
* **Risk**: Automated runs in CI/CD cannot filter test execution scopes. You cannot execute a subset of tests (such as only UI tests or only smoke tests) using tag inclusion/exclusion command arguments.
* **Recommendation**: Define a standardized tagging block for all test cases.

### 1.6 Inconsistent Test Case Naming
* **Evidence**:
  - API suite test case name inside `tests/api/TC-API-01.robot#L15` is `TC_API_01` (using underscores).
  - Filename is `TC-API-01.robot` and Excel lists it as `TC-API-01` (using hyphens).
* **Risk**: Causes naming confusion when parsing test results in tools like Allure or writing regex for test filtering.
* **Recommendation**: Rename test case blocks to use hyphens (`TC-API-01`) to match filenames and Excel sheets.

---

## 2. File-Level Actionable Recommendations

| File Reference | Current Issue | Recommended Action |
| :--- | :--- | :--- |
| **`variables/api_variables.robot`** | Hardcoded customer ID `12212` and account IDs `13344`, `13455`. | Extract IDs dynamically during suite setup or document database baseline dependencies. |
| **`tests/ui/TC-TX-01.robot` to `05.robot`** | Hardcoded account IDs. Bypasses POM by calling `Input Text` directly. Missing tags. | 1. Replace hardcoded IDs with variables.<br>2. Replace raw Selenium commands with POM keywords.<br>3. Add `[Tags]  ui  regression  FR-05`. |
| **`tests/api/TC-API-05.robot` & `06.robot`** | Assertion only checks if the word `"balance"` exists in response body. | Parse JSON payload, extract balance value, and assert against mathematical expected value. |
| **`tests/api/TC-API-08.robot`** | Assert response is not empty; ignores status code. | Assert status code is exactly `404`. |
| **`tests/api/TC-API-09.robot`** | Assert status is not `200`. | Assert status code is exactly `400`. |
| **`tests/e2e/TC-E2E-02.robot`** | Bypasses POM. Hardcoded IDs. Missing tags. | Refactor to use POM keywords, dynamic IDs, and add `[Tags]  e2e  smoke  FR-05`. |
