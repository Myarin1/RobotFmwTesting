*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${BOUTON_CHECKOUT}    xpath=//button[@data-test='checkout']
${FIRST_NAME}    xpath=//input[@data-test='firstName']
${LAST_NAME}    xpath=//input[@data-test='lastName']
${POSTAL_CODE}    xpath=//input[@data-test='postalCode']
${BOUTON_CONTINUE}    xpath=//input[@data-test='continue']

*** Keywords ***

Passer la commande
    [Arguments]    ${first}    ${last}    ${postal}
    Click Element    ${BOUTON_CHECKOUT}
    Input Text    ${FIRST_NAME}    ${first}
    Input Text    ${LAST_NAME}     ${last}
    Wait Until Element Is Visible    ${POSTAL_CODE}
    Input Text    ${POSTAL_CODE}   ${postal}
    Click Element    ${BOUTON_CONTINUE}
    Page Should Contain     Checkout: Overview