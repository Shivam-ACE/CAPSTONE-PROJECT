*** Settings ***
Resource    ../../resources/keywords/common_keywords.robot
Suite Setup    Load Environment

*** Test Cases ***
TC_API_02
    [Documentation]    Verify GET account details API
    [Tags]    api
    
    ${response}=    Get Account Details    ${ACCOUNT_ID_2}

    Verify Response Code    ${response}    200
    
    Log To Console    Validating response
    
    Should Contain    ${response.text}    id
    Should Contain    ${response.text}    customerId
    Should Contain    ${response.text}    type
    Should Contain    ${response.text}    balance

    ${body}=    Set Variable    ${response.json()}
    Log To Console    ${body}