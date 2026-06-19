*** Settings ***
Resource    ../../resources/keywords/common_keywords.robot
Suite Setup    Load Environment

*** Test Cases ***

TC_API_10
    [Documentation]    Verify account transaction history
    [Tags]    api

    ${response}=    Get Account Transactions    ${ACCOUNT_ID_2}
    Verify Response Code    ${response}    200

    Log To Console    Validating response
    Should Contain    ${response.text}    Credit