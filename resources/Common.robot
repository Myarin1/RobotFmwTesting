*** Settings ***
Library    SeleniumLibrary    run_on_failure=Nothing
Library    String

*** Keywords ***

Initialisation Test
    Close All Browsers

Nettoyage
    Run Keyword If Test Failed    Screenshot Avec Nom Du Test
    Close Browser

Screenshot Avec Nom Du Test
    ${safe_name}=    Replace String    ${TEST NAME}    ${SPACE}    _
    Capture Page Screenshot    ${safe_name + "_error"}.png
