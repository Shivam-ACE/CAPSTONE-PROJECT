*** Settings ***
Library    SeleniumLibrary
Library    DataDriver   file=${CURDIR}/login_data.csv  dialect=excel

Test Setup    Navigate To Parabank Register Page
#Test Setup  CLick Register After Navigating
Test Teardown  Close Browser

Test Template  Register User

*** Variables ***
${BASE_URL}=    https://parabank.parasoft.com/parabank/index.htm
${FIRST_NAME_FIELD}  xpath=//input[@id="customer.firstName"]
${LAST_NAME_FIELD}  xpath=//input[@id="customer.lastName"]
${USER_ADDRESS_FIELD}  xpath=//input[@id="customer.address.street"]
${CITY_FIELD}  xpath=//input[@id="customer.address.city"]
${STATE_FIELD}  xpath=//input[@id="customer.address.state"]
${ZIPCODE_FIELD}  xpath=//input[@id="customer.address.zipCode"]
${PH_NO_FIELD}  xpath=//input[@id="customer.phoneNumber"]
${SSN_FIELD}  xpath=//input[@id="customer.ssn"]
${USERNAME_FIELD}  xpath=//input[@id="customer.username"]
${PASSWORD_FIELD}  xpath=//input[@id="customer.password"]
${CONFIRM_FIELD}  xpath=//input[@id="repeatedPassword"]
${REGISTER_BUTTON}  xpath=//input[@value="Register"]

*** Test Cases ***
Test Case For Data Driven   ${Firstname}    ${Lastname}    ${Address}    ${City}    ${State}    ${Zipcode}    ${Phno}    ${SSN}    ${Username}    ${Password}    ${Confirm}
   [Documentation]      Data driven testing using csv
   [Tags]   datadriver

*** Keywords ***
Navigate To Parabank Register Page
    Open Browser    ${BASE_URL}    chrome
    Maximize Browser Window
    Sleep    2s
    Wait Until Element Is Visible    xpath=//a[text()="Register"]  timeout=10s
    Click Element    xpath=//a[text()="Register"]
    
Register User
    [Arguments]    ${Firstname}    ${Lastname}    ${Address}    ${City}    ${State}    ${Zipcode}    ${Phno}    ${SSN}    ${Username}    ${Password}    ${Confirm}
    Input Text    ${FIRST_NAME_FIELD}   ${Firstname}
    Input Text    ${LAST_NAME_FIELD}  ${Lastname}
    Input Text    ${USER_ADDRESS_FIELD}  ${Address}
    Input Text    ${CITY_FIELD}  ${City}
    Input Text    ${STATE_FIELD}  ${State}
    Input Text    ${ZIPCODE_FIELD}  ${Zipcode}
    Input Text    ${PH_NO_FIELD}  ${Phno}
    Input Text    ${SSN_FIELD}  ${SSN}
    Input Text    ${USERNAME_FIELD}  ${Username}
    Input Text    ${PASSWORD_FIELD}  ${Password}
    Input Text    ${CONFIRM_FIELD}  ${Confirm}
    Click Element  ${REGISTER_BUTTON}

#CLick Register After Navigating
#    Open Application
#    CLick Register Button






