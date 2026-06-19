*** Settings ***
Library    SeleniumLibrary
Resource    ../../variables/transfer_funds_variables.robot

*** Keywords ***
Select From Account
    [Arguments]    ${from_account}
    [Documentation]    Selects source account from dropdown

    Select From List By Value    ${FROM_ACCOUNT_DROPDOWN}    ${from_account}
    Sleep    1s

Select To Account
    [Arguments]    ${to_account}
    [Documentation]    Selects destination account from dropdown

    Select From List By Value    ${TO_ACCOUNT_DROPDOWN}    ${to_account}
    Sleep    1s

Enter Amount
    [Arguments]    ${amount}
    [Documentation]    Enters amount to transfer

    Input Text    ${AMOUNT_FIELD}    ${amount}
    Sleep    1s

Click Transfer Button
    [Documentation]    Clicks the transfer button

    Click Element    ${TRANSFER_BUTTON}
    Sleep    2s