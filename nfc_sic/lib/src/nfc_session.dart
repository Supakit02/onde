part of nfc_sic.nfc;

/// Signature for `NfcSession.startSession` onTagDiscovered callback.
/// Callback for handling on NFC tag detection.
typedef _TagCallback = void Function(Uint8List uid);

/// Signature for `NfcSession.startSession` onSessionError callback.
/// Callback for handling on NFC error from the session.
typedef _SessionErrorCallback = void Function(SessionError error);

/// Plugin for managing NFC session.
///
/// This class call function others via instance class only.
///
/// ### Example
///
/// {@tool snippet}
/// ```dart
/// @override
/// void initState() {
///   super.initState();
///   NFC.session.startSession(
///     alertMessage: "Please tap a tag",
///     pollingOption: [
///       TagPollingOption.iso14443,
///     ].toSet(),
///     onTagDiscovered: (uid) {
///       print("$uid");
///     },
///     onSessionError: (err) {
///       print("$err");
///     }
///   );
/// }
///
/// @override
/// void dispose() {
///   NFC.session.stopSession();
///   super.dispose();
/// }
/// ```
/// {@end-tool}
///
/// don't forget calling startSession(...) before tap to tag
/// and stopSession(...) when error or dispose class.
class _NfcSession {
  _NfcSession._() {
    channel.setMethodCallHandler(_handleMethodCall);
  }

  _TagCallback _onTagDiscovered;
  _SessionErrorCallback _onSessionError;

  // ignore: use_setters_to_change_properties
  /// Callback for handling on NFC tag detection.
  void setOnTagDiscovered(_TagCallback callBack) {
    _onTagDiscovered = callBack;
  }

  // ignore: use_setters_to_change_properties
  /// Callback for handling on NFC error from the session.
  /// (`Currently iOS only`)
  void setOnSessionError(_SessionErrorCallback callBack) {
    _onSessionError = callBack;
  }

  /// Checks whether the NFC features are available.
  Future<bool> isAvailable() async {
    try {
      return channel.invokeMethod("isAvailable");
    } catch (error, stackTrace) {
      throw PlatformException(
        code: "isAvailable",
        message: "NFC features are not available",
        details: error,
        stacktrace: stackTrace?.toString()
          ?? StackTrace.current.toString());
    }
  }

  /// Start the session and register callbacks for
  /// tag discovery.
  ///
  /// This uses `NFCTagReaderSession` on iOS,
  /// `NfcAdapter#enableReaderMode` on Android.
  /// Requires iOS 13.0 or Android API level 19,
  /// or later.
  ///
  /// `onTagDiscovered` is called whenever the tag
  /// is discovered.
  ///
  /// `pollingOptions` is used to specify the type
  /// of tags to be discovered. (default all types)
  ///
  /// On iOS only, `alertMessage` is used to display
  /// the message on the popup shown when the session
  /// is started.
  ///
  /// `onSessionError` is called when the session stops
  /// for any reason after the session started.
  Future<void> startSession({
    _TagCallback onTagDiscovered,
    Set<TagPollingOption> pollingOption,
    String alertMessage,
    _SessionErrorCallback onSessionError,
  }) async {
    try {
      _onTagDiscovered = onTagDiscovered;
      _onSessionError = onSessionError;
      pollingOption ??= TagPollingOption.values.toSet();

      return channel.invokeMethod(
        "startSession", {
          'pollingOptions': pollingOption.map(
            (tag) => tag.value).toList(),
          'alertMessage': alertMessage,
        });
    } catch (error, stackTrace) {
      throw PlatformException(
        code: "startSession",
        message: "NFC features are not open NFC tag session",
        details: error,
        stacktrace: stackTrace?.toString()
          ?? StackTrace.current.toString());
    }
  }

  /// Stop the session and unregister callback.
  ///
  /// This uses `NFCTagReaderSession` on iOS,
  /// `NfcAdapter#disableReaderMode` on Android.
  /// Requires iOS 13.0 or Android API level 19,
  /// or later.
  ///
  /// On iOS only, `alertMessage` and `errorMessage`
  /// are used to display the success or error message
  /// on the popup.
  ///
  /// Use `alertMessage` to indicate the success,
  /// and `errorMessage` to indicate the failure.
  ///
  /// When both are used, `errorMessage` has priority.
  Future<void> stopSession({
    String errorMessage,
    String alertMessage,
  }) async {
    try {
      _onTagDiscovered = null;
      _onSessionError = null;

      return channel.invokeMethod(
        "stopSession", {
          'errorMessage': errorMessage,
          'alertMessage': alertMessage,
        });
    } catch (error, stackTrace) {
      throw PlatformException(
        code: "stopSession",
        message: "NFC features are not close NFC tag session",
        details: error,
        stacktrace: stackTrace?.toString()
          ?? StackTrace.current.toString());
    }
  }

  /// A callback for receiving method calls on channel.
  ///
  /// The callback will replace the currently registered
  /// callback for channel, if any. To remove the handler,
  /// pass null as the `handler` argument.
  Future<void> _handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case 'onTagDiscovered':
        _handleOnTagDiscovered(call);
        break;

      case 'onSessionError':
        _handleOnSessionError(call);
        break;

      default:
        throw NoCaseError(
          value: call.method,
          type: runtimeType,
          method: "handleMethodCall",
          message: "Unexpected method value");
    }
  }

  void _handleOnTagDiscovered(MethodCall call) {
    final _uid = Uint8List.fromList(
      call.arguments as List<int>);

    Sic4341.instance.setUid(_uid);
    _onTagDiscovered?.call(_uid);
  }

  void _handleOnSessionError(MethodCall call) {
    final _error = SessionError.fromMap(
      Map<String, dynamic>.from(call.arguments as Map));

    _onSessionError?.call(_error);
  }
}