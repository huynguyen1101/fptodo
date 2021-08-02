*** Settings ***
Library    Selenium2Library
Library    String
Library    Collections
Library    BuiltIn
Resource    ../common_keywords.robot

*** Variables ***
${ADD_BOARD_MODAL}                //div[@class="addboard-modal"]
${ADD_BOARD_HINT}                 ${ADD_BOARD_MODAL}//input[@placeholder="Add board title"]
${BG_PICKER_MODAL}                ${ADD_BOARD_MODAL}//div[@class="addboard-modal__right"]
${BG_PIDKCER_EXPAND_BTN}          ${BG_PICKER_MODAL}//button[@class="addboard-modal__color-box"]//i[contains(@class, "fa-ellipsis-h")]
${BG_PICKER_EXPANDED_MODAL}       //div[@class="label-modal--bg label-modal"]
${CLOSE_EXPAND_MODAL}             ${BG_PICKER_EXPANDED_MODAL}//i[contains(@class, "fa-times")]
${CLOSE_ADDING_MODAL}             ${ADD_BOARD_MODAL}//i[contains(@class, "fa-times")]
${LEFT_NAVIGATION}                //div[@class="sidebar-menu"]
${LEFT_NAV_MENU}                  ${LEFT_NAVIGATION}//span[normalize-space()="$$"]
${HOME_TITLE}                     //p[@class="home__title" and contains(text(), " Personal Boards")]
${CREATE_BOARD_BTN}               //div[@class="home__section"]//button[@class="btn" and normalize-space()="Create"]
${BOARD_NAME_INPUT}               ${ADD_BOARD_MODAL}//input[@class="addboard-modal__title"]
${SUBMIT_ADDING_BOARD_BTN}        ${ADD_BOARD_MODAL}//button[contains(@class, "addboard-modal__create")]
${HOME_BOARD}                     //div[@class="home__boards"]
${BOARD_PREVIEW}                  ${HOME_BOARD}//a[@class="board-preview"]//p[@class="board-preview__title" and normalize-space()="$$"]
${LEFT_NAV_ITEM}                  //ul[@class="nav-links"]//li//span[normalize-space()="$$"]
${PROJECT_EXPAND_COLLAPSE_ICON}   //ul[@class="nav-links"]//li//span[normalize-space()="Project"]//parent::a/following-sibling::i
${PROJECT_LEFT_NAV_SUBMENU}       //ul[@class="nav-links"]//li//ul[@class="sub-menu"]
${LEFT_NAV_PROJECT_EXPANDED}      //ul[@class="nav-links"]//span[normalize-space()="Project"]//parent::a//parent::div//parent::li[@class="show"]
${LEFT_NAV_PRJ_ITEM}              ${PROJECT_LEFT_NAV_SUBMENU}//span[normalize-space()="$$"]
${CREATE_PRJ_MODAL}               //div[@class="create-team"]//p[normalize-space()="Start a Project"]
${PROJECT_NAME_INPUT}             //div[@class="create-team"]//input[@name="title"]
${PROJECT_DESC_INPUT}             //div[@class="create-team"]//textarea[@name="description"]
${CREATE_PROJECT_BTN}             //div[@class="create-team"]//button[@type="submit"]
${LEFT_NAV_CREATE_PRJ_ICON}       //ul[@class="nav-links"]//span[normalize-space()="Project"]//preceding-sibling::button/i
${LEFT_NAV_PROJECT_ARROW_UP}      matrix(-1, -1.22465e-16, 1.22465e-16, -1, 0, 0)
${LEFT_NAV_PROJECT_ARROW_DOWN}    none

*** Keywords ***
Add Board Modal Should Be Shown
    Wait Until Element Is Visible    ${ADD_BOARD_MODAL}
    Wait Until Element Is Visible    ${ADD_BOARD_HINT}
    Wait Until Element Is Visible    ${BG_PICKER_MODAL}

Backgroud Picker Should Be Expanded When Clicking Three Dots
    Click If Element Is Visible    ${BG_PIDKCER_EXPAND_BTN}    
    Wait Until Element Is Visible    ${BG_PICKER_EXPANDED_MODAL}

Backgroud Picker Should Be Collapsed When Clicking Close
    Click If Element Is Visible    ${CLOSE_EXPAND_MODAL}
    Wait Until Element Is Not Visible    ${BG_PICKER_EXPANDED_MODAL}

Close Adding Board Modal
    Click If Element Is Visible    ${CLOSE_ADDING_MODAL}

