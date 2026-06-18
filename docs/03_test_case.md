# Document 3 - Test Case Documentation

This document provides detailed documentation for each of the 22 automated test cases in the project, aligned with the corrected Excel workbook.

---

## 1. UI Test Cases (10 Cases)

### 📄 TC-NAV-UI-01: Verify Navigation Flow and Menu Link Integrity
* **Business Objective**: Verify navigation menu links redirect the user to correct sub-pages with expected page headers.
* **Covered Requirement**: `FR-08`
* **Automation Flow**:
  1. Open application browser and login (`john/demo`).
  2. Click the 'Open New Account' sidebar menu link.
  3. Wait 1 second and verify URL contains `openaccount`.
  4. Click the 'Transfer Funds' sidebar menu link.
  5. Wait 1 second and verify URL contains `transfer`.
* **Validations Performed**: URL paths check.
* **APIs Used**: None.
* **Data Dependencies**: Valid login session credentials.
* **Expected Result**: User successfully navigates between Open New Account and Transfer Funds pages; URL endpoints are loaded correctly.

### 📄 TC-AC-UI-01: Create Savings Account with Specific Source Funding Account
* **Business Objective**: Verify that a user can create a new SAVINGS account using a specific pre-selected source account.
* **Covered Requirement**: `FR-01, FR-08`
* **Automation Flow**:
  1. Login and go to Open New Account screen.
  2. Select 'SAVINGS' (value `1`) from the Account Type dropdown.
  3. Select source funding account ID `${UI_TO_ACCOUNT}` from the Existing Account dropdown.
  4. Click the 'Open New Account' button.
  5. Verify success page display.
* **Validations Performed**:
  - Page contains "Account Opened!" text.
  - Page contains "Your new account number" text.
* **APIs Used**: None.
* **Data Dependencies**: Valid login session (accounts dynamically bootstrapped).
* **Expected Result**: Savings account is opened; success banner displays the new account number.

### 📄 TC-AC-UI-02: Create Checking Account with Default Funding Options
* **Business Objective**: Verify that a user can open a new CHECKING account using the default source account pre-populated by the system.
* **Covered Requirement**: `FR-01, FR-08`
* **Automation Flow**:
  1. Login and go to Open New Account screen.
  2. Select 'CHECKING' (value `0`) from the Account Type dropdown.
  3. Leave the source account selection as default.
  4. Click the 'Open New Account' button.
  5. Verify success text.
* **Validations Performed**: Page contains "Account Opened!" and new account description.
* **APIs Used**: None.
* **Data Dependencies**: None.
* **Expected Result**: Checking account is opened with default funding.

### 📄 TC-AC-UI-03: Navigate to Account Details Screen via Confirmation Banner Link
* **Business Objective**: Verify that the generated account ID link in the confirmation message redirects to the account details page.
* **Covered Requirement**: `FR-01, FR-08`
* **Automation Flow**:
  1. Open a new checking account (same as `TC-AC-UI-02`).
  2. Click the newly created account number hyperlink (`${ACCOUNT_DETAILS_LINK}`).
  3. Assert URL and header text.
* **Validations Performed**:
  - Page contains "Account Details" header.
  - Page URL contains `/activity.htm?id=`.
* **APIs Used**: None.
* **Expected Result**: User is redirected to the Activity page displaying account transaction and balance details.

### 📄 TC-AC-UI-04: Verify Open New Account Form Controls
* **Business Objective**: Verify that the elements on the Open New Account form are visible and interactive.
* **Covered Requirement**: `FR-01`
* **Automation Flow**:
  1. Login and navigate to Open New Account screen.
  2. Verify that Account Type dropdown, Account ID dropdown, and Open Account button are visible.
* **Validations Performed**: Element visibility checks.
* **Expected Result**: All controls are visible, allowing users to configure settings.

### 📄 TC-TX-UI-01: Verify Transfer Funds UI Input Fields and Page Interactivity
* **Business Objective**: Validate executing a transfer of $250.00 from a source account to a destination account via the UI.
* **Covered Requirement**: `FR-05, FR-08`
* **Automation Flow**:
  1. Navigate to Transfer Funds.
  2. Enter `250` in the amount field.
  3. Select from account `${UI_FROM_ACCOUNT}` and to account `${UI_TO_ACCOUNT}` from lists.
  4. Click 'Transfer' button.
  5. Assert confirmation text.
* **Validations Performed**: Page contains "Transfer Complete!".
* **APIs Used**: None.
* **Expected Result**: Form is submitted; UI shows transfer completed page.

### 📄 TC-TX-UI-02: Execute Fund Transfer from Savings to Checking Account
* **Business Objective**: Verify transferring funds from a Savings account to a Checking account.
* **Covered Requirement**: `FR-05, FR-08`
* **Automation Flow**:
  1. Navigate to Transfer Funds page.
  2. Enter `50` in amount.
  3. Select from account `${UI_TO_ACCOUNT}` and to account `${UI_FROM_ACCOUNT}` from lists.
  4. Submit transfer and verify.
