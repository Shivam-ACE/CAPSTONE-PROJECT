*** Settings ***
Resource    ../../resources/keywords/common_keywords.robot
Suite Setup    Load Environment

*** Test Cases ***

TC_API_04
    [Documentation]    Verify fund transfer via API
    [Tags]    api

    ${response}=    Transfer Funds API    ${ACCOUNT_ID}    ${ACCOUNT_ID_2}    150
    Verify Response Code    ${response}    200

    Log To Console    Validating response
    Should Contain    ${response.text}    Successfully transferred