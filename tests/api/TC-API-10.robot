*** Settings ***
Documentation     API test suite for verifying destination account transactions
Resource    ../../resources/keywords/common_keywords.robot
Suite Setup    Load Environment And Create Session To API

*** Test Cases ***

TC_API_10
    [Documentation]    Verify destination account transaction history
    [Tags]    api    regression

    Log To Console    Starting test case
    
    ${response}=    Get Account Transactions    ${ACCOUNT_ID_2}
    Verify Response Code    ${response}    200

    Log To Console    Validating response
    Should Contain    ${response.text}    Credit

    Log To Console    Test completed
