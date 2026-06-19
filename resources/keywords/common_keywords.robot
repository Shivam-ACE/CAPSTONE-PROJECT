*** Settings ***
Library    SeleniumLibrary
Library    ../../config/environment.py
Resource    ../../variables/login_variables.robot
Resource    api_keywords.robot

*** Variables ***
${BROWSER}  chrome
${ENV}  qa

*** Keywords ***
Load Environment
    [Documentation]    Loads target environment and fetch active account IDs

    Log To Console    Loading environment

    Load Env    ${ENV}
    ${url}=  Get Env    baseurl
    ${username}=  Get Env    user_id
    ${password}=  Get Env    user_password

    Set Global Variable    ${BASE_URL}    ${url}
    Set Global Variable    ${USERNAME}  ${username}
    Set Global Variable    ${PASSWORD}  ${password}

    Log To Console    Fetching active accounts

    Create Session To API

    ${response}=    Get Customer Accounts    ${CUSTOMER_ID}
    ${accounts}=    Set Variable    ${response.json()}
    ${length}=      Get Length      ${accounts}

    IF    ${length} < 2  ### creates a account if there are less than 2 accounts

        Create Account    ${CUSTOMER_ID}    0    ${ACCOUNT_ID}
        
        ${response}=    Get Customer Accounts    ${CUSTOMER_ID}
        ${accounts}=    Set Variable    ${response.json()}

    END

    ###### storing secound account id in a variable

    ${acc2}=    Set Variable    ${accounts[1]['id']}
    ${acc2_str}=    Convert To String    ${acc2}
    Set Global Variable    ${ACCOUNT_ID_2}       ${acc2_str}

Open Application
    [Documentation]    Opens browser and navigate to application page

    Log To Console    Opening application

    Open Browser  ${BASE_URL}  ${BROWSER}
    Maximize Browser Window
    Sleep    2s

Close Application
    [Documentation]    Closes the browser

    Log To Console    Closing browser

    Close All Browsers

Login
    [Documentation]    Logs in user

    Log To Console    Logging in

    Input Text    ${USERNAME_FIELD}  ${USERNAME}
    Input Text    ${PASSWORD_FIELD}    ${PASSWORD}
    Click Element    ${LOGIN_BUTTON}
    Sleep    2s

Open Application And Login
    [Documentation]    Opens application and logs in
#    Load Environment
    Open Application
    Login

Load Environment And Create Session To API
    [Documentation]    Loads environment and creates API session

    Load Environment
    Create Session To API