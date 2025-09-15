*** Settings ***
Resource    resources.robot
Suite Setup    Open SmartRep App
Suite Teardown    Close SmartRep App

*** Test Cases ***
Verify App Launch
    [Documentation]    Just verifies the app can be opened.
    Sleep    5s
