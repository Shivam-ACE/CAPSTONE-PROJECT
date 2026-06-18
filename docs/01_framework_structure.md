# Document 1 - Framework Structure Documentation

Welcome to the **ParaBank QA Automation Framework**! This document is designed for new team members, freshers, and QA reviewers to help them understand the codebase structure and individual file responsibilities without needing a manual knowledge transfer (KT) session.

---

## 1. Project Folder Structure

The project is structured according to automated testing best practices, utilizing the **Page Object Model (POM)** pattern, modular keywords, environment isolation, and clean separation of test scripts from test data.

```text
CAPSTONE/
│
├── config/                               # Configuration settings
│   ├── browser_config.yaml               # Multi-environment URLs and credentials
│   └── environment.py                    # Python helper to load environment YAML config
│
├── resources/                            # Reusable test components
│   ├── keywords/                         # High-level business keywords
│   │   ├── api_keywords.robot            # REST API action keywords (RequestsLibrary)
│   │   └── common_keywords.robot         # Browser setup, teardown, and login flow keywords
│   └── pages/                            # Page Object Model locators and actions (UI)
│       ├── home_page.robot               # Navigation menu bar page object
│       ├── open_new_account_page.robot   # Account creation page object
│       └── transfer_funds_page.robot     # Funds transfer page object
│
├── tests/                                # Test suite scripts
│   ├── api/                              # API regression suites (TC-API-01 to 10)
│   ├── ui/                               # UI regression suites (TC-AC-UI-* / TC-TX-UI-*)
│   └── e2e/                              # End-to-End integration hybrid suites (TC-E2E-*)
│
├── variables/                            # Static and dynamic selectors and test data
│   ├── api_variables.robot               # API URLs, customer IDs, and account IDs
│   ├── home_variables.robot              # Sidebar navigation link locators
│   ├── login_variables.robot             # Login page text fields and buttons locators
│   ├── open_new_account_variables.robot  # Form controls and success banner locators
│   └── transfer_funds_variables.robot    # Amount field, dropdowns, and submit button locators
│
├── reports/                              # Execution logs, output.xml, screenshots
├── Capstone.pdf                          # Project specifications (Source of Truth)
├── ParaBank_Final_Master_QA_Documentation.xlsx # Master QA Excel Workbook
└── requirements.txt                      # Project dependencies (libraries)
```

---

## 2. File-by-File Technical Explanations

Here is a detailed breakdown of every project file, outlining its technical role, dependencies, and requirement mappings.

### 2.1 Configuration Layer (`config/`)

#### 📄 [browser_config.yaml](file:///I:/CAPSTONE/config/browser_config.yaml)
* **Purpose**: Centralized storage for environment configurations. It stores the environment's base URL and user credentials for `qa`, `dev`, and `prod` stages.
* **Responsibility**: Houses environment variables to prevent hardcoding.
* **Dependencies**: None.
* **Related Requirements**: FR-01 through FR-09 (affects UI, API, and E2E execution).
* **Related Test Cases**: All test suites.

#### 📄 [environment.py](file:///I:/CAPSTONE/config/environment.py)
* **Purpose**: A Python helper library that parses the YAML configuration file and exposes a keyword (`Load Env`) to load parameters into Robot variables dynamically.
* **Responsibility**: Provides the bridge between YAML configurations and Robot Framework.
* **Dependencies**: Python standard library `os`, `yaml` package.
* **Related Requirements**: General framework setup.
* **Related Test Cases**: All UI and E2E suites.

---

### 2.2 Reusable Keywords Layer (`resources/keywords/`)

#### 📄 [api_keywords.robot](file:///I:/CAPSTONE/resources/keywords/api_keywords.robot)
* **Purpose**: Contains custom keywords for calling ParaBank's REST API using the `RequestsLibrary`.
* **Responsibility**: Encapsulates session initialization, accounts queries, POST transfers, and transaction retrieval.
* **Dependencies**: `RequestsLibrary`, `variables/api_variables.robot`.
* **Related Requirements**: FR-02, FR-03, FR-04, FR-06, FR-07, FR-09.
* **Related Test Cases**: `TC-API-01` to `TC-API-10`, `TC-E2E-01`, `TC-E2E-02`.

#### 📄 [common_keywords.robot](file:///I:/CAPSTONE/resources/keywords/common_keywords.robot)
* **Purpose**: Manages browser setup/teardown and login steps.
* **Responsibility**: Configures variables, launches browser context, logs in user, and closes sessions.
* **Dependencies**: `SeleniumLibrary`, `config/environment.py`, `variables/login_variables.robot`, `api_keywords.robot`.
* **Related Requirements**: FR-01, FR-05, FR-08.
* **Related Test Cases**: All UI and E2E tests.

