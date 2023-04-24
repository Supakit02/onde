# 1.2.0-dev

## New Feature

* Create post processing method for filter data result.
* Create polynomial fit curve method for fix current.

## Change

* variable name in setting model.
* argument name in conversion class.

## Breaking

* The `ANODIC_STRIPPING_VOLTAMMETRY_MODE` in ***Mode*** enums has been renamed to `LINEAR_SWEEP_VOLTAMMETRY_MODE`.
* Function utility.
  * The `FileUtil` class has been renamed to `FileFunc`.
  * The `ReactUtil` class has been renamed to `ReactFunc`.
  * The `RxUtil` class has been renamed to `RxFunc`.
  * The `ReportUtil` class has been renamed to `ReportFunc` and change to private class, access using by ***getReport()*** method in mode extension.
* Others class.
  * The `Tasks` class has been renamed to `Task`.
  * The `Managers` class has been renamed to `Manager`.
  * The `Preferences` class has been renamed to `Preference`.

## Deprecated

* The `FuncUtil` class has been deprecated.
* The `FuncUtil` class has been moved functional to `ReactFunc`.

## Security Fix

* Update optimization syntax code.
  * Add pedantic for dart analyzer syntax code.

## Maintenance

* Update modules in plugin for supported `Chemister` app 5.2.x new version.

## Documentation

* Update example app.
* Update README and CONTRIBUTING.

# 1.1.3

* Fix streaming subscription managers method in **RxHelper** class.
* Change class name **NfcSessionManager** -> **NfcSession**.
* Update singleton instance class method reference.
  * Create `Tasks` class for provide instance in NFC tasks.
  * Create `Managers` class for provide instance in data managers.
  * Create `Preferences` class for provide instance `SharedPreferences` of settings.
* Update `CaptureException` class and error handling.
  * Remove `errorStream` method.
  * Remove `errorCondition` method.
  * Remove `unimplementedError` method.
  * Create `NoCaseError` class for thrown by operations that have not been case in switch-case.
  * Create `TaskException` class for thrown by operations that have error within the try-catch block on NFC tasks.
  * Create `OthersException` class for thrown by operations that have error within the try-catch block.

# 1.1.2

* Update all manager method in ioData class.
* Update function utils.
* Update report files method.
* Update exception callback in CaptureException.
* Update reference instance.

# 1.1.1

* Update conversion process.
  * Add reset time task for send counter to display.
* Update NFC transaction.
  * Add lifecycle manager for android platform.
  * Update transceive and timeout method.
* Update **CaptureException** class.
  * Change name method **error** to **errorCondition**.
  * Change name method **errorAction** to **errorStream**.
  * Add enumerated type `CaptureExceptionType`.

# 1.1.0

* Add new mode for square wave voltammetry feature.
* Add shorted deposition method.
* Fix bug calibration feature.
* Fix pulse period and pulse width for differential pulse voltammetry feature.
* Close auto drop detection method in all mode.

# 1.0.2

* Fix throw exception for capture error creating via `CaptureException` and have `exceptionCallback` for register callbacks send session on all error methods.
  * `CaptureException.error(...)` for show normal error message via `debugPrint` (no return).
  * `CaptureException.errorAction(...)` for capture error action on streaming (no return).
  * `CaptureException.exception(...)` for using on try catch error  (return `Exception` for throw).
  * `CaptureException.unimplementedError(...)` for using on switch case unimplemented case error (return `UnimplementedError` for throw).

# 1.0.1

* Change class name **NfcPlugin** -> **NfcSessionManager**.
* Bypass when conversion is error can see result.
* Fix save and restore filename setting.
* Update save data result to log files.
* Update code at native platform.

# 1.0.0

* Initial release version.
