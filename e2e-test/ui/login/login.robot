*** Settings ***
Resource    ../common_keywords.robot
Resource    login_keywords.robot


Suite Teardown    Close All Browsers

*** Test Cases ***
Verify Browser Should Be Opened
    [Tags]    test

    Open Chrome Browser to Page    ${BASE_URL}
    Login Button Should Be Shown
    Sign Up Button Should Be Shown
    Go To Login Page
    Login Button Should Be Disabled If Inputs Are Empty
    Fill Credential    ${USER_NAME}    ${PASSWORD}
    Click To Login
    Verify Login Success
