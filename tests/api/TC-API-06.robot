*** Settings ***
Resource    ../../resources/keywords/common_keywords.robot
Suite Setup    Load Environment

*** Test Cases ***

TC_API_06
    [Documentation]    Verify destination account balance after transfer
    [Tags]    api

    ${response}=    Get Account Details    ${ACCOUNT_ID_2}
    Verify Response Code    ${response}    200

    Log To Console    Validating response
    Should Contain    ${response.text}    balance