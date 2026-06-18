# Document 5 - Tagging Strategy Documentation

This document outlines the tagging analysis of the ParaBank QA Automation suite, identifies critical gaps in the current implementation, and provides a recommended tagging structure to enable selective test execution, reporting, and requirement traceability.

---

## 1. Analysis of Existing Tags

In the current codebase, the tagging implementation is extremely sparse:
* **API Tests (`tests/api/`)**: Every test case (`TC-API-01` to `TC-API-10`) is labeled with `[Tags] api`.
* **UI Tests (`tests/ui/`)**: No test cases have any tags defined.
* **E2E Tests (`tests/e2e/`)**: No test cases have any tags defined.

### Identified Gaps:
1. **No Requirement Mappings**: Tests are not tagged with their corresponding Requirement ID (e.g., `@FR-01`, `@FR-09`), making dynamic requirements-based execution impossible.
2. **No Execution Level Categorization**: There are no tags for execution phases (e.g., `@smoke`, `@regression`, `@sanity`). In CI/CD pipelines, you cannot separate quick smoke tests from full regression runs.
3. **Inconsistent UI/E2E Labeling**: While API tests are tagged with `api`, UI tests and E2E tests are completely untagged, preventing execution filtering by channel (e.g., executing only UI tests via `robot -i ui tests/`).

---

## 2. Recommended Tagging Structure

To implement industry-standard QA practices, we recommend adopting the following tagging categories:

* **Execution Scope**:
  - `smoke`: Fast, critical paths (login navigation, basic account opening, basic transfer).
  - `regression`: Full verification of all functional capabilities, negative paths, and boundary conditions.
  - `sanity`: Core functionality check after deployments.
* **Functional Requirements (FR)**:
  - `FR-01` to `FR-09`: Directly maps tests to requirements for traceability.
* **Technology Channel**:
  - `ui`: Web-based browser tests.
  - `api`: REST API client tests.
  - `e2e`: Integrated multi-channel flows.
* **Severity/Priority**:
  - `critical`: Failure blocks major operations (E2E flows).
  - `high`: Core functionality failure (positive transfers).
  - `medium` / `low`: Edge cases or secondary views (navigation, invalid IDs).

---

## 3. Suite and Test Case Tag Mapping (Before/After)

Here is the recommended mapping of tags for every suite and test case, along with the rationale.

### 3.1 UI Test Cases (`tests/ui/`)

| Test Case ID | Test Case Name | Current Tags | Required Tags | Rationale |
| :--- | :--- | :--- | :--- | :--- |
| **TC-NAV-UI-01** | Verify Navigation Flow and Menu Link Integrity | *None* | `ui`, `regression`, `FR-08`, `medium` | Verifies page menu navigation; mapped to UI channel, regression suite, and validation of UI messages. |
| **TC-AC-UI-01** | Create Savings Account with Specific Source Funding | *None* | `ui`, `smoke`, `FR-01`, `FR-08`, `high` | Critical account provisioning path using specific data; included in Smoke. |
| **TC-AC-UI-02** | Create Checking Account with Default Options | *None* | `ui`, `regression`, `FR-01`, `FR-08`, `high` | Account provisioning using default funding options. |
| **TC-AC-UI-03** | Navigate to Account Details Screen via success Link | *None* | `ui`, `regression`, `FR-01`, `FR-08`, `high` | Verifies navigation link functionality from confirmation banner. |
| **TC-AC-UI-04** | Verify Open New Account Form Controls | *None* | `ui`, `sanity`, `FR-01`, `medium` | Simple sanity check for form layout and object load. |
| **TC-TX-UI-01** | Verify Transfer Funds UI Input Fields | *None* | `ui`, `smoke`, `FR-05`, `FR-08`, `high` | Standard UI fund transfer; verify interactivity and confirmation. |
| **TC-TX-UI-02** | Execute Fund Transfer from Savings to Checking | *None* | `ui`, `regression`, `FR-05`, `FR-08`, `high` | Validates standard transaction between checking and savings. |
| **TC-TX-UI-03** | Verify UI Validation for Blank Amount in Transfer Form | *None* | `ui`, `regression`, `FR-09`, `medium`, `negative` | Error validation check (Negative test case). |
| **TC-TX-UI-04** | Verify UI Validation for Alphabetic Characters | *None* | `ui`, `regression`, `FR-09`, `medium`, `negative` | Input validation check (Negative test case). |
| **TC-TX-UI-05** | Verify UI Error for Transfer Exceeding Balance | *None* | `ui`, `regression`, `FR-09`, `high`, `negative` | Overdraft validation check (Negative test case). |

### 3.2 API Test Cases (`tests/api/`)

| Test Case ID | Test Case Name | Current Tags | Required Tags | Rationale |
| :--- | :--- | :--- | :--- | :--- |
| **TC-API-01** | Verify GET Customer Accounts List Returns Valid Structure | `api` | `api`, `sanity`, `FR-02`, `high` | Simple sanity test to check account listing API. |
| **TC-API-02** | Verify GET Specific Account Details Endpoint Schema | `api` | `api`, `regression`, `FR-04`, `high` | Contract schema validation on response structure. |
| **TC-API-03** | Verify Newly Created Account Exists in List via GET API | `api` | `api`, `regression`, `FR-03`, `high` | Integrates account discovery in API list. |
| **TC-API-04** | Execute Fund Transfer via REST API Endpoint | `api` | `api`, `smoke`, `FR-06`, `high` | Basic REST transfer; included in Smoke suite. |
| **TC-API-05** | Verify Source Account Balance Is Debited After API Transfer | `api` | `api`, `regression`, `FR-06`, `high` | Verifies balance reduction after transfer. |
| **TC-API-06** | Verify Destination Account Balance Is Credited | `api` | `api`, `regression`, `FR-06`, `high` | Verifies balance increase after transfer. |
| **TC-API-07** | Verify Transaction History Logs Debit Entry | `api` | `api`, `regression`, `FR-07`, `high` | Verifies transaction log creation for debit. |
| **TC-API-08** | Verify GET Account Details for Non-Existent ID Returns 404 | `api` | `api`, `regression`, `FR-09`, `medium`, `negative` | Boundary error code test (Negative test case). |
| **TC-API-09** | Verify POST Fund Transfer Fails for Insufficient Balance | `api` | `api`, `regression`, `FR-09`, `high`, `negative` | Business limit check (Negative test case). |
| **TC-API-10** | Verify Transaction History Logs Credit Entry | `api` | `api`, `regression`, `FR-07`, `high` | Verifies transaction log creation for credit. |

### 3.3 Hybrid E2E Test Cases (`tests/e2e/`)

| Test Case ID | Test Case Name | Current Tags | Required Tags | Rationale |
| :--- | :--- | :--- | :--- | :--- |
| **TC-E2E-01** | End-to-End Account Provisioning Journey | *None* | `e2e`, `smoke`, `FR-01`, `FR-02`, `FR-03`, `FR-04`, `FR-08`, `critical` | Verifies full flow from UI account creation to API backend verification. |
| **TC-E2E-02** | End-to-End Fund Transfer UI and API Audit Journey | *None* | `e2e`, `smoke`, `FR-05`, `FR-06`, `FR-07`, `FR-08`, `critical` | Verifies UI transfer action immediately reflects in transaction API. |
