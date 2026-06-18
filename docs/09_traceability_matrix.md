# Document 9 - Automation Coverage Matrix

This document provides a complete end-to-end requirement traceability mapping from the source of truth (PDF Requirements) to Excel deliverables and the actual Robot Framework automation suite implementation.

---

## 1. End-to-End Traceability Matrix

$$\text{Functional Requirement (FR ID)} \rightarrow \text{Excel Test Case ID} \rightarrow \text{Robot Suite File} \rightarrow \text{Robot Test Case Name} \rightarrow \text{Keywords Executed}$$

| Req ID | Requirement Description | Linked Excel TC | Robot Suite File | Robot Test Case Name | Custom/Robot Keywords Executed |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **FR-01** | Create new account via UI | `TC-AC-UI-01`<br>`TC-AC-UI-02`<br>`TC-AC-UI-03`<br>`TC-AC-UI-04`<br>`TC-E2E-01` | `TC-AC-UI-01.robot`<br>`TC-AC-UI-02.robot`<br>`TC-AC-UI-03.robot`<br>`TC-AC-UI-04.robot`<br>`TC-E2E-01.robot` | `TC-AC-UI-01`<br>`TC-AC-UI-02`<br>`TC-AC-UI-03`<br>`TC-AC-UI-04`<br>`TC-E2E-01` | `Click Open New Account`, `Select Account Type`, `Select Account ID`, `Click Open Account Button`, `Click Account Details Link`, `Get New Account Number` |
| **FR-02** | GET accounts list via API | `TC-API-01`<br>`TC-E2E-01` | `TC-API-01.robot`<br>`TC-E2E-01.robot` | `TC_API_01`<br>`TC-E2E-01` | `Get Customer Accounts`, `Verify Response Code`, `Should Not Be Empty` |
| **FR-03** | Validate new account exists in API | `TC-API-03`<br>`TC-E2E-01` | `TC-API-03.robot`<br>`TC-E2E-01.robot` | `TC_API_03`<br>`TC-E2E-01` | `Get Customer Accounts`, `Verify Response Code`, `Should Contain` |
| **FR-04** | Validate account type and details in API | `TC-API-02`<br>`TC-E2E-01` | `TC-API-02.robot`<br>`TC-E2E-01.robot` | `TC_API_02`<br>`TC-E2E-01` | `Get Account Details`, `Verify Response Code`, `Should Contain` |
| **FR-05** | Transfer funds via UI | `TC-TX-UI-01`<br>`TC-TX-UI-02`<br>`TC-E2E-02` | `TC-TX-UI-01.robot`<br>`TC-TX-UI-02.robot`<br>`TC-E2E-02.robot` | `TC-TX-UI-01`<br>`TC-TX-UI-02`<br>`TC-E2E-02` | `Click Transfer Funds`, `Enter Amount`, `Select From Account`, `Select To Account`, `Click Transfer Button` |
| **FR-06** | Validate updated balances using API | `TC-API-04`<br>`TC-API-05`<br>`TC-API-06`<br>`TC-E2E-02` | `TC-API-04.robot`<br>`TC-API-05.robot`<br>`TC-API-06.robot`<br>`TC-E2E-02.robot` | `TC_API_04`<br>`TC_API_05`<br>`TC_API_06`<br>`TC-E2E-02` | `Transfer Funds API`, `Get Account Details`, `Verify Response Code`, `Should Contain` |
| **FR-07** | Validate transfer applied correctly (ledger) | `TC-API-07`<br>`TC-API-10`<br>`TC-E2E-02` | `TC-API-07.robot`<br>`TC-API-10.robot`<br>`TC-E2E-02.robot` | `TC_API_07`<br>`TC_API_10`<br>`TC-E2E-02` | `Get Account Transactions`, `Verify Response Code`, `Should Contain` |
| **FR-08** | Validate UI messages (success, confirmation) | `TC-NAV-UI-01`<br>`TC-AC-UI-01`<br>`TC-AC-UI-02`<br>`TC-AC-UI-03`<br>`TC-TX-UI-01`<br>`TC-TX-UI-02`<br>`TC-E2E-01`<br>`TC-E2E-02` | `TC-NAV-UI-01.robot`<br>`TC-AC-UI-01.robot`<br>`TC-AC-UI-02.robot`<br>`TC-AC-UI-03.robot`<br>`TC-TX-UI-01.robot`<br>`TC-TX-UI-02.robot`<br>`TC-E2E-01.robot`<br>`TC-E2E-02.robot` | `TC-NAV-UI-01`<br>`TC-AC-UI-01`<br>`TC-AC-UI-02`<br>`TC-AC-UI-03`<br>`TC-TX-UI-01`<br>`TC-TX-UI-02`<br>`TC-E2E-01`<br>`TC-E2E-02` | `Location Should Contain`, `Page Should Contain`, `Wait Until Element Is Visible`, `Get Text` |
| **FR-09** | Validate negative scenarios | `TC-TX-UI-03`<br>`TC-TX-UI-04`<br>`TC-TX-UI-05`<br>`TC-API-08`<br>`TC-API-09` | `TC-TX-UI-03.robot`<br>`TC-TX-UI-04.robot`<br>`TC-TX-UI-05.robot`<br>`TC-API-08.robot`<br>`TC-API-09.robot` | `TC-TX-UI-03`<br>`TC-TX-UI-04`<br>`TC-TX-UI-05`<br>`TC_API_08`<br>`TC_API_09` | `Input Text`, `Click Transfer Button`, `Page Should Contain`, `Transfer Funds API`, `Get Account Details`, `Should Not Be Empty`, `Should Not Be Equal As Integers` |

---

## 2. Coverage Metrics Summary

* **Total Functional Requirements (FRs)**: 9 Requirements
* **Covered Requirements**: 9 Requirements
* **Requirements Coverage Rate**: 100%
* **Total Automated Test Cases**: 22 Test Cases (10 UI, 10 API, 2 Hybrid E2E)
* **Automation Ratio**: 100% of the designed master test inventory is automated.
* **Test Case Results Summary**:
  - **Passed Tests**: 17 Test Cases (All core positive UI, API, and E2E scenarios function properly).
  - **Failed Tests**: 5 Test Cases (All correspond to negative scenarios (`TC-TX-UI-03`, `TC-TX-UI-04`, `TC-TX-UI-05`, `TC-API-08`, `TC-API-09`) due to application-level validation defects).
