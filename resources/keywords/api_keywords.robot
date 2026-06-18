*** Settings ***
Documentation     API keywords for ParaBank
Library    RequestsLibrary
Resource    ../../variables/api_variables.robot

*** Keywords ***

Create Session To API
    [Documentation]    Creates an HTTP session for ParaBank API
    Log To Console    Creating API session
    ${headers}=    Create Dictionary    Accept=application/json
    Create Session    parabank    ${API_BASE_URL}    headers=${headers}    verify=False

Get Customer Accounts
    [Arguments]    ${customerId}
    [Documentation]    Gets accounts for a customer ID
    Log To Console    Getting customer accounts
    ${response}=    GET On Session    parabank    /customers/${customerId}/accounts
    RETURN    ${response}

Verify Response Code
    [Arguments]    ${response}    ${code}
    [Documentation]    Checks if response code is correct
    Log To Console    Checking response status
    Should Be Equal As Integers    ${response.status_code}    ${code}

Get Account Details
    [Arguments]    ${accountId}
    [Documentation]    Gets details for an account ID
    Log To Console    Getting account details
    ${response}=    GET On Session    parabank   /accounts/${accountId}
    RETURN    ${response}

Transfer Funds API
    [Arguments]    ${fromAccountId}    ${toAccountId}    ${amount}
    [Documentation]    Transfers funds via API
    Log To Console    Transferring funds via API
    ${q_params}=   Create Dictionary    fromAccountId=${fromAccountId}    toAccountId=${toAccountId}    amount=${amount}
    ${response}=    POST On Session    parabank    /transfer    params=${q_params}
    RETURN    ${response}

Get Account Transactions
    [Arguments]    ${accountId}
    [Documentation]    Gets transaction history for an account ID
    Log To Console    Getting account transactions
    ${response}=    GET On Session    parabank    /accounts/${accountId}/transactions
    RETURN    ${response}