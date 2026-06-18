*** Settings ***
Documentation     API test suite for transferring funds
Resource    ../../resources/keywords/common_keywords.robot
Suite Setup    Load Environment And Create Session To API

*** Test Cases ***

TC_API_04
    [Documentation]    Verify fund transfer via API
    [Tags]    api    regression

    Log To Console    Starting test case
    
    ${response}=    Transfer Funds API    ${ACCOUNT_ID}    ${ACCOUNT_ID_2}    150
    Verify Response Code    ${response}    200

    Log To Console    Validating response
    Should Contain    ${response.text}    Successfully transferred

    Log To Console    Test completed
