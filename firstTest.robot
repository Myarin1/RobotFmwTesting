*** Settings ***
Library   SeleniumLibrary    run_on_failure=Nothing
Library    String
Test Teardown    Nettoyage

*** Variables ***
${monURL}     https://www.saucedemo.com/
${browser}    chrome
${username}    standard_user
${password}    secret_sauce
${wrongPassword}    mauvais_mdp
*** Test Cases ***
Login Test
    Login    ${username}    ${password}    ${monURL}    ${browser}    
    Vérifier affichage de la page Product
Login Test Fail
    Login    ${username}    ${wrongPassword}    ${monURL}    ${browser}
    Vérifier affichage de la page Login
*** Keywords ***
Login 
    [Arguments]    ${username}    ${password}    ${monURL}    ${browser}        
    Open Browser     ${monURL}    ${browser}
    Input Text     id=user-name    ${username}
    Input Text     id=password    ${password}
    Click Button    id=login-button

Vérifier affichage de la page Product
    Page Should Contain Element    xpath://div[text()='Sauce Labs Backpack']

Vérifier affichage de la page Login 
    Page Should Contain Element    xpath://input[@data-test='login-button']

Nettoyage 
    Run Keyword If Test Failed    Screenshot Avec Nom Du Test
    Close Browser

Screenshot Avec Nom Du Test
    ${safe_name}=    Replace String    ${TEST NAME}    ${SPACE}    _
    Capture Page Screenshot    ${safe_name + "_error"}.png
    