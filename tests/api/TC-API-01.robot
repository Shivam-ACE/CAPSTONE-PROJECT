*** Settings ***
Resource    ../../resources/keywords/common_keywords.robot
Suite Setup    Load Environment

*** Test Cases ***
TC_API_01
    [Documentation]    Verify GET customer accounts list
    [Tags]    api

    ${response}=    Get Customer Accounts    ${CUSTOMER_ID}

    Verify Response Code    ${response}    200

    ${body}=    Set Variable    ${response.json()}

    Should Not Be Empty    ${body}
    
    Log To Console    ${body}