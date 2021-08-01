*** Settings ***
Library     Selenium2Library
Library     FakerLibrary
Resource    home_keywords.robot
Resource    ../login/login_keywords.robot
Resource    ../variables.robot
Test Setup    Click To Close Add New Board Modal If Visible
Suite Teardown    Close All Browsers
Force Tags    home

*** Test Cases ***
Verify Left Navigation
    Open Browser With Alias    ${BASE_URL}
    Go To Login Page
    Fill Credential    ${USER_NAME}    ${PASSWORD}
    Click To Login
    Close Adding Board Modal
    @{menus}=    Create List    Board    Dashboard    Templates    Feed    User    Setting    Project
    Left Navigation Should Be Displayed
    Left Nav Should Contains    @{menus}

Verify General UI
    Switch Browser    ${BROWSER_ALIAS}
    Board Header Should Be Shown

Create A New Board
    ${board_name}=    FakerLibrary.Text    10
    Switch Browser    ${BROWSER_ALIAS}
    Click To Create A New Board
    Add Board Modal Should Be Shown
    Input Board Name    ${board_name}
    Click Submit Button To Create A New Board
    Home Board Should Contains    ${board_name}

Verify Background Picker Able To Expand/Collapse
    Switch Browser    ${BROWSER_ALIAS}
    Click To Create A New Board
    Add Board Modal Should Be Shown
    Backgroud Picker Should Be Expanded When Clicking Three Dots
    Backgroud Picker Should Be Collapsed When Clicking Close
