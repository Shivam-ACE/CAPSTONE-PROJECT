*** Settings ***
Documentation     UI test suite for navigation flow
Resource    ../../resources/keywords/common_keywords.robot
Resource    ../../resources/pages/home_page.robot

Suite Setup       Load Environment
Test Setup        Open Application And Login
Test Teardown     Close Application

*** Test Cases ***
TC-NAV-UI-01
    [Documentation]    Verify UI navigation flow
    [Tags]    ui    regression

    Log To Console    Starting test case

    Log To Console    Navigating to open new account
    Click Open New Account
    Sleep    1s
    Log To Console    Validating page URL contains 'openaccount'
    Location Should Contain    openaccount

    Log To Console    Navigating to transfer funds
    Click Transfer Funds
    Sleep    1s
    Log To Console    Validating page URL contains 'transfer'
    Location Should Contain    transfer

    Log To Console    Test completed
