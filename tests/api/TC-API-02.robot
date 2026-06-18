*** Settings ***
Documentation     API test suite for account details
Resource    ../../resources/keywords/common_keywords.robot
Suite Setup    Load Environment And Create Session To API

*** Test Cases ***
TC_API_02
    [Documentation]    Verify GET account details API
    [Tags]    api    regression

    Log To Console    Starting test case
    
    ${response}=    Get Account Details    ${ACCOUNT_ID_2}

    Verify Response Code    ${response}    200


    Log To Console    Validating response
    Should Contain    ${response.text}    id
    Log To Console    Validating response
    Should Contain    ${response.text}    customerId
    Log To Console    Validating response
    Should Contain    ${response.text}    type
    Log To Console    Validating response
    Should Contain    ${response.text}    balance

    Log To Console    Test completed
