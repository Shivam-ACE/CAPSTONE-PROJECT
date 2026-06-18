# Document 4 - Keyword Documentation

This document describes the custom reusable keywords created in the ParaBank QA Automation suite, organized by file.

---

## 1. Common Keywords (`resources/keywords/common_keywords.robot`)

These keywords manage the environment setup, teardown, browser lifecycles, and login authentication.

### 🔑 Load Environment
* **Purpose**: Loads configuration settings based on the target environment variable (e.g., `qa`, `dev`, `prod`) and sets global variables for execution.
* **Parameters**: None (reads global variable `${ENV}`).
* **Return Values**: None (sets global variables `${BASE_URL}`, `${USERNAME}`, and `${PASSWORD}`).
* **Usage**: Called in `Suite Setup` for UI and hybrid E2E test suites.

### 🔑 Open Application
* **Purpose**: Launches the browser, navigates to the environment's base URL, and maximizes the window.
* **Parameters**: None.
* **Return Values**: None.
* **Usage**: Used inside `Open Application And Login`.

### 🔑 Close Application
* **Purpose**: Closes all active browser instances and cleans up the driver process.
* **Parameters**: None.
* **Return Values**: None.
* **Usage**: Called in `Test Teardown` for all UI and E2E suites.

### 🔑 Login
* **Purpose**: Interacts with the login input controls, enters credentials, and submits the login form.
* **Parameters**: None (uses global variables `${USERNAME}` and `${PASSWORD}`).
* **Return Values**: None.
* **Usage**: Used inside `Open Application And Login`.

### 🔑 Open Application And Login
* **Purpose**: Composite keyword that combines opening the browser and performing authentication.
* **Parameters**: None.
* **Return Values**: None.
* **Usage**: Called in `Test Setup` for all UI test cases.

### 🔑 Load Environment And Create Session To API
* **Purpose**: Combined setup keyword that prepares both the UI environment config and the API Requests session.
* **Parameters**: None.
* **Return Values**: None.
* **Usage**: Called in `Suite Setup` for E2E tests (`TC-E2E-01`, `TC-E2E-02`).

---

## 2. API Keywords (`resources/keywords/api_keywords.robot`)

These keywords encapsulate REST API queries using the Robot Framework `RequestsLibrary`.

### 🔑 Create Session To API
* **Purpose**: Establishes a connection to the ParaBank REST API base URL and configures the standard `Accept` header.
* **Parameters**: None.
* **Return Values**: None (registers the session alias `parabank`).
* **Usage**: Called in `Suite Setup` for API test suites.

### 🔑 Get Customer Accounts
* **Purpose**: Fetches the list of accounts linked to a specific customer ID.
* **Parameters**: `${customerId}` (Integer or string)
* **Return Values**: `${response}` (HTTP Response object)
* **Usage**: `TC-API-01`, `TC-API-03`, `TC-E2E-01`.

### 🔑 Verify Response Code
* **Purpose**: Asserts that the HTTP status code of the response matches the expected value.
* **Parameters**:
  - `${response}`: HTTP Response object
  - `${code}`: Expected status code (e.g., `200`)
* **Return Values**: None.
* **Usage**: Called in almost all API and E2E validations.

### 🔑 Get Account Details
* **Purpose**: Fetches detailed properties (id, customerId, type, balance) of a single account number.
* **Parameters**: `${accountId}` (Integer or string)
* **Return Values**: `${response}` (HTTP Response object)
* **Usage**: `TC-API-02`, `TC-API-05`, `TC-API-06`, `TC-API-08`, `TC-E2E-01`.

### 🔑 Transfer Funds API
* **Purpose**: Sends a POST request to execute a funds transfer between accounts.
* **Parameters**:
  - `${fromAccountId}`: Source account number
  - `${toAccountId}`: Destination account number
  - `${amount}`: Transfer amount (number)
* **Return Values**: `${response}` (HTTP Response object)
* **Usage**: `TC-API-04`, `TC-API-09`.

### 🔑 Get Account Transactions
* **Purpose**: Fetches the transaction history ledger for a specific account.
* **Parameters**: `${accountId}` (Integer or string)
* **Return Values**: `${response}` (HTTP Response object)
* **Usage**: `TC-API-07`, `TC-API-10`, `TC-E2E-02`.

---

## 3. Home Page Objects (`resources/pages/home_page.robot`)

### 🔑 Click Open New Account
* **Purpose**: Click the Open New Account link in the sidebar menu.
* **Parameters**: None.
* **Return Values**: None.

### 🔑 Click Transfer Funds
* **Purpose**: Click the Transfer Funds link in the sidebar menu.
* **Parameters**: None.
* **Return Values**: None.

---

## 4. Open New Account Page Objects (`resources/pages/open_new_account_page.robot`)

### 🔑 Select Account Type
* **Purpose**: Selects Checking (`0`) or Savings (`1`) from the account type dropdown.
* **Parameters**: `${account_type}` (Integer/String)
* **Return Values**: None.

### 🔑 Select Account ID
* **Purpose**: Selects a specific funding account ID from the dropdown list.
* **Parameters**: `${account_id}` (Integer/String)
* **Return Values**: None.

### 🔑 Click Open Account Button
* **Purpose**: Clicks the submit button to provision the account.
* **Parameters**: None.
* **Return Values**: None.

### 🔑 Click Account Details Link
* **Purpose**: Clicks the new account number hyperlink in the success banner.
* **Parameters**: None.
* **Return Values**: None.

### 🔑 Get New Account Number
* **Purpose**: Waits for the confirmation banner link, extracts the newly created account number text, and prints it.
* **Parameters**: None.
* **Return Values**: `${account_id}` (String representation of new account number)
* **Usage**: Used in `TC-E2E-01` to capture the ID for API validation.

---

## 5. Transfer Funds Page Objects (`resources/pages/transfer_funds_page.robot`)

### 🔑 Select From Account
* **Purpose**: Selects the source funding account from the dropdown.
* **Parameters**: `${from_account}` (String)
* **Return Values**: None.

### 🔑 Select To Account
* **Purpose**: Selects the destination account from the dropdown.
* **Parameters**: `${to_account}` (String)
* **Return Values**: None.

### 🔑 Enter Amount
* **Purpose**: Inputs the transfer amount into the text field.
* **Parameters**: `${amount}` (Number/String)
* **Return Values**: None.

### 🔑 Click Transfer Button
* **Purpose**: Clicks the submit input to execute the fund transfer.
* **Parameters**: None.
* **Return Values**: None.