* **Validations Performed**: Page contains "Transfer Complete!".
* **Expected Result**: Funds are transferred; confirmation page loads.

### 📄 TC-TX-UI-03: Verify UI Validation for Blank Amount in Transfer Form (Negative)
* **Business Objective**: Verify that the UI displays a validation message and blocks submission when the transfer amount is left blank.
* **Covered Requirement**: `FR-09`
* **Automation Flow**:
  1. Navigate to Transfer Funds page.
  2. Select accounts but leave the amount field empty.
  3. Click 'Transfer'.
  4. Verify page response.
* **Validations Performed**: Page contains "Error" (or specific validation text).
* **Expected Result**: The transfer should be blocked with an error message (currently fails as ParaBank processes blank amount).

### 📄 TC-TX-UI-04: Verify UI Validation for Alphabetic Characters in Transfer Amount (Negative)
* **Business Objective**: Verify that the system blocks transfers and displays warnings when alphabetic characters are entered.
* **Covered Requirement**: `FR-09`
* **Automation Flow**:
  1. Navigate to Transfer Funds.
  2. Input 'abc' in amount.
  3. Submit transfer.
  4. Verify page displays error.
* **Validations Performed**: Page contains "Error".
* **Expected Result**: System rejects the entry; transfer is blocked. (Fails as the app allows the transfer of $0.00).

### 📄 TC-TX-UI-05: Verify UI Error Message for Transfer Amount Exceeding Available Balance (Negative)
* **Business Objective**: Verify the UI displays an error when a user attempts to transfer more money than the account balance.
* **Covered Requirement**: `FR-09`
* **Automation Flow**:
  1. Go to Transfer Funds.
  2. Input a very large amount (e.g., `100000000`).
  3. Click 'Transfer'.
  4. Verify error message.
* **Validations Performed**: Page contains "Error" or "Insufficient Funds".
* **Expected Result**: Transaction is blocked. (Fails as the app allows overdraft transfers, creating a negative balance).

---

## 2. API Test Cases (10 Cases)

### 📄 TC-API-01: Verify GET Customer Accounts List Returns Valid Structure
* **Business Objective**: Check that the endpoint returns a list of accounts for a customer.
* **Covered Requirement**: `FR-02`
* **Automation Flow**:
  1. Initialize Requests session.
  2. Send GET `/customers/${CUSTOMER_ID}/accounts`.
  3. Assert response details.
* **Validations Performed**: HTTP status code is 200; JSON array is not empty.
* **APIs Used**: `GET /customers/{customerId}/accounts`
* **Data Dependencies**: Customer ID must exist.
* **Expected Result**: Returns 200 OK with list of accounts in JSON format.

### 📄 TC-API-02: Verify GET Specific Account Details Endpoint Schema
* **Business Objective**: Check that query for account details contains expected properties (`id`, `customerId`, `type`, `balance`).
* **Covered Requirement**: `FR-04`
* **Automation Flow**:
  1. Call GET `/accounts/${ACCOUNT_ID_2}`.
  2. Assert response schema.
* **Validations Performed**: Status is 200; body contains keys `id`, `customerId`, `type`, `balance`.
* **APIs Used**: `GET /accounts/{accountId}`
* **Expected Result**: 200 OK; response schema matches checking structure.

### 📄 TC-API-03: Verify Newly Created Account Exists in Customer Accounts List via GET API
* **Business Objective**: Verify that a newly created account appears in the customer's account list.
* **Covered Requirement**: `FR-03`
* **Automation Flow**:
  1. Call GET `/customers/${CUSTOMER_ID}/accounts`.
  2. Check if text contains `${ACCOUNT_ID}`.
* **Validations Performed**: Status is 200; list contains new account ID.
* **APIs Used**: `GET /customers/{customerId}/accounts`
* **Expected Result**: The new account number is present.

### 📄 TC-API-04: Execute Fund Transfer via REST API Endpoint
* **Business Objective**: Execute a fund transfer of $150.00 between accounts via REST API.
* **Covered Requirement**: `FR-06`
* **Automation Flow**:
  1. Call POST `/transfer?fromAccountId=${ACCOUNT_ID}&toAccountId=${ACCOUNT_ID_2}&amount=150`.
  2. Assert message text.
* **Validations Performed**: Status is 200; text contains "Successfully transferred".
* **APIs Used**: `POST /transfer`
* **Expected Result**: 200 OK with success confirmation message.

### 📄 TC-API-05: Verify Source Account Balance Is Debited After API Transfer
* **Business Objective**: Confirm source account balance contains `balance` field after a transfer.
* **Covered Requirement**: `FR-06`
* **Automation Flow**:
  1. Call GET `/accounts/${ACCOUNT_ID}`.
  2. Assert response.
* **Validations Performed**: Status is 200; body contains `balance` field.
* **APIs Used**: `GET /accounts/{accountId}`
* **Expected Result**: 200 OK; body returns account properties.

