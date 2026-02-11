*** Settings ***
Resource    ../resources/Common.robot
Resource    ../pages/LoginPage.robot
Resource    ../pages/ProductPage.robot
Resource    ../resources/variables.robot
Test Setup    Initialisation Test
Test Teardown    Nettoyage

*** Test Cases ***

Test Ajout produit
    Login    ${URL}    ${BROWSER}    ${USERNAME}    ${PASSWORD}
    Page Product visible
    Ajout produit au panier 
    Clic bouton panier
    Page Product visible

