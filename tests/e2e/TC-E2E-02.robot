*** Settings ***
Resource    ../../resources/keywords/common_keywords.robot
Resource    ../../resources/keywords/api_keywords.robot
Resource    ../../resources/pages/home_page.robot
Resource    ../../resources/pages/transfer_funds_page.robot

Suite Setup       Load Environment
Test Setup        Open Application And Login
Test Teardown     Close Application

*** Test Cases ***
TC-E2E-02
    [Documentation]    Verify E2E funds transfer and API transaction history validation
    [Tags]    e2e

    Click Transfer Funds

    Log To Console    Entering amount
    Enter Amount    120

    Log To Console    Selecting source account
    Wait Until Page Contains Element    ${FROM_ACCOUNT_DROPDOWN}    timeout=10s
    Select From Account    ${ACCOUNT_ID}
    
    Log To Console    Selecting destination account
    Wait Until Page Contains Element    ${TO_ACCOUNT_DROPDOWN}    timeout=10s
    Select To Account    ${ACCOUNT_ID_2}

    Log To Console    Transferring funds
    Click Transfer Button
    
    Log To Console    Validating response
    Page Should Contain    Transfer Complete!

    Log To Console    Getting transactions
    ${response}=    Get Account Transactions    ${ACCOUNT_ID_2}
    Verify Response Code    ${response}    200

    Log To Console    Validating transaction history contains entry of transfer amount: 120
    Should Contain    ${response.text}    120