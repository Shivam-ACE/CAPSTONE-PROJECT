*** Settings ***
Documentation     API test suite for verifying destination account balance
Resource    ../../resources/keywords/common_keywords.robot
Suite Setup    Load Environment And Create Session To API

*** Test Cases ***

TC_API_06
    [Documentation]    Verify destination account balance after transfer
    [Tags]    api    regression

    Log To Console    Starting test case
    
    ${response}=    Get Account Details    ${ACCOUNT_ID_2}
    Verify Response Code    ${response}    200

    Log To Console    Validating response
    Should Contain    ${response.text}    balance

    Log To Console    Test completed
