# Document 2 - Test Suite Documentation

This document describes the test suites defined in this project. Each suite corresponds to a specific testing folder (`tests/ui`, `tests/api`, `tests/e2e`) containing modular `.robot` files.

---

## 1. UI Test Suite (`tests/ui/`)

* **Suite Name**: `tests/ui` (UI Regression Suite)
* **Purpose**: Validates the visual interface, navigation, forms, dropdown selections, input validation, and user flows on the ParaBank portal.
* **Covered Business Flow**:
  1. Login and Sidebar Navigation.
  2. Account Creation (Checking / Savings) with default and specific source funding accounts.
  3. Navigation from confirmation banners to detail pages.
  4. Form controls verification.
  5. Fund Transfer execution between Savings/Checking accounts.
  6. Boundary limits, blank fields, and alphabetic input error validations on the Transfer form.
* **Related Requirements**: `FR-01`, `FR-05`, `FR-08`, `FR-09`.
* **Related Test Cases**: `TC-NAV-UI-01`, `TC-AC-UI-01`, `TC-AC-UI-02`, `TC-AC-UI-03`, `TC-AC-UI-04`, `TC-TX-UI-01`, `TC-TX-UI-02`, `TC-TX-UI-03`, `TC-TX-UI-04`, `TC-TX-UI-05`.
* **Entry Criteria**:
  - Web browser (Chrome/Chromium) is available in headless mode.
  - ParaBank UI is reachable (`https://parabank.parasoft.com`).
  - Active login credentials (`john/demo`) are configured in `browser_config.yaml`.
* **Exit Criteria**:
  - All 10 UI tests executed.
  - Screenshots are captured on failures.
  - Test results are logged in `reports/output.xml`.

---

## 2. API Test Suite (`tests/api/`)

* **Suite Name**: `tests/api` (REST API Regression Suite)
* **Purpose**: Validates the REST API endpoints of ParaBank for data structures, schemas, validation logic, and transaction ledger consistency.
* **Covered Business Flow**:
  1. Retrieve all accounts for a customer.
  2. Query specific account details and assert JSON properties (`id`, `customerId`, `type`, `balance`).
  3. Validate if a newly created account number is present in the customer account list.
  4. Execute a transfer between accounts via POST request.
  5. Query source and destination accounts to check if balances debited/credited.
  6. Inspect transaction ledger records to check for correct Debit/Credit entries and transfer amount consistency.
  7. Verify error response structures for invalid IDs and insufficient balances.
* **Related Requirements**: `FR-02`, `FR-03`, `FR-04`, `FR-06`, `FR-07`, `FR-09`.
* **Related Test Cases**: `TC-API-01`, `TC-API-02`, `TC-API-03`, `TC-API-04`, `TC-API-05`, `TC-API-06`, `TC-API-07`, `TC-API-08`, `TC-API-09`, `TC-API-10`.
* **Entry Criteria**:
  - API endpoints are reachable (`https://parabank.parasoft.com/parabank/services/bank`).
  - `RequestsLibrary` is installed.
  - Default IDs (`CUSTOMER_ID`, `ACCOUNT_ID`, `ACCOUNT_ID_2`) are defined.
* **Exit Criteria**:
  - All 10 API tests executed.
  - Response payloads and HTTP codes logged in console.
  - Fails identified for incorrect API validations (`TC-API-08`, `TC-API-09`).

---

## 3. End-to-End Integration Suite (`tests/e2e/`)

* **Suite Name**: `tests/e2e` (Hybrid E2E Integration Suite)
* **Purpose**: Verifies integration and data consistency across both UI and API layers.
* **Covered Business Flow**:
  1. **Flow 1 (Account Provisioning E2E)**: Create account in UI $\rightarrow$ Extract new ID $\rightarrow$ Query GET API for customer accounts and assert ID exists $\rightarrow$ Query specific GET account API and assert type is SAVINGS and balance matches.
  2. **Flow 2 (Fund Transfer E2E)**: Perform fund transfer in UI $\rightarrow$ Query transactions GET API for the destination account $\rightarrow$ Assert transaction history contains the transfer transaction record with the exact amount.
