*** Settings ***
Library    OperatingSystem
Library    ../lib/ExtendedSeleniumLibrary.py
Resource   ./variables.robot


*** Keywords ***
Open Chrome Browser to Page
    [Arguments]     ${URL}    ${BROWSER}=Chrome

    ${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    Call Method    ${chrome_options}    add_argument    --start-maximized
    Call Method    ${chrome_options}    add_argument    --no-sandbox
    
    Create Webdriver    ${BROWSER}    chrome_options=${chrome_options}    executable_path=C:/WebDrivers/chromedriver.exe
    Go To    ${URL}
