# Document 7 - Validation Coverage Documentation

This document maps out the specific categories of validation assertions performed in each automated test case. It evaluates our coverage against the PDF requirements and the corrected Excel sheet, highlighting weak assertions and missing validation logic.

---

## 1. Validation Categories Defined

To verify quality thoroughly, we classify validations into six categories:
1. **UI Validation**: Assertions checking visual text, headers, and form status.
2. **API Validation**: Assertions checking JSON keys, HTTP status codes, and HTTP headers.
3. **Business Validation**: Assertions auditing financial calculations (such as balance deltas).
4. **Data Validation**: Assertions auditing data types (e.g., confirming IDs are integers).
5. **Field Validation**: Assertions checking input field constraints (e.g., blank, alphabetics).
6. **Navigation Validation**: Assertions verifying URL path redirects.

---

## 2. Test Case Validation Mapping

The table below lists the validation types executed in each automated test case.

| Test Case ID | Test Case Name | UI | API | Business | Data | Field | Nav | Description of Assertions Performed |
| :--- | :--- | :---: | :---: | :---: | :---: | :---: | :---: | :--- |
| **TC-NAV-UI-01** | Verify Navigation Flow and Menu Links | | | | | | X | Checks URL contains `openaccount` and `transfer`. |
| **TC-AC-UI-01** | Create Savings Account (Specific Funding) | X | | | | | | Checks page contains "Account Opened!" and "Your new account number". |
| **TC-AC-UI-02** | Create Checking Account (Default Funding) | X | | | | | | Checks page contains "Account Opened!" and "Your new account number". |
| **TC-AC-UI-03** | Navigate to Account Details via Link | X | | | | | X | Checks URL contains `activity.htm?id=` and page contains "Account Details". |
| **TC-AC-UI-04** | Verify Open New Account Form Controls | X | | | | | | Checks dropdown and button element visibility. |
| **TC-TX-UI-01** | Verify Transfer Funds UI Input Fields | X | | | | | | Checks page contains "Transfer Complete!". |
| **TC-TX-UI-02** | Execute Fund Transfer (Savings $\rightarrow$ Checking) | X | | | | | | Checks page contains "Transfer Complete!". |
| **TC-TX-UI-03** | Blank Amount in Transfer Form | X | | | | X | | Checks page contains "Error" (intended to fail). |
| **TC-TX-UI-04** | Alphabetic Characters in Transfer Amount | X | | | | X | | Checks page contains "Error" (intended to fail). |
| **TC-TX-UI-05** | Transfer Exceeding Available Balance | X | | | | X | | Checks page contains "Error" (intended to fail). |
| **TC-API-01** | GET Customer Accounts List Structure | | X | | | | | Checks HTTP status code is 200, content is JSON, list is not empty. |
| **TC-API-02** | GET Specific Account Details Schema | | X | | X | | | Checks status code is 200, checks for keys `id`, `customerId`, `type`, `balance`. |
| **TC-API-03** | Newly Created Account Exists in API List | | X | | | | | Checks status is 200 and text contains new account ID. |
| **TC-API-04** | Execute Fund Transfer via REST API | | X | | | | | Checks status is 200 and body text contains "Successfully transferred". |
| **TC-API-05** | Verify Source Account Balance Debited | | X | | | | | Checks status is 200, body contains word "balance". (Weak!) |
| **TC-API-06** | Verify Destination Account Balance Credited | | X | | | | | Checks status is 200, body contains word "balance". (Weak!) |
| **TC-API-07** | Verify Transaction History Logs Debit Entry | | X | | | | | Checks status is 200, body contains word "Debit". (Weak!) |
| **TC-API-08** | GET Details for Non-Existent ID | | X | | | | | Checks body text is not empty. (Weak!) |
| **TC-API-09** | POST Transfer Fails for Insufficient Balance | | X | | | | | Checks status is not 200. (Weak!) |
| **TC-API-10** | Verify Transaction History Logs Credit Entry | | X | | | | | Checks status is 200, body contains word "Credit". (Weak!) |
| **TC-E2E-01** | E2E Account Provisioning Journey | X | X | | | | | Checks UI banner, API accounts list membership, and API details type "SAVINGS". |
| **TC-E2E-02** | E2E Fund Transfer UI and API Audit | X | X | X | | | | Checks UI "Transfer Complete!" and checks API transaction ledger contains amount. |

---

## 3. Identified Gaps and Missing Validations

By comparing our automation scripts against the **PDF Requirements** (Source of Truth) and the **Corrected Excel Sheet**, we identify four critical validation gaps:

### 3.1 Weak Assertions in Balance Verification (`TC-API-05` and `TC-API-06`)
* **Requirement**: FR-06 ("Validate updated balances using API").
* **Current Automation**: Tests only check if the word `"balance"` is contained in the GET response JSON.
* **Missing Assertion**: They do **not** calculate if the new balance matches the mathematical formula:
  $$\text{New Balance} = \text{Old Balance} \pm \text{Transfer Amount}$$
* **Impact**: If the API responds successfully but fails to update the balance database table, the test case will still pass!

### 3.2 Weak Assertions in Transaction History (`TC-API-07` and `TC-API-10`)
* **Requirement**: FR-07 ("Validate transfer applied correctly").
* **Current Automation**: Checks if the response body contains `"Debit"` or `"Credit"`.
* **Missing Assertion**: They do **not** verify that the transaction amount is exactly `$150.00` or check the description strings.
* **Impact**: If any old debit/credit transaction is in the account history, the test passes, even if the current transfer failed to write to the ledger.

### 3.3 Weak Assertions in Negative API Tests (`TC-API-08` and `TC-API-09`)
* **Requirement**: FR-09 ("Validate negative scenarios").
* **Current Automation**:
  - `TC-API-08` check response text is not empty (ignoring status code).
  - `TC-API-09` checks status code is not 200 (ignoring specific code).
* **Missing Assertion**: `TC-API-08` should assert `status_code == 404` (Not Found). `TC-API-09` should assert `status_code == 400` (Bad Request).
* **Impact**: If the server returns a 500 Internal Server Error (which is a server crash bug), the tests will still pass because 500 is "not 200" and response text is "not empty".

### 3.4 Missing UI Form Boundary Validation
* **Requirement**: FR-09 ("Validate negative scenarios") / PDF Section 1.2 ("Field Level Validation").
* **Current Automation**: No UI test attempts to validate initial deposit boundary limits on the Open New Account form (e.g., submitting a negative deposit or entering alphabetic characters in the UI field).
* **Impact**: Form controls are only verified for visibility, not for validation strength.
