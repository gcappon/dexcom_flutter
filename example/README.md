# dexcom_flutter example App

A simple app that demonstrates the use of dexcom_flutter.

## Instructions

To run the example application follow these steps.

* Create a Dexcom Developer account, if you do not have one, at [https://developer.dexcom.com/](https://developer.dexcom.com/).
* Login and register a new app at [https://developer.dexcom.com/user/me/apps](https://developer.dexcom.com/user/me/apps). In particular, you have to:
  
    * Choose an "Application Name" (e.g., "example").
    * (Optional) Set a brief "Description" (e.g., "Just a simple test of an awesome package.")
    * Set the a "Redirect URI"" (e.g., "example://dexcom_flutter/auth").
    * Click the "Save" button to save your settings.
* You should now see the "Client ID" and the "Client Secret" strings provided by Dexcom.
* Go to "lib/utils/strings.dart" and change the values of the following variables 
```dart
// Dexcom API Client ID
static const String dexcomClientID = 'XXX';
// Dexcom API Client Secret
static const String dexcomClientSecret = 'XXX';
```
from 'XXX' to the "Client ID" and "Client Secret" strings values provided at the previous step.
Then change the values of the following variables:
```dart
/// Auth Uri
static const String dexcomRedirectUri = 'XXX';

/// Callback scheme
static const String dexcomCallbackScheme = 'XXX';
```
from 'XXX' to 'example://dexcom_flutter/auth' and 'example', respectively.
* (To run the example on Android) Go to android/app/src/main/AndroidManifest.xml, locate the following snippet of code
```xml
<activity android:name="com.linusu.flutter_web_auth.CallbackActivity" >
      <intent-filter android:label="flutter_web_auth">
        <action android:name="android.intent.action.VIEW" />
        <category android:name="android.intent.category.DEFAULT" />
        <category android:name="android.intent.category.BROWSABLE" />
        <data android:scheme="YOUR_CALLBACK_URL_SCHEME_HERE" />
      </intent-filter>
    </activity>
```
and change ```YOUR_CALLBACK_SCHEME``` with your callback scheme (in this example ```example```)
* Run the application with `flutter run`. Enjoy!
  
