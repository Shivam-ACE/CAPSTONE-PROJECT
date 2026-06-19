*** Settings ***
Resource    ../../resources/keywords/common_keywords.robot
Resource    ../../resources/pages/home_page.robot
Resource    ../../resources/pages/open_new_account_page.robot

Suite Setup       Load Environment
Test Setup        Open Application And Login
Test Teardown     Close Application

*** Test Cases ***
TC-AC-UI-03
    [Documentation]    Verify navigation to account details page
    [Tags]    ui

    Click Open New Account
    Sleep    1s
    Location Should Contain    openaccount

    Log To Console    Opening account
    Select Account Type    0
    Sleep    1s
    Click Open Account Button

    Log To Console    Validating response
    Page Should Contain    Account Opened!
    Page Should Contain    Your new account number

    Log To Console    Clicking new account link
    Click Account Details Link
    Sleep    1s

    Log To Console    Validating response
    Page Should Contain    Account Details
    Location Should Contain    activity.htm?id=