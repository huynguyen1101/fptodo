*** Settings ***
Library    Selenium2Library
Resource    ../common_keywords.robot
Resource    login_keywords.robot
Test Setup    Set Library Search Order    SeleniumLibrary
Suite Teardown    Close All Browsers
Test Teardown    Close All Browsers
Force Tags    login

*** Test Cases ***
User Successful Logged In

    Open Chrome Browser Go To Page    ${BASE_URL}
    Verify Login Button Is Showing
    Verify Sign-Up Button Is Showing
    Go To Login Page
    Login Button Should Be Disabled If Inputs Are Empty
    Fill Credential    ${USER_NAME}    ${PASSWORD}
    Click To Login
    Verify Login Success

User Login In Failed
    [Teardown]    Click To Close Authtication Modal

    Open Chrome Browser Go To Page    ${BASE_URL}
    Verify Login Button Is Showing
    Verify Sign-Up Button Is Showing
    Go To Login Page
    Login Button Should Be Disabled If Inputs Are Empty
    Fill Credential    Faker    invalid
    Click To Login
    Login Failure Modal Should Be Shown
