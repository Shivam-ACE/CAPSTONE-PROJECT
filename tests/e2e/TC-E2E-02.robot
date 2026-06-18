*** Settings ***
Documentation     End-to-end test suite for funds transfer and transactions
Resource    ../../resources/keywords/common_keywords.robot
Resource    ../../resources/keywords/api_keywords.robot
Resource    ../../resources/pages/home_page.robot
Resource    ../../resources/pages/transfer_funds_page.robot

Suite Setup       Load Environment And Create Session To API
Test Setup        Open Application And Login
Test Teardown     Close Application

*** Test Cases ***
TC-E2E-02
    [Documentation]    Verify E2E funds transfer and API transaction ledger validation
    [Tags]    e2e    regression

    Log To Console    Starting test case

    Log To Console    Navigating to transfer funds
    Click Transfer Funds

    Log To Console    Entering amount
    Enter Amount    120

    Log To Console    Selecting source account
    Wait Until Page Contains Element    ${FROM_ACCOUNT_DROPDOWN}/option[@value="${UI_FROM_ACCOUNT}"]    timeout=10s
    Select From Account    ${UI_FROM_ACCOUNT}
    
    Log To Console    Selecting destination account
    Wait Until Page Contains Element    ${TO_ACCOUNT_DROPDOWN}/option[@value="${UI_TO_ACCOUNT}"]    timeout=10s
    Select To Account    ${UI_TO_ACCOUNT}

    Log To Console    Transferring funds
    Click Transfer Button
    
    Log To Console    Validating response
    Page Should Contain    Transfer Complete!

    Log To Console    Getting transactions
    ${response}=    Get Account Transactions    ${UI_TO_ACCOUNT}

    Log To Console    Validating response status code is 200
    Verify Response Code    ${response}    200

    Log To Console    Validating transaction ledger entry contains transfer amount: 120
    Should Contain    ${response.text}    120

    Log To Console    Test completed
