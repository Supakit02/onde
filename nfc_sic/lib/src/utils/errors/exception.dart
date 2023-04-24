part of nfc_sic.utils;

/// Handling on all error from nfc plugin.
class CaptureException {
  CaptureException._();

  static CaptureException _instance;

  /// Singleton instance of CaptureException.
  // ignore: prefer_constructors_over_static_methods
  static CaptureException get instance =>
      _instance ??= CaptureException._();

  Exception exception({
    String message,
    Object error,
    StackTrace stackTrace,
    String library,
  }) {
    // debugPrint("$message: $error");
    message ??= "unknown";
    library ??= "NFC SIC Exception";
    error ??= Exception(message);
    stackTrace ??= StackTrace.fromString(message);

    if ( error is! Exception ) {
      error = Exception("$error");
    }

    FlutterError.reportError(
      FlutterErrorDetails(
        exception: error,
        stack: stackTrace,
        library: library,
        context: ErrorDescription(message)));

    return error as Exception;
  }
}

class TaskException implements Exception {
  TaskException({
    @required this.task,
    @required this.method,
    this.details,
    this.stackTrace,
  }) :  assert(
          task != null,
          'task cannot be null'),
        assert(
          method != null,
          'method cannot be null');

  /// An error on task.
  final String task;

  /// An error on method.
  final String method;

  /// Error details.
  final dynamic details;

  /// The stack trace info can be found within the try-catch block.
  final StackTrace stackTrace;

  @override
  String toString() =>
      "TaskException($method[$task]: $details)\n$stackTrace";
}

class OthersException implements Exception {
  OthersException({
    @required this.code,
    this.message,
    this.details,
    this.stackTrace,
  }) :  assert(
          code != null,
          'code cannot be null');

  /// An error code.
  final String code;

  /// A human-readable error message.
  final String message;

  /// Error details.
  final dynamic details;

  /// The stack trace info can be found within the try-catch block.
  final StackTrace stackTrace;

  @override
  String toString() =>
      "OthersException($code: $message)\n$details\n$stackTrace";
}