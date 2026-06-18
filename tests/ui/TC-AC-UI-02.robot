*** Settings ***
Documentation     UI test suite for creating checking account
Resource    ../../resources/keywords/common_keywords.robot
Resource    ../../resources/pages/home_page.robot
Resource    ../../resources/pages/open_new_account_page.robot

Suite Setup       Load Environment
Test Setup        Open Application And Login
Test Teardown     Close Application

*** Test Cases ***
TC-AC-UI-02
    [Documentation]    Verify creating checking account with default options
    [Tags]    ui    regression

    Log To Console    Starting test case

    Log To Console    Navigating to open new account
    Click Open New Account
    Sleep    1s
    Location Should Contain    openaccount

    Log To Console    Selecting checking account
    Select Account Type    0
    Sleep    1s

    Log To Console    Opening account
    Click Open Account Button

    Log To Console    Validating response
    Page Should Contain    Account Opened!
    Log To Console    Validating response
    Page Should Contain    Your new account number

    Log To Console    Test completed
