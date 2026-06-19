*** Settings ***
Resource    ../../resources/keywords/common_keywords.robot
Resource    ../../resources/pages/home_page.robot
Resource    ../../resources/pages/open_new_account_page.robot

Suite Setup       Load Environment
Test Setup        Open Application And Login
Test Teardown     Close Application

*** Test Cases ***
TC-AC-UI-04
    [Documentation]    Verify open account page controls
    [Tags]    ui

    Click Open New Account
    Sleep    1s
    Location Should Contain    openaccount

    Log To Console    Validating visibility of Account Type dropdown
    Element Should Be Visible    ${ACCOUNT_TYPE_DROPDOWN}

    Log To Console    Validating visibility of Existing Account ID dropdown
    Element Should Be Visible    ${ACCOUNT_ID_DROPDOWN}

    Log To Console    Validating visibility of Open New Account button
    Element Should Be Visible    ${OPEN_ACCOUNT_BUTTON}

    Log To Console    Test completed
