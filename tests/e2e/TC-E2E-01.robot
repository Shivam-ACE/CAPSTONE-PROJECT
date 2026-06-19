*** Settings ***
Resource    ../../resources/keywords/common_keywords.robot
Resource    ../../resources/keywords/api_keywords.robot
Resource    ../../resources/pages/open_new_account_page.robot
Resource    ../../resources/pages/home_page.robot

Suite Setup    Load Environment
Test Setup       Open Application And Login
Test Teardown    Close Application

*** Test Cases ***
TC-E2E-01
    [Documentation]    Verify E2E account creation and API validation
    [Tags]    e2e

    Click Open New Account
    Sleep    1s

    Log To Console    Opening account
    Select Account Type    1
    Click Open Account Button

    Log To Console    Getting new account number
    ${account_id}=    Get New Account Number

    Log To Console    Verifying account details

    ${response}=    Get Account Details    ${account_id}

    Verify Response Code    ${response}    200
    Should Contain    ${response.text}    ${account_id}
    Should Contain    ${response.text}    SAVINGS