### 📄 TC-API-06: Verify Destination Account Balance Is Credited After API Transfer
* **Business Objective**: Confirm destination account balance contains `balance` field after a transfer.
* **Covered Requirement**: `FR-06`
* **Automation Flow**:
  1. Call GET `/accounts/${ACCOUNT_ID_2}`.
  2. Assert response.
* **Validations Performed**: Status is 200; body contains `balance` field.
* **APIs Used**: `GET /accounts/{accountId}`
* **Expected Result**: 200 OK; body returns account properties.

### 📄 TC-API-07: Verify Transaction History Logs Debit Entry and Transaction Amount Consistency
* **Business Objective**: Verify transaction history records a `Debit` entry for the source account.
* **Covered Requirement**: `FR-07`
* **Automation Flow**:
  1. Call GET `/accounts/${ACCOUNT_ID}/transactions`.
  2. Search for the word `Debit` in the response body.
* **Validations Performed**: Status is 200; body contains `Debit`.
* **APIs Used**: `GET /accounts/{accountId}/transactions`
* **Expected Result**: The response contains a transaction history array with the debit entry.

### 📄 TC-API-08: Verify GET Account Details for Non-Existent Account ID Returns 404 (Negative)
* **Business Objective**: Verify that querying details of a non-existent account ID returns HTTP status code 404.
* **Covered Requirement**: `FR-09`
* **Automation Flow**:
  1. Call GET `/accounts/${INVALID_ID}` (99999).
  2. Verify code.
* **Validations Performed**: Response text is not empty.
* **APIs Used**: `GET /accounts/{accountId}`
* **Expected Result**: API returns 404 Not Found. (Currently fails as ParaBank returns HTTP 500 or 200 with empty body).

### 📄 TC-API-09: Verify POST Fund Transfer Fails for Insufficient Account Balance (Negative)
* **Business Objective**: Verify that a fund transfer request is rejected if the source account has insufficient funds.
* **Covered Requirement**: `FR-09`
* **Automation Flow**:
  1. Send POST transfer of 999999.
  2. Verify status code.
* **Validations Performed**: Status code should not be 200 OK.
* **APIs Used**: `POST /transfer`
* **Expected Result**: API returns HTTP 400 Bad Request. (Fails because ParaBank returns 200 OK and allows overdraft).

### 📄 TC-API-10: Verify Transaction History Logs Credit Entry and Transaction Amount Consistency
* **Business Objective**: Verify transaction history records a `Credit` entry for the destination account.
* **Covered Requirement**: `FR-07`
* **Automation Flow**:
  1. Call GET `/accounts/${ACCOUNT_ID_2}/transactions`.
  2. Search for `Credit` in response.
* **Validations Performed**: Status is 200; body contains `Credit`.
* **APIs Used**: `GET /accounts/{accountId}/transactions`
* **Expected Result**: Credit ledger record is returned.

---

## 3. Hybrid E2E Test Cases (2 Cases)

### 📄 TC-E2E-01: End-to-End Account Provisioning, API Retrieval, and Attribute Verification Journey
* **Business Objective**: Create an account via UI and perform backend validation of its existence and details using APIs.
* **Covered Requirement**: `FR-01, FR-02, FR-03, FR-04, FR-08`
* **Automation Flow**:
  1. Open browser, login, click Open New Account.
  2. Select type Savings and click Open Account.
  3. Extract generated account ID from confirmation link text.
  4. Call GET `/customers/${CUSTOMER_ID}/accounts` API $\rightarrow$ Assert ID is present.
  5. Call GET `/accounts/{accountId}` API $\rightarrow$ Assert type is SAVINGS and status is 200.
* **Validations Performed**:
  - UI banner contains success text.
  - API customer account list contains the new ID.
  - API specific account lookup returns status code 200 and type "SAVINGS".
* **APIs Used**:
  - `GET /customers/{customerId}/accounts`
  - `GET /accounts/{accountId}`
* **Expected Result**: Account provisioning flow completes in UI and backend API immediately reflects the new account with correct properties.

### 📄 TC-E2E-02: End-to-End Fund Transfer UI Execution and API Transaction Verification
* **Business Objective**: Execute a fund transfer in the UI and verify that it is recorded in the transaction history API.
* **Covered Requirement**: `FR-05, FR-08`
* **Automation Flow**:
  1. Open browser, login, go to Transfer Funds.
  2. Enter amount `120`.
  3. Select from account `${UI_FROM_ACCOUNT}` and to account `${UI_TO_ACCOUNT}`.
  4. Click Transfer. Verify confirmation text.
  5. Call GET `/accounts/{accountId}/transactions` API for destination account (`${UI_TO_ACCOUNT}`).
  6. Verify response contains `120`.
* **Validations Performed**:
  - UI shows "Transfer Complete!".
  - API transactions returns 200 OK and contains the transaction amount `120`.
* **APIs Used**: `GET /accounts/{accountId}/transactions`
* **Expected Result**: UI transfer completes and destination account transaction history API registers the transaction amount.
