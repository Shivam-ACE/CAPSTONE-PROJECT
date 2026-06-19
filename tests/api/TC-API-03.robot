*** Settings ***
Resource    ../../resources/keywords/common_keywords.robot
Suite Setup    Load Environment

*** Test Cases ***

TC_API_03
    [Documentation]    Verify newly created account exists in customer accounts list
    [Tags]    api

    ${response}=    Get Customer Accounts    ${CUSTOMER_ID}
    Verify Response Code    ${response}    200

    Log To Console    Validating response
    Should Contain    ${response.text}    ${ACCOUNT_ID_2}