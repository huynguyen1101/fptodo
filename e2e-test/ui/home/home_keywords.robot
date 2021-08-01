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
