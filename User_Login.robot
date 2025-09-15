*** Settings ***
Library     AppiumLibrary

*** Test Cases ***
Login functionality with an invalid username and password.
#   Login to Salesforce Flow

    Wait Until Element Is Visible    xpath=//android.widget.TextView[@text="https://login.salesforce.com"]     20s
    Click Element    xpath=//android.widget.ImageView[@content-desc="More options"]
    Wait Until Element Is Visible    xpath=//android.widget.TextView[@resource-id="com.smartrep:id/title" and @text="Change Server"]    10s
    Click Element    xpath=//android.widget.TextView[@resource-id="com.smartrep:id/title" and @text="Change Server"]
    Wait Until Element Is Visible    xpath=//android.widget.RadioButton[@text="Sandbox\nhttps://test.salesforce.com"]    10s
    Click Element    xpath=//android.widget.RadioButton[@text="Sandbox\nhttps://test.salesforce.com"]
    Click Element    xpath=//android.widget.ImageButton[@content-desc="Navigate up"]
    Sleep    10s
    Wait Until Element Is Visible    xpath=//android.widget.Button[@text="Log In to Sandbox"]     20s
    Sleep    5s
    Input Text    xpath=//android.webkit.WebView[@text="Login | Salesforce"]/android.view.View/android.view.View/android.view.View[1]/android.view.View/android.view.View[2]/android.view.View/android.view.View[1]/android.view.View[1]/android.view.View[2]/android.widget.EditText    qa.smart@bssuniversal.com
    Input Password    xpath=//android.webkit.WebView[@text="Login | Salesforce"]/android.view.View/android.view.View/android.view.View[1]/android.view.View/android.view.View[2]/android.view.View/android.view.View[1]/android.widget.EditText    Bss@2026
    Click Element    xpath=//android.widget.Button[@text="Log In to Sandbox"]
    Wait Until Element Is Visible    xpath=//android.widget.TextView[contains(@text,"Error: Please check")]     10s
    Text Should Be Visible   Error: Please check your username and password. If you still can't log in, contact your Salesforce administrator.
    Sleep    5s


Login functionality with an valid username and password.
#   Login to Salesforce Flow
    Wait Until Element Is Visible    xpath=//android.widget.Button[@text="Log In to Sandbox"]     20s
    Sleep    5s
    Input Text    xpath=//android.webkit.WebView[@text="Login | Salesforce"]/android.view.View/android.view.View/android.view.View[1]/android.view.View/android.view.View[2]/android.view.View/android.view.View[1]/android.view.View[1]/android.view.View[2]/android.widget.EditText    qa.smartcrm@bssuniversal.com
    Input Password    xpath=//android.webkit.WebView[@text="Login | Salesforce"]/android.view.View/android.view.View/android.view.View[1]/android.view.View/android.view.View[2]/android.view.View/android.view.View[1]/android.widget.EditText    Bss@2025
    Click Element    xpath=//android.widget.Button[@text="Log In to Sandbox"]
    Sleep    10s


Verify that the user can Sync data.
#     click sync button
    Wait Until Element Is Visible    xpath=//android.widget.FrameLayout[@resource-id="android:id/content"]/android.widget.FrameLayout/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.widget.FrameLayout/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup[1]/android.widget.FrameLayout/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup[1]         20s
    Click Element    xpath=//android.widget.FrameLayout[@resource-id="android:id/content"]/android.widget.FrameLayout/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.widget.FrameLayout/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup[1]/android.widget.FrameLayout/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup[3]/android.view.ViewGroup[2]/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup
    Wait Until Element Is Visible    xpath=//android.widget.TextView[@resource-id="android:id/alertTitle" and @text="Sync Complete"]    240s
    Sleep    3s
    Click Element    xpath=//android.widget.Button[@resource-id="android:id/button1" and @text="OK"]
    Wait Until Element Is Visible    xpath=//android.widget.TextView[@text="Contacts"]     10s
    Sleep    5s
