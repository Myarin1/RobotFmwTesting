*** Settings ***
Resource    ../resources/Common.robot
Resource    ../pages/LoginPage.robot
Resource    ../pages/ProductPage.robot
Resource    ../pages/CartPage.robot
Resource    ../resources/variables.robot
Test Setup    Initialisation Test
Test Teardown    Nettoyage

*** Test Cases ***

Test Ajout produit
    Login    ${URL}    ${BROWSER}    ${USERNAME}    ${PASSWORD}
    Ajout produit
    Passer la commande    ${FNAME_ATTRIB}    ${LNAME_ATTRIB}    ${PCODE_ATTRIB}

