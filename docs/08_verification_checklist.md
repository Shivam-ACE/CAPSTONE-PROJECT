# Document 8 - Verification Checklist

This document serves as a code review checklist for the ParaBank QA Automation suite. It grades each file on key quality indicators: Documentation, Logging, Tagging, Validation, Reusability, and Maintainability.

---

## 1. Code Review Guidelines

To achieve a **PASS** status, a file must meet the following criteria:
* **Documentation**: Has file description/documentation headers.
* **Logging**: Tracks steps or logs inputs/outputs (especially for keywords/actions).
* **Tagging**: Uses appropriate tag labels (specifically for test files).
* **Validation**: Performs clear, robust assertions (does not use weak checks).
* **Reusability**: No copy-pasted lines; utilizes shared page objects and keywords.
* **Maintainability**: Hardcoded values (IDs, URLs, XPaths) are avoided; selectors are centralized in variable files.

---

## 2. File-by-File Quality Audit Checklist

The table below lists each project file, evaluates it against the audit criteria, and provides an overall status.

| File Path | Doc | Log | Tag | Val | Reus | Maint | Status | Reviewer Findings & Gap Explanations |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :--- |
| **`config/browser_config.yaml`** | ❌ | — | — | — | — | **PASS** | **PASS** | Centralizes configurations by environment. No documentation comments, but structure is clear. |
| **`config/environment.py`** | ❌ | ❌ | — | — | **PASS** | **PASS** | **PASS** | Simple utility; missing python docstrings and function log messages. |
| **`resources/keywords/api_keywords.robot`** | ❌ | ❌ | — | ❌ | **PASS** | **PASS** | **FAIL** | **Gaps**: No log messages inside keywords before/after requests. `Verify Response Code` is reusable but simple. |
| **`resources/keywords/common_keywords.robot`** | **PASS** | ❌ | — | **PASS** | **PASS** | **PASS** | **FAIL** | **Gaps**: Has documentation headers, but does not log actions (e.g., inside `Login` or `Open Application`). |
| **`resources/pages/home_page.robot`** | ❌ | ❌ | — | — | **PASS** | **PASS** | **PASS** | Simple page navigation helper. No logging or documentation. |
| **`resources/pages/open_new_account_page.robot`** | ❌ | ❌ | — | **PASS** | **PASS** | **PASS** | **FAIL** | **Gaps**: Missing documentation headers. Missing log messages inside page actions. |
| **`resources/pages/transfer_funds_page.robot`** | ❌ | ❌ | — | — | **PASS** | **PASS** | **FAIL** | **Gaps**: Missing documentation and logging. |
| **`variables/api_variables.robot`** | ❌ | — | — | — | — | ❌ | **FAIL** | **Gaps**: Centralizes variables, but test account IDs (`13344`, `13455`) are hardcoded, causing data dependencies. |
| **`variables/home_variables.robot`** | ❌ | — | — | — | — | **PASS** | **PASS** | XPaths are centralized. |
| **`variables/login_variables.robot`** | ❌ | — | — | — | — | **PASS** | **PASS** | XPaths are centralized. |
| **`variables/open_new_account_variables.robot`** | ❌ | — | — | — | — | **PASS** | **PASS** | XPaths are centralized. |
| **`variables/transfer_funds_variables.robot`** | ❌ | — | — | — | — | **PASS** | **PASS** | XPaths are centralized. |
| **`tests/api/TC-API-01.robot`** to **`TC-API-10.robot`** | **PASS** | **PASS** | **PASS** | ❌ | **PASS** | **PASS** | **FAIL** | **Gaps**: Test names use underscores inside files (`TC_API_01`) but filenames use hyphens. API assertions are weak (just check word `"balance"` or `"Debit"` exists). Negative tests check `status != 200` instead of asserting `404` or `400`. |
| **`tests/ui/TC-AC-UI-01.robot`** | **PASS** | ❌ | ❌ | **PASS** | **PASS** | **PASS** | **FAIL** | **Gaps**: Missing tags. No logging. Account ID selection is dynamic (`${UI_TO_ACCOUNT}`). |
| **`tests/ui/TC-AC-UI-02.robot`** | **PASS** | ❌ | ❌ | **PASS** | **PASS** | **PASS** | **FAIL** | **Gaps**: Missing tags. No logging. |
| **`tests/ui/TC-AC-UI-03.robot`** | **PASS** | ❌ | ❌ | **PASS** | **PASS** | **PASS** | **FAIL** | **Gaps**: Missing tags. No logging. |
| **`tests/ui/TC-AC-UI-04.robot`** | **PASS** | ❌ | ❌ | **PASS** | **PASS** | **PASS** | **FAIL** | **Gaps**: Missing tags. No logging. |
| **`tests/ui/TC-NAV-UI-01.robot`** | **PASS** | ❌ | ❌ | **PASS** | **PASS** | **PASS** | **FAIL** | **Gaps**: Missing tags. No logging. |
| **`tests/ui/TC-TX-UI-01.robot`** | **PASS** | ❌ | ❌ | **PASS** | ❌ | **PASS** | **FAIL** | **Gaps**: Missing tags. No logging. Account ID selection is dynamic (`${UI_FROM_ACCOUNT}`, `${UI_TO_ACCOUNT}`). Bypasses page objects (`Input Text` used instead of `Enter Amount`). |
| **`tests/ui/TC-TX-UI-02.robot`** | **PASS** | ❌ | ❌ | **PASS** | ❌ | **PASS** | **FAIL** | **Gaps**: Missing tags. No logging. Account ID selection is dynamic. Bypasses page objects (`Input Text` used). |
| **`tests/ui/TC-TX-UI-03.robot`** | **PASS** | ❌ | ❌ | **PASS** | ❌ | **PASS** | **FAIL** | **Gaps**: Missing tags. No logging. Account ID selection is dynamic. Bypasses page objects. |
| **`tests/ui/TC-TX-UI-04.robot`** | **PASS** | ❌ | ❌ | **PASS** | ❌ | **PASS** | **FAIL** | **Gaps**: Missing tags. No logging. Account ID selection is dynamic. Bypasses page objects. |
| **`tests/ui/TC-TX-UI-05.robot`** | **PASS** | ❌ | ❌ | **PASS** | ❌ | **PASS** | **FAIL** | **Gaps**: Missing tags. No logging. Account ID selection is dynamic. Bypasses page objects. |
| **`tests/e2e/TC-E2E-01.robot`** | **PASS** | **PASS** | ❌ | **PASS** | **PASS** | **PASS** | **FAIL** | **Gaps**: Missing tags. Logs are present but could be structured better. |
| **`tests/e2e/TC-E2E-02.robot`** | **PASS** | ❌ | ❌ | **PASS** | ❌ | **PASS** | **FAIL** | **Gaps**: Missing tags. No logging. Account ID selection is dynamic. UI entry is done via keywords but transaction query is done using API variables. |

---

## 3. Summary of Code Review Findings

* **Total Files Reviewed**: 25 files.
* **PASS Count**: 11 files (predominantly configuration and XPath variable selectors).
* **FAIL Count**: 14 files (all test suite scripts, api_keywords resource, and some page objects).
* **Key Corrective Action Plan**:
  1. Add tag sections to all UI and E2E test files containing requirement and scope tags.
  2. Refactor UI tests to use Page Object keywords (`Enter Amount`, `Select From Account`, `Select To Account`) rather than raw Selenium keywords (`Input Text`, `Select From List By Value`).
  3. Replace hardcoded test account IDs (like `14010` and `13344`) with dynamic, variable-driven data (RESOLVED).
  4. Inject context-driven log keywords (`Log` and `Log To Console`) in page objects and keyword files.
