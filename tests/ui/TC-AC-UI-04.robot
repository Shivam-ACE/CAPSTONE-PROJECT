*** Settings ***
Documentation     UI test suite for verifying account form controls
Resource    ../../resources/keywords/common_keywords.robot
Resource    ../../resources/pages/home_page.robot
Resource    ../../resources/pages/open_new_account_page.robot
Resource    ../../variables/transfer_funds_variables.robot

Suite Setup       Load Environment
Test Setup        Open Application And Login
Test Teardown     Close Application

*** Test Cases ***
TC-AC-UI-04
    [Documentation]    Verify open account page controls
    [Tags]    ui    regression

    Log To Console    Starting test case

    Log To Console    Navigating to open new account
    Click Open New Account
    Sleep    1s
    Location Should Contain    openaccount

    Log To Console    Validating visibility of Account Type dropdown
    Element Should Be Visible    ${ACCOUNT_TYPE_DROPDOWN}
    Log To Console    Validating visibility of Funding Account ID dropdown
    Element Should Be Visible    ${ACCOUNT_ID_DROPDOWN}
    Log To Console    Validating visibility of Open Account submission button
    Element Should Be Visible    ${OPEN_ACCOUNT_BUTTON}

    Log To Console    Test completed
