*** Settings ***
Library    SeleniumLibrary
*** Variables ***
${SERVER}         localhost:3000
${BROWSER}        chrome
${DELAY}          0
${VALID USER}     hong
${VALID PASSWORD}    12345678
${LOGIN URL}      http://${SERVER}/login
${WELCOME URL}    http://${SERVER}/
${USENAME FIELD}    //*[@id="root"]/div[2]/div[2]/form/fieldset/input[1]
${PASSWORD FIELD}    //*[@id="root"]/div[2]/div[2]/form/fieldset/input[2]
${lOGIN BUTTON}    //*[@id="root"]/div[2]/div[2]/form/fieldset/button

*** Keywords ***
Open Browser To Home Page
    Open Browser    ${WELCOME URL}    ${BROWSER}
    sleep    5
    Maximize Browser Window
    Set Selenium Speed    ${DELAY}
    Home Page Should Be Open

Home Page Should Be Open
    Title Should Be    FPTODO
    
Login Page Should Be Open
    Title Should Be   Login | FPTODO

Go To Login Page
    Go To    ${LOGIN URL}
    sleep   5
    Login Page Should Be Open

Input Username
    [Arguments]    ${username}
    Input Text    ${USENAME FIELD}    ${username}

Inputt Password
    [Arguments]    ${password}
    Input Text    ${PASSWORD FIELD}    ${password}

Submit Credentials
    Click Button    ${lOGIN BUTTON}

Welcome Page Should Be Open
    Location Should Be    ${WELCOME URL}
    Title Should Be   Boards | FPTODO