Left Navigation Should Be Displayed
    Wait Until Element Is Visible    ${LEFT_NAVIGATION}

Left Nav Should Contains
    [Arguments]    @{items}
    
    :FOR    ${item}    IN    @{items}
    \    ${menu}=    String Replace    ${LEFT_NAV_MENU}    ${item}
    \    Wait Until Element Is Visible    ${menu}

Board Header Should Be Shown
    Wait Until Element Is Visible    ${HOME_TITLE}
    
Click To Create A New Board
    Click If Element Is Visible    ${CREATE_BOARD_BTN}

Input Board Name
    [Arguments]    ${board_name}
    
    Input Text    ${BOARD_NAME_INPUT}    ${board_name}

Click Submit Button To Create A New Board
    Click If Element Is Visible    ${SUBMIT_ADDING_BOARD_BTN}

Home Board Should Contains
    [Arguments]    ${board_name}
    
    ${board}=    String Replace    ${BOARD_PREVIEW}    ${board_name}
    Wait Until Element Is Visible    ${board}

Click To Close Add New Board Modal If Visible
    ${is_modal_visible}=    Run Keyword And Return Status    Element Should Be Visible    ${ADD_BOARD_MODAL}
    Run Keyword If    ${is_modal_visible}    Close Adding Board Modal

Open Browser With Alias
    [Arguments]    ${URL}    ${alias}=fptodo

    Open Chrome Browser Go To Page     ${URL}   Chrome    ${alias}
    Set Suite Variable    ${BROWSER_ALIAS}    ${alias}

Click To Collapse Background Picker
    Click If Element Is Visible    ${CLOSE_EXPAND_MODAL}

Project Should Be Collapsed By Default
    Page Should Not Contain Element    ${LEFT_NAV_PROJECT_EXPANDED}

Click To Expand Project
    ${is_expanded}=    Run Keyword And Return Status    Page Should Contain Element    ${LEFT_NAV_PROJECT_EXPANDED}
    Run Keyword If    ${is_expanded}==False    Run Keywords    Click If Element Is Visible    ${PROJECT_EXPAND_COLLAPSE_ICON}
    ...                                                 AND    Wait Until Element Is Visible    ${LEFT_NAV_PROJECT_EXPANDED}
    ...                                                 AND    Sleep    0.5s

Expand Icon Should Be Up Arrow
    ${style}=    Get CSS Property Value    ${PROJECT_EXPAND_COLLAPSE_ICON}    transform
    Should Be Equal As Strings    ${style}    ${LEFT_NAV_PROJECT_ARROW_UP}


Expand Icon Should Be Down Arrow
    ${style}=    Get CSS Property Value    ${PROJECT_EXPAND_COLLAPSE_ICON}    transform
    Should Be Equal As Strings    ${style}    ${LEFT_NAV_PROJECT_ARROW_DOWN}

Click To Collapse Project
    ${is_expanded}=    Run Keyword And Return Status    Page Should Contain Element    ${LEFT_NAV_PROJECT_EXPANDED}
    Run Keyword If    ${is_expanded}==True    Run Keywords    Click If Element Is Visible    ${PROJECT_EXPAND_COLLAPSE_ICON}
    ...                                                AND    Wait Until Element Is Not Visible    ${LEFT_NAV_PROJECT_EXPANDED}
    ...                                                AND    Sleep    0.5s

Left Nav Project Should Contains
    [Arguments]    ${prj_name}

    ${prj_locator}=    String Replace    ${LEFT_NAV_PRJ_ITEM}    ${prj_name}
    Wait Until Element Is Visible    ${prj_locator}

Create New Project Modal Should Be Shown
    Wait Until Element Is Visible    ${CREATE_PRJ_MODAL}

Enter Project Name
    [Arguments]    ${prj_name}

    Wait Until Element Is Visible    ${PROJECT_NAME_INPUT}
    Input Text    ${PROJECT_NAME_INPUT}    ${prj_name}

Enter Project Description
    [Arguments]    ${prj_description}

    Wait Until Element Is Visible    ${PROJECT_DESC_INPUT}
    Input Text    ${PROJECT_DESC_INPUT}    ${prj_description}

Enter Project Name And Description
    [Arguments]    ${prj_name}    ${prj_description}

    Enter Project Name    ${prj_name}
    Enter Project Description    ${prj_description}

Click Create Project Button
    Click If Element Is Visible    ${CREATE_PROJECT_BTN}

Click To Open Create Project Modal
    Click If Element Is Visible    ${LEFT_NAV_CREATE_PRJ_ICON}
