*** Settings ***
Documentation     UI test suite for funds transfer
Resource    ../../resources/keywords/common_keywords.robot
Resource    ../../resources/pages/home_page.robot
Resource    ../../resources/pages/transfer_funds_page.robot
Resource    ../../variables/transfer_funds_variables.robot

Suite Setup       Load Environment
Test Setup        Open Application And Login
Test Teardown     Close Application

*** Test Cases ***
TC-TX-UI-01
    [Documentation]    Verify funds transfer via UI
    [Tags]    ui    regression

    Log To Console    Starting test case

    Log To Console    Navigating to transfer funds
    Click Transfer Funds
    Sleep    1s
    Location Should Contain    transfer

    Log To Console    Entering amount
    Input Text    ${AMOUNT_FIELD}    250

    Log To Console    Selecting source account
    Wait Until Page Contains Element    ${FROM_ACCOUNT_DROPDOWN}/option[@value="${UI_FROM_ACCOUNT}"]    timeout=10s
    Select From List By Value  ${FROM_ACCOUNT_DROPDOWN}   ${UI_FROM_ACCOUNT}

    Log To Console    Selecting destination account
    Wait Until Page Contains Element    ${TO_ACCOUNT_DROPDOWN}/option[@value="${UI_TO_ACCOUNT}"]    timeout=10s
    Select From List By Value  ${TO_ACCOUNT_DROPDOWN}   ${UI_TO_ACCOUNT}

    Log To Console    Transferring funds
    Click Transfer Button
    Sleep    2s

    Log To Console    Validating response
    Page Should Contain    Transfer Complete!

    Log To Console    Test completed
