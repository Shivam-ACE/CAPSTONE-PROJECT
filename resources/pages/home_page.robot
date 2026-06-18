*** Settings ***
Documentation     Home page navigation keywords
Library    SeleniumLibrary
Resource    ../../variables/home_variables.robot

*** Keywords ***
Click Open New Account
    [Documentation]    Clicks the open new account link
    Log To Console    Navigating to open new account
    Click Element    ${OPEN_NEW_ACCOUNT_URL}

Click Transfer Funds
    [Documentation]    Clicks the transfer funds link
    Log To Console    Navigating to transfer funds
    Click Element    ${TRANSFER_FUNDS_URL}