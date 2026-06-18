*** Settings ***
Documentation     UI test suite for creating savings account
Resource    ../../resources/keywords/common_keywords.robot
Resource    ../../resources/pages/home_page.robot
Resource    ../../resources/pages/open_new_account_page.robot
Resource    ../../variables/transfer_funds_variables.robot

Suite Setup       Load Environment
Test Setup        Open Application And Login
Test Teardown     Close Application

*** Test Cases ***
TC-AC-UI-01
    [Documentation]    Verify creating savings account
    [Tags]    ui    regression

    Log To Console    Starting test case

    Log To Console    Navigating to open new account
    Click Open New Account
    Sleep    1s
    Location Should Contain    openaccount

    Log To Console    Selecting source account
    Select Account Type    1
    Select Account ID    ${UI_TO_ACCOUNT}
    Sleep    1s

    Log To Console    Opening account
    Click Open Account Button

    Log To Console    Validating response
    Page Should Contain    Account Opened!
    Log To Console    Validating response
    Page Should Contain    Your new account number

    Log To Console    Test completed
