*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${PRODUCT_TITLE}     xpath=//div[text()='Sauce Labs Backpack']
${ADDTOCARTBACKPACK}    //button[@data-test='add-to-cart-sauce-labs-backpack']
${BOUTON_PANIER}    //a[@data-test='shopping-cart-link']

*** Keywords ***
Page Product visible
    Page Should Contain Element    ${PRODUCT_TITLE}

Ajout produit au panier
    Click Element    ${ADDTOCARTBACKPACK}

Clic bouton panier
    Click Element    ${BOUTON_PANIER}

Ajout produit   
    Page Product visible
    Ajout produit au panier 
    Clic bouton panier
    Page Product visible