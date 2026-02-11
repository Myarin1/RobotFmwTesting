*** Settings ***
Resource    ../resources/Common.robot
Resource    ../pages/LoginPage.robot
Resource    ../pages/ProductPage.robot
Resource    ../resources/variables.robot
Test Setup    Initialisation Test
Test Teardown    Nettoyage

*** Test Cases ***

Login Valide
    Login    ${URL}    ${BROWSER}    ${USERNAME}    ${PASSWORD}
    Page Product visible

Login Invalide
    Login    ${URL}    ${BROWSER}    ${USERNAME}    ${WRONG_PASSWORD}
    Page Should Contain Element    xpath=//input[@data-test='login-button']

