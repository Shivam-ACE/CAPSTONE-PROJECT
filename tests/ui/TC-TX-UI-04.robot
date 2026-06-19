*** Settings ***
Resource    ../../resources/keywords/common_keywords.robot
Resource    ../../resources/pages/home_page.robot
Resource    ../../resources/pages/transfer_funds_page.robot
Resource    ../../variables/transfer_funds_variables.robot

Suite Setup       Load Environment
Test Setup        Open Application And Login
Test Teardown     Close Application

*** Test Cases ***
TC-TX-UI-04
    [Documentation]    Verify alphabetic amount funds transfer rejection
    [Tags]    ui

    Click Transfer Funds
    Sleep    1s
    Location Should Contain    transfer

    Log To Console    Entering amount
    Input Text    ${AMOUNT_FIELD}    abc

    Log To Console    Selecting source account
    Wait Until Page Contains Element    ${FROM_ACCOUNT_DROPDOWN}    timeout=10s
    Select From List By Value  ${FROM_ACCOUNT_DROPDOWN}   ${ACCOUNT_ID}

    Log To Console    Selecting destination account
    Wait Until Page Contains Element    ${TO_ACCOUNT_DROPDOWN}    timeout=10s
    Select From List By Value  ${TO_ACCOUNT_DROPDOWN}   ${ACCOUNT_ID_2}

    Log To Console    Transferring funds with alphabetic amount
    Click Transfer Button
    Sleep    2s

    Log To Console    Validating response
    Page Should Contain    An internal error has occurred and has been logged.