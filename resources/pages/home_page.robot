*** Settings ***
Library    SeleniumLibrary
Resource    ../../variables/home_variables.robot

*** Keywords ***
Click Open New Account
    [Documentation]    Clicks the open new account link
    Click Element    ${OPEN_NEW_ACCOUNT_URL}

Click Transfer Funds
    [Documentation]    Clicks the transfer funds link
    Click Element    ${TRANSFER_FUNDS_URL}