*** Settings ***
Documentation     API test suite for verifying source account transactions
Resource    ../../resources/keywords/common_keywords.robot
Suite Setup    Load Environment And Create Session To API

*** Test Cases ***

TC_API_07
    [Documentation]    Verify source account transaction history
    [Tags]    api    regression

    Log To Console    Starting test case
    
    ${response}=    Get Account Transactions    ${ACCOUNT_ID}
    Verify Response Code    ${response}    200

    Log To Console    Validating response
    Should Contain    ${response.text}    Debit

    Log To Console    Test completed
