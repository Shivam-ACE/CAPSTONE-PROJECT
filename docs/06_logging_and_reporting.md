# Document 6 - Logging and Reporting Documentation

This document evaluates the current logging and reporting implementation in the ParaBank QA Automation codebase. It details what is captured during runs, highlights visibility gaps, and provides specific code-level recommendations to ensure freshers can debug failures quickly.

---

## 1. Analysis of Current Logging and Reporting

### 1.1 Console Output & Log Statements
* **API Tests**: The API tests use `Log To Console ${response.text}` or `Log To Console ${body}` to print raw response content.
  - *Gap*: While the JSON is printed, there are no introductory context statements (e.g., "Sending GET request to query account 13344..."). A fresher reading the terminal will see raw JSON blobs and won't know which request produced what output.
* **UI & E2E Tests**: The UI and E2E tests have **zero log statements** in their test files. They rely entirely on SeleniumLibrary's standard error traces when an element locator is not found.
  - *Gap*: No tracking of user navigation steps (e.g., "Clicking on Open New Account link..."). If a test hangs or fails mid-way, the logs don't tell you which step was executing when it failed.

### 1.2 Screenshot Capture on Failure
* **UI Tests**: The test teardown runs `Close Application`, which closes the browser. The `SeleniumLibrary` automatically takes a screenshot when a keyword fails (e.g., `Page Should Contain` or `Click Element` fails) and saves it to the output directory (e.g., `selenium-screenshot-1.png`).
  - *Gap*: Screenshots are named generically (`selenium-screenshot-X.png`) and are placed in the root of the reports directory. It is difficult to map which screenshot corresponds to which test case unless you parse the HTML report.

### 1.3 Fresher's Debugging Perspective
If a test fails in the CI pipeline tomorrow:
* **API Failure**: A fresher will see a assertion traceback (e.g., `200 != 500` or `Should Contain` failed). They will have to dig through the raw HTML report to find the request details.
* **UI Failure**: A fresher will see `Element 'xpath=...' not visible after 5 seconds`. Without contextual step logging, they cannot quickly tell whether the failure happened during login, navigation, or form submission.

---

## 2. File-by-File Logging Audit and Recommendations

Here is the current state and recommended logging improvements for key files.

### 2.1 Reusable Keywords and Pages (`resources/`)

#### 📄 [resources/keywords/api_keywords.robot](file:///I:/CAPSTONE/resources/keywords/api_keywords.robot)
* **Current Logging**: Raw response details are returned, but not explicitly logged before/after.
* **Missing Logging**: Log requests (endpoint, parameters, headers) before sending, and log response status codes with context.
* **Recommended Code Injection**:
  - In `Get Customer Accounts`:
    ```robot
    Log    Sending GET request for Customer ID: ${customerId}    level=INFO
    ${response}=    GET On Session    parabank    /customers/${customerId}/accounts
    Log    Received response with status: ${response.status_code}    level=INFO
    ```
  - In `Transfer Funds API`:
    ```robot
    Log    Initiating API transfer of $${amount} from ${fromAccountId} to ${toAccountId}    level=INFO
    ${q_params}=   Create Dictionary    fromAccountId=${fromAccountId}    toAccountId=${toAccountId}    amount=${amount}
    ${response}=    POST On Session    parabank    /transfer    params=${q_params}
    Log    Transfer API response status: ${response.status_code}, Body: ${response.text}    level=INFO
    ```

#### 📄 [resources/pages/open_new_account_page.robot](file:///I:/CAPSTONE/resources/pages/open_new_account_page.robot)
* **Current Logging**: Only prints `Account ID = ${account_id}` inside `Get New Account Number`.
* **Missing Logging**: User selections and actions are untracked.
* **Recommended Code Injection**:
  - In `Select Account Type`:
    ```robot
    Log    Selecting account type: ${account_type} (0=Checking, 1=Savings)    level=INFO
    Select From List By Value    ${ACCOUNT_TYPE_DROPDOWN}    ${account_type}
    ```
  - In `Select Account ID`:
    ```robot
    Log    Selecting funding source account: ${account_id}    level=INFO
    Select From List By Value    ${ACCOUNT_ID_DROPDOWN}    ${account_id}
    ```

#### 📄 [resources/pages/transfer_funds_page.robot](file:///I:/CAPSTONE/resources/pages/transfer_funds_page.robot)
* **Current Logging**: None.
* **Missing Logging**: Log input fields and submit actions.
* **Recommended Code Injection**:
  - In `Enter Amount`:
    ```robot
    Log    Entering transfer amount: ${amount}    level=INFO
    Input Text    ${AMOUNT_FIELD}    ${amount}
    ```
  - In `Click Transfer Button`:
    ```robot
    Log    Clicking Transfer button to execute transaction    level=INFO
    Click Element    ${TRANSFER_BUTTON}
    ```

---

### 2.2 Test Suite Files (`tests/`)

#### 📂 [tests/ui/](file:///I:/CAPSTONE/tests/ui)
* **Current Logging**: Standard test execution steps are untracked.
* **Recommended Action**: Insert descriptive log markers inside the test cases to show progress.
* **Example in `TC-AC-UI-01.robot`**:
  ```robot
  TC-AC-UI-01
      [Documentation]    Create Savings Account with Specific Source Funding Account
      Log    Step 1: Navigating to Open New Account screen    level=INFO
      Click Open New Account
      Sleep    1s
      Location Should Contain    openaccount
      
      Log    Step 2: Selecting Savings type and source account ${UI_TO_ACCOUNT}    level=INFO
      Select Account Type    1
      Select Account ID    ${UI_TO_ACCOUNT}
      Sleep    1s
      
      Log    Step 3: Submitting open account request    level=INFO
      Click Open Account Button
      
      Log    Step 4: Asserting success confirmation banner    level=INFO
      Page Should Contain    Account Opened!
  ```

#### 📂 [tests/api/](file:///I:/CAPSTONE/tests/api)
* **Current Logging**: Prints raw body with no structure.
* **Recommended Action**: Format console logs with descriptive prefixes.
* **Example in `TC-API-01.robot`**:
  ```robot
  TC_API_01
      [Documentation]    Verify GET Customer Accounts List Returns Valid Structure
      Log To Console    \n[API Test] Requesting account list for Customer: ${CUSTOMER_ID}
      ${response}=    Get Customer Accounts    ${CUSTOMER_ID}
      Verify Response Code    ${response}    200
      ${body}=    Set Variable    ${response.json()}
      Log To Console    [API Test] Response JSON Accounts: ${body}
      Should Not Be Empty    ${body}
  ```

---

## 3. Reporting Enhancements

To make failures easy to analyze, the following configuration enhancements should be added to the execution runner:

1. **Custom Screenshot Names on Failure**:
   Use SeleniumLibrary's register keyword to call `Capture Page Screenshot` with custom names:
   `Capture Page Screenshot    reports/failure_${TEST_NAME}.png`
2. **Allure Report Integration Metadata**:
   Add description and issue tags to Robot cases to link directly to defect reports:
   - For `TC-TX-UI-03.robot`:
     `[Tags]    regression    ui    FR-09    defect:BUG-003`
   - This metadata displays clearly on the Allure dashboard under the "Behaviors" and "Defects" tabs.
