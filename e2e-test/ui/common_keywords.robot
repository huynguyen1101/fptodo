*** Settings ***
Library    OperatingSystem
Library    String
Library    Selenium2Library
Resource   ./variables.robot


*** Keywords ***
Open Chrome Browser Go To Page
    [Arguments]     ${URL}    ${BROWSER}=Chrome    ${alias}=None

    ${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    Call Method    ${chrome_options}    add_argument    --start-maximized
    Call Method    ${chrome_options}    add_argument    --no-sandbox
    
    Create Webdriver    driver_name=${BROWSER}    alias=${alias}    chrome_options=${chrome_options}    executable_path=C:/WebDrivers/chromedriver.exe
    Go To    ${URL}
    [Return]    ${alias}

String Replace
    [Arguments]    ${from_str}    @{replacement_strings}

    :FOR    ${string}    IN    @{replacement_strings}
    \    ${from_str} =   Replace String    ${from_str}   $$   ${string}    count=1

    [Return]    ${from_str}

Click If Element Is Visible
    [Arguments]    ${locator}    ${timeout}=5s

    Wait Until Element Is Visible    ${locator}    ${timeout}
    Click Element    ${locator}

Get CSS Property Value
    [Arguments]    ${locator}    ${attribute name}

    ${css}=    Get WebElement    ${locator}
    ${prop_val}=    Call Method    ${css}    value_of_css_property    ${attribute name}
    [Return]     ${prop_val}
