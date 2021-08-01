*** Settings ***
Resource   resource.robot
Library    SeleniumLibrary

Default Tags    tag1
*** Test Cases ***
Valid Login
    Open Browser To Home Page
    Go To Login Page
    Input Username    hong
    Inputt Password    12345678
    Submit Credentials
    sleep   5
    Welcome Page Should Be Open
    [Teardown]    Close Browser