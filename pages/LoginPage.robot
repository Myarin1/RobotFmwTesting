*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${USERNAME_FIELD}     id=user-name
${PASSWORD_FIELD}     id=password
${LOGIN_BUTTON}       xpath=//input[@data-test='login-button']

*** Keywords ***
Login
    [Arguments]    ${url}    ${browser}    ${username}    ${password}
    Open Browser    ${url}    ${browser}
    Maximize Browser Window
    Input Text    ${USERNAME_FIELD}    ${username}
    Input Text    ${PASSWORD_FIELD}    ${password}
    Click Button    ${LOGIN_BUTTON}