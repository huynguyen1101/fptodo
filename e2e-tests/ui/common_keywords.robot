*** Library ***
Library    SeleniumLibrary
Library    OperatingSystem

*** Settings ***
Resource    ./variables.robot

*** Keywords ***

Browser Configuration
    [Arguments]    ${BROWSER}='Chrome'

    IF '${BROWSER}'=='Chrome'
        ${options}=    sys.modules['selenium.webdriver.chrome.options'].Options()    sys

Go To Home Page
    Open Browser    ${BASE_URL}    ${BROWSER}
    sleep    5
    Maximize Browser Window
    Set Selenium Speed    ${DELAY}
    Home Page Should Be Open