* **Related Requirements**: `FR-01`, `FR-02`, `FR-03`, `FR-04`, `FR-05`, `FR-06`, `FR-07`, `FR-08`.
* **Related Test Cases**: `TC-E2E-01`, `TC-E2E-02`.
* **Entry Criteria**:
  - Both UI browser context and API Requests session can be established.
  - Shared global variables and configs are loaded.
* **Exit Criteria**:
  - E2E tests are executed successfully.
  - Data transfer consistency between UI actions and API ledger verified.

---

## 4. Test Suite Mapping Matrix

| Robot Suite Folder | Robot Test File | Covered Requirement(s) | Linked Excel Test Case | Execution Status |
| :--- | :--- | :--- | :--- | :--- |
| `tests/ui` | `TC-NAV-UI-01.robot` | `FR-08` | `TC-NAV-UI-01` | **PASS** |
| `tests/ui` | `TC-AC-UI-01.robot` | `FR-01, FR-08` | `TC-AC-UI-01` | **PASS** |
| `tests/ui` | `TC-AC-UI-02.robot` | `FR-01, FR-08` | `TC-AC-UI-02` | **PASS** |
| `tests/ui` | `TC-AC-UI-03.robot` | `FR-01, FR-08` | `TC-AC-UI-03` | **PASS** |
| `tests/ui` | `TC-AC-UI-04.robot` | `FR-01` | `TC-AC-UI-04` | **PASS** (Aligned) |
| `tests/ui` | `TC-TX-UI-01.robot` | `FR-05, FR-08` | `TC-TX-UI-01` | **PASS** |
| `tests/ui` | `TC-TX-UI-02.robot` | `FR-05, FR-08` | `TC-TX-UI-02` | **PASS** |
| `tests/ui` | `TC-TX-UI-03.robot` | `FR-09` | `TC-TX-UI-03` | **FAIL** (BUG-003) |
| `tests/ui` | `TC-TX-UI-04.robot` | `FR-09` | `TC-TX-UI-04` | **FAIL** (BUG-006) |
| `tests/ui` | `TC-TX-UI-05.robot` | `FR-09` | `TC-TX-UI-05` | **FAIL** (BUG-002) |
| `tests/api` | `TC-API-01.robot` | `FR-02` | `TC-API-01` | **PASS** |
| `tests/api` | `TC-API-02.robot` | `FR-04` | `TC-API-02` | **PASS** |
| `tests/api` | `TC-API-03.robot` | `FR-03` | `TC-API-03` | **PASS** |
| `tests/api` | `TC-API-04.robot` | `FR-06` | `TC-API-04` | **PASS** |
| `tests/api` | `TC-API-05.robot` | `FR-06` | `TC-API-05` | **PASS** |
| `tests/api` | `TC-API-06.robot` | `FR-06` | `TC-API-06` | **PASS** |
| `tests/api` | `TC-API-07.robot` | `FR-07` | `TC-API-07` | **PASS** |
| `tests/api` | `TC-API-08.robot` | `FR-09` | `TC-API-08` | **FAIL** (BUG-001) |
| `tests/api` | `TC-API-09.robot` | `FR-09` | `TC-API-09` | **FAIL** (BUG-004) |
| `tests/api` | `TC-API-10.robot` | `FR-07` | `TC-API-10` | **PASS** |
| `tests/e2e` | `TC-E2E-01.robot` | `FR-01, FR-02, FR-03, FR-04, FR-08` | `TC-E2E-01` | **PASS** |
| `tests/e2e` | `TC-E2E-02.robot` | `FR-05, FR-08` | `TC-E2E-02` | **PASS** |
