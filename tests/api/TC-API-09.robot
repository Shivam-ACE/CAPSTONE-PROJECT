*** Settings ***
Documentation     API test suite for overdraft funds transfer
Resource    ../../resources/keywords/common_keywords.robot
Suite Setup    Load Environment And Create Session To API

*** Test Cases ***

TC_API_09
    [Documentation]    Verify fund transfer fails for overdraft amount
    [Tags]    api    regression

    Log To Console    Starting test case
    
    ${response}=    Transfer Funds API    ${ACCOUNT_ID}    ${ACCOUNT_ID_2}    999999

    Log To Console    Validating response
    Should Not Be Equal As Integers    ${response.status_code}    200

    Log To Console    Test completed
