*** Settings ***
Documentation     API test suite for verifying new account
Resource    ../../resources/keywords/common_keywords.robot
Suite Setup    Load Environment And Create Session To API

*** Test Cases ***

TC_API_03
    [Documentation]    Verify newly created account exists in customer accounts list
    [Tags]    api    regression

    Log To Console    Starting test case
    
    ${response}=    Get Customer Accounts    ${CUSTOMER_ID}
    Verify Response Code    ${response}    200

    Log To Console    Validating response
    Should Contain    ${response.text}    ${ACCOUNT_ID}

    Log To Console    Test completed
