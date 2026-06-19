*** Settings ***
Resource    ../../resources/keywords/common_keywords.robot
Suite Setup    Load Environment

*** Test Cases ***

TC_API_08
    [Documentation]    Verify GET account details for non-existent account ID
    [Tags]    api

    Log To Console    Gives 400 HTTP status code for non-existent account ID

    ${response}=    Get Account Details    ${INVALID_ID}