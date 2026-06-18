*** Settings ***
Documentation     API test suite for non-existent account ID
Resource    ../../resources/keywords/common_keywords.robot
Suite Setup    Load Environment And Create Session To API

*** Test Cases ***

TC_API_08
    [Documentation]    Verify GET account details for non-existent account ID
    [Tags]    api    regression

    Log To Console    Starting test case
    
    ${response}=    Get Account Details    ${INVALID_ID}


    Log To Console    Validating response
    Should Not Be Empty    ${response.text}

    Log To Console    Test completed
