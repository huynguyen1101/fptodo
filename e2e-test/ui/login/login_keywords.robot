*** Settings ***
Library    Selenium2Library
Library    String
Library    Collections
Library    BuiltIn
Resource    ../common_keywords.robot

*** Variables ***
${LANDING_HEADER}          //ul[@class="landing-header__list"]//li[normalize-space()="$$"]
${LOGIN_FORM}              //fieldset[@class="login-fieldset"]//input[@name="$$"]
${LOGIN_BTN_DISABLED}      //fieldset[@class="login-fieldset"]//button[@class="btn btn--disabled"]
${LOGIN_BTN_ENABLED}       //fieldset[@class="login-fieldset"]//button[@type="submit"]
${LEFT_NAV}                //div[@class="sidebar-menu"]
${AUTH_DIALOG}             //div[@class="label-modal"]//p[normalize-space()="$$"]
${INVALID_MESSAGE}         //div[@class="label-modal"]//ul[@class="label-modal__error"]//span[contains(text(), "Invalid")]
${USERNAME_PWD_MESSAGE}    //div[@class="label-modal"]//ul[@class="label-modal__error"]//li[contains(text(), "Username or password")]
${CLOSE_AUTH_DIALOG}       //div[@class="label-modal"]//i[contains(@class, "fa-times")]
&{HEAER_BUTTON}            Login=Login
...                        Sign-Up=Sign Up


*** Keywords ***
Verify ${button} Button Is Showing

    ${value}=    Get From Dictionary    ${HEAER_BUTTON}    ${button}
    ${btn_location}=    String Replace    ${LANDING_HEADER}    ${value}
    Wait Until Element Is Visible    ${btn_location}

Login Button Should Be Shown
    
    ${login_btn_location}=    String Replace    ${LANDING_HEADER}    &{HEAER_BUTTON}[Login]
    Wait Until Element Is Visible    ${login_btn_location}

Sign Up Button Should Be Shown
    
    ${login_btn_location}=    String Replace    ${LANDING_HEADER}    &{HEAER_BUTTON}[Sign-Up]
    Wait Until Element Is Visible    ${login_btn_location}

Go To Login Page
    
    ${login_btn_location}=    String Replace    ${LANDING_HEADER}    &{HEAER_BUTTON}[Login]
    Wait Until Element Is Visible    ${login_btn_location}
    Click Element    ${login_btn_location}

Login Button Should Be Disabled If Inputs Are Empty
    
    ${username_field}=    String Replace    ${LOGIN_FORM}    username
    ${user_name}=    Get Text    ${username_field}
    ${pwd_field}=    String Replace    ${LOGIN_FORM}    password
    ${password}=    Get Text    ${pwd_field}
    Should Be Equal    ${user_name}    ${EMPTY}
    Should Be Equal    ${password}    ${EMPTY}
    Element Should Be Visible    ${LOGIN_BTN_DISABLED}

Fill Credential
    [Arguments]    ${USER_NAME}    ${PASSWORD}

    ${username_field}=    String Replace    ${LOGIN_FORM}    username
    ${pwd_field}=    String Replace    ${LOGIN_FORM}    password
    Input Text    ${username_field}    ${USER_NAME}
    Input Text    ${pwd_field}    ${PASSWORD}

Click To Login
    Wait Until Element Is Visible    ${LOGIN_BTN_ENABLED}
    Click Element    ${LOGIN_BTN_ENABLED}

Verify Login Success
    Wait Until Element Is Visible    ${LEFT_NAV}

Login Failure Modal Should Be Shown
    ${login_dialog_locator}=    String Replace    ${AUTH_DIALOG}    Login
    Wait Until Element Is Visible    ${login_dialog_locator}
    Wait Until Element Is Visible    ${INVALID_MESSAGE}

Click To Close Authtication Modal
    Wait Until Element Is Visible    ${CLOSE_AUTH_DIALOG}
    Click Element    ${CLOSE_AUTH_DIALOG}
