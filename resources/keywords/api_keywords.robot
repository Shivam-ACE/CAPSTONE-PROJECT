*** Settings ***
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
    [Documentation]    Gets a list of accounts for a customer ID

    Log To Console    Getting customer accounts

    ${response}=    GET On Session    parabank    /customers/${customerId}/accounts
    RETURN    ${response}

Verify Response Code
    [Arguments]    ${response}    ${code}
    [Documentation]    Checks response code


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

Clean DB
    [Documentation]    Cleans test data from database
    Log To Console    Cleaning database

    ${response}=    POST On Session    parabank    /cleanDB

Create Account 
    [Documentation]    Creates a new account for the customer via API
    [Arguments]    ${customerId}    ${accountType}    ${accountId}
    
    Log To Console    Creating new account

    ${params}=    Create Dictionary    customerId=${customerId}    newAccountType=0    fromAccountId=${accountId}
    ${response}=    POST On Session    parabank    /createAccount    params=${params}

Validate Response Time
    [Arguments]    ${response}    ${max_ms}=2000

    ${response_time}=    Evaluate
    ...    int($response.elapsed.total_seconds() * 1000)

    Log To Console
    ...    Response Time: ${response_time} ms

    ${valid}=   Run Keyword And Return Status  Should Be True  ${response_time} < ${max_ms}

    IF    ${valid}
        Log    ${response_time}
    ELSE
        Fail
    END