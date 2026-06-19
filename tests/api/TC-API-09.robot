*** Settings ***
Resource    ../../resources/keywords/common_keywords.robot
Suite Setup    Load Environment

*** Test Cases ***

TC_API_09
    [Documentation]    Verify fund transfer fails for excessive balance amount
    [Tags]    api

    ${response}=    Transfer Funds API    ${ACCOUNT_ID}    ${ACCOUNT_ID_2}    999999

    Log To Console    Validating response
    Should Not Be Equal As Integers    ${response.status_code}    200