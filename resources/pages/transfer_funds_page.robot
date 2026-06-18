*** Settings ***
Documentation     Transfer funds page keywords
Library    SeleniumLibrary
Resource    ../../variables/transfer_funds_variables.robot

*** Keywords ***
Select From Account
    [Arguments]    ${from_account}
    [Documentation]    Selects source account from dropdown
    Log To Console    Selecting source account: ${from_account}
    Select From List By Value    ${FROM_ACCOUNT_DROPDOWN}    ${from_account}
    Sleep    1s

Select To Account
    [Arguments]    ${to_account}
    [Documentation]    Selects destination account from dropdown
    Log To Console    Selecting destination account: ${to_account}
    Select From List By Value    ${TO_ACCOUNT_DROPDOWN}    ${to_account}
    Sleep    1s

Enter Amount
    [Arguments]    ${amount}
    [Documentation]    Enters amount to transfer
    Log To Console    Entering amount: ${amount}
    Input Text    ${AMOUNT_FIELD}    ${amount}
    Sleep    1s

Click Transfer Button
    [Documentation]    Clicks the transfer button
    Log To Console    Clicking transfer button
    Click Element    ${TRANSFER_BUTTON}
    Sleep    2s