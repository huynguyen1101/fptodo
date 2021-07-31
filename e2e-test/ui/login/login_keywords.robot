*** Settings ***
Library    ExtendedSeleniumLibrary
Library    String
Library    BuiltIn
Resource    ../common_keywords.robot

*** Variables ***
${LANDING_HEADER}    //ul[@class="landing-header__list"]//li[normalize-space()="$$"]
${LOGIN_FORM}      //fieldset[@class="login-fieldset"]//input[@name="$$"]
${LOGIN_BTN_DISABLED}    //fieldset[@class="login-fieldset"]//button[@class="btn btn--disabled"]
${LOGIN_BTN_ENABLED}    //fieldset[@class="login-fieldset"]//button[@type="submit"]
${LEFT_NAV}    //div[@class="sidebar-menu"]
&{HEAER_BUTTON}    LOGIN=Login
...                SIGN_UP=Sign Up

*** Keywords ***

Login Button Should Be Shown
    
    ${login_btn_location}=    Replace String    ${LANDING_HEADER}    $$    &{HEAER_BUTTON}[LOGIN]
    Wait Until Element Is Visible    ${login_btn_location}

Sign Up Button Should Be Shown
    
    ${login_btn_location}=    Replace String    ${LANDING_HEADER}    $$    &{HEAER_BUTTON}[SIGN_UP]
    Wait Until Element Is Visible    ${login_btn_location}

Go To Login Page
    
    ${login_btn_location}=    Replace String    ${LANDING_HEADER}    $$    &{HEAER_BUTTON}[LOGIN]
    Wait Until Element Is Visible    ${login_btn_location}
    Click Element    ${login_btn_location}

Login Button Should Be Disabled If Inputs Are Empty
    
    ${username_field}=    Replace String    ${LOGIN_FORM}    $$    username 
    ${user_name}=    Get Text    ${username_field}
    ${pwd_field}=    Replace String    ${LOGIN_FORM}    $$    password
    ${password}=    Get Text    ${pwd_field}
    Should Be Equal    ${user_name}    ${EMPTY}
    Should Be Equal    ${password}    ${EMPTY}
    Element Should Be Visible    ${LOGIN_BTN_DISABLED}

Fill Credential
    [Arguments]    ${USER_NAME}    ${PASSWORD}

    ${username_field}=    Replace String    ${LOGIN_FORM}    $$    username
    ${pwd_field}=    Replace String    ${LOGIN_FORM}    $$    password
    Input Text    ${username_field}    ${USER_NAME}
    Input Text    ${pwd_field}    ${PASSWORD}

Click To Login
    Wait Until Element Is Visible    ${LOGIN_BTN_ENABLED}
    Click Element    ${LOGIN_BTN_ENABLED}

Verify Login Success
    Wait Until Element Is Visible    ${LEFT_NAV}
