*** Settings ***
Resource  ../../resources/keywords/api_keywords.robot
Resource    ../../resources/keywords/common_keywords.robot

Suite Setup  Load Environment

*** Test Cases ***
TC-PERF-01 API Response Time Under 2 Seconds
    [Tags]  performance

    ${response}=  Get Customer Accounts    ${CUSTOMER_ID}

    ${body}  Set Variable  ${response.json()}

    Log To Console    ${body}

    Verify Response Code    ${response}    200
    Validate Response Time    ${response}