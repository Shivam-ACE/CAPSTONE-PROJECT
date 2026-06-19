*** Settings ***
Library    SeleniumLibrary
Resource    ../../variables/open_new_account_variables.robot

*** Keywords ***
Select Account Type
    [Arguments]    ${account_type}
    [Documentation]    Selects account type (0 for Checking, 1 for Savings)

    Select From List By Value    ${ACCOUNT_TYPE_DROPDOWN}    ${account_type}
    Sleep    1s

Select Account ID
    [Arguments]    ${account_id}
    [Documentation]    Selects given account ID

    Select From List By Value    ${ACCOUNT_ID_DROPDOWN}    ${account_id}
    Sleep    1s

Click Open Account Button
    [Documentation]    Clicks the open account button

    Click Element    ${OPEN_ACCOUNT_BUTTON}
    Sleep    2s

Click Account Details Link
    [Documentation]    Clicks the account details link on success page

    Click Element    ${ACCOUNT_DETAILS_LINK}
    Sleep    1s

Get New Account Number
    [Documentation]    Gets the new account number from success page

    Wait Until Element Is Visible    ${ACCOUNT_DETAILS_LINK}    timeout=20s
    ${account_id}=    Get Text    ${ACCOUNT_DETAILS_LINK}
    RETURN    ${account_id}