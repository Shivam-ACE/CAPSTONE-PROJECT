*** Settings ***
Documentation     API test suite for verifying source account balance
Resource    ../../resources/keywords/common_keywords.robot
Suite Setup    Load Environment And Create Session To API

*** Test Cases ***

TC_API_05
    [Documentation]    Verify source account balance after transfer
    [Tags]    api    regression

    Log To Console    Starting test case
    
    ${response}=    Get Account Details    ${ACCOUNT_ID}
    Verify Response Code    ${response}    200

    Log To Console    Validating response
    Should Contain    ${response.text}    balance

    Log To Console    Test completed
