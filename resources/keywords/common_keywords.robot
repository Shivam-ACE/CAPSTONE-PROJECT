*** Settings ***
Documentation     Common keywords for environment setup and browser actions
Library  SeleniumLibrary
Library  ../../config/environment.py
Resource    ../../variables/login_variables.robot
Resource    api_keywords.robot

*** Variables ***
${BROWSER}  chrome
${ENV}  qa

*** Keywords ***
Load Environment
    [Documentation]    Loads target environment config and resolves active account IDs
    Log To Console    Loading environment
    Load Env    ${ENV}  
    ${url}=  Get Env    baseurl
    ${username}=  Get Env    user_id
    ${password}=  Get Env    user_password

    Set Global Variable    ${BASE_URL}    ${url}
    Set Global Variable    ${USERNAME}  ${username}
    Set Global Variable    ${PASSWORD}  ${password}

    Log To Console    Resolving active accounts
    Create Session To API
    ${response}=    Get Customer Accounts    ${CUSTOMER_ID}
    ${accounts}=    Set Variable    ${response.json()}
    ${length}=      Get Length      ${accounts}
    
    IF    ${length} < 2
        Log To Console    Creating secondary account
        ${from_id}=    Set Variable    ${accounts[0]['id']}
        ${create_params}=    Create Dictionary    customerId=${CUSTOMER_ID}    newAccountType=1    fromAccountId=${from_id}
        ${create_resp}=    POST On Session    parabank    /createAccount    params=${create_params}
        ${response}=    Get Customer Accounts    ${CUSTOMER_ID}
        ${accounts}=    Set Variable    ${response.json()}
    END
    
    ${acc1}=    Set Variable    ${accounts[0]['id']}
    ${acc2}=    Set Variable    ${accounts[1]['id']}
    ${acc1_str}=    Convert To String    ${acc1}
    ${acc2_str}=    Convert To String    ${acc2}
    Set Global Variable    ${UI_FROM_ACCOUNT}    ${acc1_str}
    Set Global Variable    ${UI_TO_ACCOUNT}      ${acc2_str}
    Set Global Variable    ${ACCOUNT_ID}         ${acc1_str}
    Set Global Variable    ${ACCOUNT_ID_2}       ${acc2_str}
    Log To Console    Accounts resolved

Open Application
    [Documentation]    Opens browser and loads application page
    Log To Console    Opening application
    Should Not Be Empty    ${BASE_URL}    Base URL must not be empty. Please set it in config/environment.yaml
    Open Browser  ${BASE_URL}  ${BROWSER}
    Maximize Browser Window
    Sleep    2s

Close Application
    [Documentation]    Closes the browser
    Log To Console    Closing browser
    Close All Browsers

Login
    [Documentation]    Logs in with credentials
    Log To Console    Logging in
    Input Text    ${USERNAME_FIELD}  ${USERNAME}
    Input Text    ${PASSWORD_FIELD}    ${PASSWORD}
    Click Element    ${LOGIN_BUTTON}
    Sleep    2s

Open Application And Login
    [Documentation]    Opens application and logs in
    Load Environment
    Open Application
    Login

Load Environment And Create Session To API
    [Documentation]    Loads environment and creates API session
    Load Environment
    Create Session To API