---

### 2.3 Page Object Model Layer (`resources/pages/`)

#### 📄 [home_page.robot](file:///I:/CAPSTONE/resources/pages/home_page.robot)
* **Purpose**: Defines common sidebar links.
* **Responsibility**: Navigates to sections like "Open New Account" or "Transfer Funds".
* **Dependencies**: `SeleniumLibrary`, `variables/home_variables.robot`.
* **Related Requirements**: FR-08 (UI Navigation/Messages).
* **Related Test Cases**: `TC-NAV-UI-01`, `TC-AC-UI-01` to `04`, `TC-TX-UI-01` to `05`.

#### 📄 [open_new_account_page.robot](file:///I:/CAPSTONE/resources/pages/open_new_account_page.robot)
* **Purpose**: Page object for the account provisioning screen.
* **Responsibility**: Handles dropdown selection (Checking/Savings), source account linking, and extracting the new account number from the UI banner.
* **Dependencies**: `SeleniumLibrary`, `variables/open_new_account_variables.robot`.
* **Related Requirements**: FR-01, FR-08.
* **Related Test Cases**: `TC-AC-UI-01` to `04`, `TC-E2E-01`.

#### 📄 [transfer_funds_page.robot](file:///I:/CAPSTONE/resources/pages/transfer_funds_page.robot)
* **Purpose**: Page object for the funds transfer screen.
* **Responsibility**: Inputs transfer amount, selects source/destination accounts, and clicks submit.
* **Dependencies**: `SeleniumLibrary`, `variables/transfer_funds_variables.robot`.
* **Related Requirements**: FR-05, FR-08.
* **Related Test Cases**: `TC-TX-UI-01` to `05`, `TC-E2E-02`.

---

### 2.4 Variables Layer (`variables/`)

#### 📄 [api_variables.robot](file:///I:/CAPSTONE/variables/api_variables.robot)
* **Purpose**: Stores base URL path (`/parabank/services/bank`) and default test account data (`${CUSTOMER_ID}`, `${ACCOUNT_ID}`, `${ACCOUNT_ID_2}`).
* **Responsibility**: Centralizes test data for REST API endpoints.

#### 📄 [home_variables.robot](file:///I:/CAPSTONE/variables/home_variables.robot)
* **Purpose**: XPath locators for the sidebar menu navigation.

#### 📄 [login_variables.robot](file:///I:/CAPSTONE/variables/login_variables.robot)
* **Purpose**: XPaths for login input controls (username, password fields, submit button).

#### 📄 [open_new_account_variables.robot](file:///I:/CAPSTONE/variables/open_new_account_variables.robot)
* **Purpose**: Locators on the open account screen (`#type` dropdown, `#fromAccountId`, new account confirmation link).

#### 📄 [transfer_funds_variables.robot](file:///I:/CAPSTONE/variables/transfer_funds_variables.robot)
* **Purpose**: Locators on the transfer screen (`#amount`, `#fromAccountId`, `#toAccountId`, submit input).

---

### 2.5 Test Suites Layer (`tests/`)

#### 📂 [tests/ui/](file:///I:/CAPSTONE/tests/ui)
* **Purpose**: Houses UI validation tests.
* **Responsibility**: Exercises browser paths for navigation, account creation, and fund transfer, verifying UI success banners or error messages.
* **Dependencies**: `SeleniumLibrary`, `resources/keywords/common_keywords.robot`, pages layer.
* **Files**: `TC-NAV-UI-01.robot`, `TC-AC-UI-01.robot` to `04.robot`, `TC-TX-UI-01.robot` to `05.robot`.

#### 📂 [tests/api/](file:///I:/CAPSTONE/tests/api)
* **Purpose**: Houses API contract and function validation tests.
* **Responsibility**: Verifies JSON payload structure, schemas, status codes, balance debits/credits, and transaction history.
* **Dependencies**: `RequestsLibrary`, `resources/keywords/api_keywords.robot`.
* **Files**: `TC-API-01.robot` to `10.robot`.

#### 📂 [tests/e2e/](file:///I:/CAPSTONE/tests/e2e)
* **Purpose**: Houses hybrid end-to-end integration tests.
* **Responsibility**: Executes action in UI, captures output IDs, and immediately asserts state updates via REST API calls.
* **Dependencies**: `SeleniumLibrary`, `RequestsLibrary`, common resource libraries.
* **Files**: `TC-E2E-01.robot`, `TC-E2E-02.robot`.
