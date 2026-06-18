*** Settings ***
Documentation     API test suite for customer accounts
Resource    ../../resources/keywords/common_keywords.robot

Suite Setup    Load Environment And Create Session To API

*** Test Cases ***
TC_API_01
    [Documentation]    Verify GET customer accounts list
    [Tags]    api    regression

    Log To Console    Starting test case
    
    ${response}=    Get Customer Accounts    ${CUSTOMER_ID}

    Verify Response Code    ${response}    200

    ${body}=    Set Variable    ${response.json()}

    Log To Console    Validating response
    Should Not Be Empty    ${body}

    Log To Console    Test completed
