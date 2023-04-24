# NFC SIC plugin for Flutter

A NFC SIC Flutter plugin for manage the NFC features. Supported on both Android and iOS.

![Logo](.gitlab/images/nfc-flutter-logo.jpg)

Plugin to help developers looking to use internal hardware inside iOS or Android devices for reading and writing NFC tags.

The system activates a pooling reading session that stops automatically once a tag has been recognized. You can also trigger the stop event manually using a dedicated function.

## Getting Started

This project is a starting point for a Flutter [plug-in package](https://flutter.dev/developing-packages/), a specialized package that includes platform-specific implementation code for Android and/or iOS.

For help getting started with Flutter, view our [online documentation](https://flutter.dev/docs), which offers tutorials, samples, guidance on mobile development, and a full API reference.

## Supported NFC Format

The following platform-specific-tag classes are available:

***Android***

* NfcA

***iOS***

* MiFare

***Usage***

Used via the Sic4341 class.

```dart
/// transceive command one packet
List<int> recv = await Sic4341.instance.autoTransceive(
    Uint8List.fromList(<int>[]));

/// transceive command many packets
List<int> recv = await Sic4341.instance.autoTransceives(
    <Uint8List>[]);
```

Used via the NFC class directly.

```dart
/// transceive command one packet
List<int> recv = await NFC.instance.transceive(
    data: Uint8List.fromList(<int>[]),
    disconnect: true/false);

/// transceive command many packets
List<int> recv = await NFC.instance.transceives(
    data: <Uint8List>[],
    disconnect: true/false);
```

## Installation

Download or clone repository and add a dependency on the `nfc_sic` package in the `dependencies` section of pubspec.yaml (recommend use this):

```yaml
dependencies:
  nfc_sic:
    path: ../PATH_ROOT_DIRECTORY_PLUGIN/
```

or to get the experimental one:

```yaml
dependencies:
  nfc_sic:
    git:
      url: git://git.sic.co.th/sukawit/nfc-eco-plugin.git
      ref: master
```

and then run the shell.

```cmd
flutter pub get
```

last step import to the project:

```dart
import 'package:nfc_sic/nfc_sic.dart';
```

## Android Setup

* Add [android.permission.NFC](https://developer.android.com/reference/android/Manifest.permission.html#NFC) to your `AndroidMenifest.xml`

```xml
<uses-permission android:name="android.permission.NFC" />
```

If your app **requires** NFC, you can add the following to only allow it to be downloaded on devices that supports NFC:

```xml
<uses-feature
    android:name="android.hardware.nfc"
    android:required="true" />
```

* Assign 19 in minSdkVersion in the `build.gradle (Module: app)`

```gradle
defaultConfig {
    ...
    minSdkVersion 19
    ...
}
```

## iOS Setup

On iOS you must add turn on the Near Field Communication capability, add a NFC usage description and a NFC entitlement.

### Turn on Near Field Communication Tag Reading

Open your iOS project in Xcode, find your project's target and navigate to Capabilities. Scroll down to `Near Field Communication Tag Reading` and turn it on.

Turning on `Near Field Communication Tag reading`

* Adds the NFC tag-reading feature to the App ID.

* Enable Capabilities / Near Field Communication Tag Reading.
  * Add [Near Field Communication Tag Reader Session Formats Entitlements](https://developer.apple.com/documentation/bundleresources/entitlements/com_apple_developer_nfc_readersession_formats) to your entitlements.

!['Turn on Near Field Communication Tag Reading' capability  turned on for a project in Xcode](.gitlab/images/nfc-setup-xcode.png)

from [developer.apple.com: Building an NFC Tag-Reader app](https://developer.apple.com/documentation/corenfc/building_an_nfc_tag-reader_app?language=objc)

### NFC Usage Description

Open your `ios/Runner/Info.plist` file. It's value should be a description of what you plan on using NFC for.

* Add [NFCReaderUsageDescription](https://developer.apple.com/documentation/bundleresources/information_property_list/nfcreaderusagedescription) to your `Info.plist`

```plist
<key>NFCReaderUsageDescription</key>
<string>...</string>
```

* Add [com.apple.developer.nfc.readersession.felica.systemcodes](https://developer.apple.com/documentation/bundleresources/information_property_list/systemcodes) and [com.apple.developer.nfc.readersession.iso7816.select-identifiers](https://developer.apple.com/documentation/bundleresources/information_property_list/select-identifiers) to your `Info.plist` as needed.

```plist
<key>com.apple.developer.nfc.readersession.felica.systemcodes</key>
<array>
    <string>...</string>
    ...
</array>

<key>com.apple.developer.nfc.readersession.iso7816.select-identifiers</key>
<array>
    <string>...</string>
    ...
</array>
```

In your Podfile add this code in the top.

```ruby
platform :ios, '13.0'
use_frameworks!
```

## IOS Specifics

When you call `NFCTagReaderSession(...)` on iOS, Core NFC (the iOS framework that allows NFC reading) opens a little window. On Android it just starts listening for NFC tag reads in the background.

* Timeout when used tag session.
  * when transceive timing open session approximately 20 second.
  * when wait tap a tag timing open session approximately 1 minute.

* IOS behaves a bit different in terms of NFC reading and writing.
  * Ids of the tags aren't possible in the current implementation.
  * each scan is visible for the user with a bottom sheet.

![Core NFC](https://developer.apple.com/design/human-interface-guidelines/ios/images/Core_NFC.png)

image from [developer.apple.com: Near Field Communication](https://developer.apple.com/design/human-interface-guidelines/ios/user-interaction/near-field-communication/)

## Error handling

Errors are no exception to NFC in Flutter. The call function returned by `transceive(...)` can send via `SessionErrorCallback` different exceptions (iOS only), and even worse; they are different for each platform.

## Example Usage

### Managing Tag Session

```dart
// Start session and register callback.
NFC.session.startSession(
    onTagDiscovered: (Uint8List uid) {
        // Manipulating tag.
    },
    pollingOption: [
        TagPollingOption.iso14443,
    ].toSet(),
    // used on iOS only.
    alertMessage: "Please tap a tag",
    // used on iOS only.
    onSessionError: (SessionError error) {
        // Manipulating tag session error.
    },
);

// Stop session and unregister callback.
NFC.session.stopSession(
    // used on iOS only.
    errorMessage: 'Error!!',
    // used on iOS only.
    alertMessage: 'Success!!',
);
```

### Managing Process Calibration

```dart
// Start session and register callback.
NFC.session.startSession(
    onTagDiscovered: tagCallBack,
    pollingOption: [
        TagPollingOption.iso14443,
    ].toSet(),
    // used on iOS only.
    alertMessage: "Please tap a tag",
    // used on iOS only.
    onSessionError: (SessionError error) {
        // Manipulating tag session error.
    },
);

Managers.setting.get().mode = Mode...;

Calibration calibrate = Calibration(
    onNextCallback: (IoData data) {
        // Manipulating on process finish.
    },
    onErrorCallback: (Object error, [StackTrace stackTrace]) {
        // Manipulating process error.
    },
    onStartCallback: (IoData data) {
        // Manipulating on start process.
    },
    onEndCallback: (IoData data) {
        // Manipulating on end process.
    },
    onDoneCallback: () {
        // Manipulating when process finish.
    },
);

// Set with tag discovered callback on tap a tag.
// don't forget register onTagDiscovered callback in NFC.session.
void tagCallBack(Uint8List uid) {
    final isTagSIC = Task.reaction.checkUid();

    if ( isTagSIC ) {
      calibrate?.start(IoData());
    }
}
```

### Managing Process Conversion

```dart
Conversion conversion = new Conversion<T>(
    onNextActionCallback: (IoData data) {
        // Manipulating on process before start conversion finish.
    },
    onNextReactionCallback: (T obj) {
        // Manipulating on process conversion send result.
    },
    onErrorCallback: (Object error, [StackTrace stackTrace]) {
        // Manipulating process error.
    },
    onMapStartCallback: (IoData data) {
        // Manipulating before process start conversion finish.
        return data;
    },
    onMapResultCallback: (IoData data, int index) {
        // Manipulating value with conversion send index.
        return T();
    },
    onCycleCallback: (int cycle) {
        // Manipulating counter of cycle process conversion.
    },
    onConditionCallback: (IoData data) {
        // Manipulating before process conditioning start running.
    },
    onDepositionCallback: (IoData data) {
        // Manipulating before process deposition start running.
    },
    onConversionCallback: (IoData data) {
        // Manipulating before process conversion start running.
    },
    onDoneCallback: (IoData data) {
        // Manipulating all process finish.
    },
);

conversion.start(IoData());
```

## Example App

See [Chemister](http://git.sic.co.th/sukawit/nfc-eco-app) or [SIC-Toxin](http://git.sic.co.th/sukawit/toxin-app) which is a Real-World-App demonstrates how to use this plugin.
