*** Settings ***
Resource    ../../resources/keywords/common_keywords.robot
Resource    ../../resources/pages/home_page.robot
Resource    ../../resources/pages/open_new_account_page.robot

Suite Setup       Load Environment
Test Setup        Open Application And Login
Test Teardown     Close Application

*** Test Cases ***
TC-AC-UI-01
    [Documentation]    Verify creating savings account
    [Tags]    ui

    Click Open New Account
    Sleep    1s
    Location Should Contain    openaccount

    Select Account Type    1
    Select Account ID    ${ACCOUNT_ID}
    Sleep    1s

    Log To Console    Opening account
    Click Open Account Button

    Log To Console    Validating response
    Page Should Contain    Account Opened!
    Page Should Contain    Your new account number