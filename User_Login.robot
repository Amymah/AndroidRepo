*** Settings ***
Resource    resources.robot
Suite Setup    Open SmartRep App
Suite Teardown    Close SmartRep App

*** Test Cases ***
Login functionality with an invalid username and password.
    Wait Until Element Is Visible    xpath=//android.widget.TextView[@text="https://login.salesforce.com"]    20s
    Click Element    xpath=//android.widget.ImageView[@content-desc="More options"]
    # ... rest of your steps

Login functionality with a valid username and password.
    Wait Until Element Is Visible    xpath=//android.widget.Button[@text="Log In to Sandbox"]    20s
    # ... rest of your steps

Verify that the user can Sync data.
    Wait Until Element Is Visible    xpath=//android.widget.FrameLayout[@resource-id="android:id/content"]/...    20s
    # ... rest of your sync steps
