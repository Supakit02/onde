part of nfc_sic.utils;

/// Thrown by operations that have not been implemented yet.
///
/// This [Error] is thrown by unfinished code that hasn't yet
/// implemented all the features it needs.
///
/// If a class is not intending to implement the feature,
/// it should throw an [NoCaseError] instead. This error is
/// only intended for use during development.
///
class NoCaseError extends Error {
  /// This [Error] is thrown by operations
  /// that have not been case in switch-case.
  NoCaseError({
    @required this.value,
    this.type,
    this.method,
    this.message,
  });

  /// An error on type.
  final Type type;

  /// An error on method.
  final String method;

  /// The data value on case error.
  final dynamic value;

  /// The error message.
  final String message;

  @override
  String toString() =>
      "NoCaseError($method[$type] "
      "${message ?? "Unexpected value"}: $value)";
}

/// The class represents the error when the session is stopped.
/// (Currently iOS only)
///
///     [@param] type     the session error type.
///     [@param] message  the session error message.
///     [@param] details  the session error details information.
///
class SessionError extends Error {
  /// Constructs an instance with the given values for testing.
  ///
  /// The instances constructs by this way are not valid in
  /// the production environment.
  ///
  /// Only instances obtained from the onSessionError callback
  /// of `NfcSession#startSession` are valid.
  ///
  SessionError({
    this.type = SessionErrorType.unknown,
    this.message,
    this.details,
  });

  factory SessionError.fromMap(Map<String, dynamic> arg) => SessionError(
      type: SessionErrorType.values.firstWhere(
            (type) => type.value == arg['type'].toString(),
            orElse: () => null)
          ?? SessionErrorType.unknown,
      message: arg['message'].toString(),
      details: arg['details'],
    );

  /// The session error type.
  final SessionErrorType type;

  /// The session error message.
  final String message;

  /// The session error details information.
  final dynamic details;

  @override
  String toString() =>
      "SessionError(type: ${type.text}, "
      "message: $message, details: $details)";
}

/// Represents the type of error that occurs
/// when the session has stopped.
/// (Currently iOS only)
///  * user canceled
///  * session timeout
///  * session terminated unexpectedly
///  * system is busy
///  * first NDEF tag read
///  * unknown
///
enum SessionErrorType {
  /// The user canceled the session.
  userCanceled,

  /// The session timed out.
  sessionTimeout,

  /// The session terminated unexpectedly.
  sessionTerminatedUnexpectedly,

  /// The session failed because the system is busy.
  systemIsBusy,

  /// The session invalidation error first NDEF tag read.
  firstNDEFTagRead,

  /// The session failed because the unexpected error has occurred.
  unknown,
}

extension SessionErrorTypeValue on SessionErrorType {
  String get value {
    switch (this) {
      case SessionErrorType.userCanceled:
        return "userCanceled";

      case SessionErrorType.sessionTimeout:
        return "sessionTimeout";

      case SessionErrorType.sessionTerminatedUnexpectedly:
        return "sessionTerminatedUnexpectedly";

      case SessionErrorType.systemIsBusy:
        return "systemIsBusy";

      case SessionErrorType.firstNDEFTagRead:
        return "firstNDEFTagRead";

      case SessionErrorType.unknown:
        return "unknown";

      default:
        throw NoCaseError(
          value: this,
          type: runtimeType,
          method: "getValue",
          message: "Unexpected session error type value",
        );
    }
  }

  String get text {
    switch (this) {
      case SessionErrorType.userCanceled:
        return "user canceled";

      case SessionErrorType.sessionTimeout:
        return "session timeout";

      case SessionErrorType.sessionTerminatedUnexpectedly:
        return "session terminated unexpectedly";

      case SessionErrorType.systemIsBusy:
        return "system is busy";

      case SessionErrorType.firstNDEFTagRead:
        return "first NDEF tag read";

      case SessionErrorType.unknown:
        return "unknown";

      default:
        throw NoCaseError(
          value: this,
          type: runtimeType,
          method: "getDisplay",
          message: "Unexpected session error type value",
        );
    }
  }
}

extension SessionErrorTypeGetters on SessionErrorType {
  bool get isUserCanceled => this == SessionErrorType.userCanceled;
  bool get isSessionTimeout => this == SessionErrorType.sessionTimeout;
  bool get isSessionTerminatedUnexpectedly =>
      this == SessionErrorType.sessionTerminatedUnexpectedly;
  bool get isSystemIsBusy => this == SessionErrorType.systemIsBusy;
  bool get isFirstNDEFTagRead => this == SessionErrorType.firstNDEFTagRead;
  bool get isUnknown => this == SessionErrorType.unknown;

  bool get isNotUserCanceled => this != SessionErrorType.userCanceled;
  bool get isNotSessionTimeout => this != SessionErrorType.sessionTimeout;
  bool get isNotSessionTerminatedUnexpectedly =>
      this != SessionErrorType.sessionTerminatedUnexpectedly;
  bool get isNotSystemIsBusy => this != SessionErrorType.systemIsBusy;
  bool get isNotFirstNDEFTagRead => this != SessionErrorType.firstNDEFTagRead;
  bool get isNotUnknown => this != SessionErrorType.unknown;
}

enum ReaderErrorType {
  unsupportedFeature,

  securityViolation,

  invalidParameter,

  invalidParameterLength,

  parameterOutOfBound,

  radioDisabled,

  /// The unexpected error has occurred.
  unknown,
}

enum ReaderTransceiveErrorType {
  tagConnectionLost,

  retryExceeded,

  tagResponseError,

  sessionInvalidated,

  tagNotConnected,

  packetTooLong,

  /// The unexpected error has occurred.
  unknown,
}

enum NdefReaderSessionErrorType {
  tagNotWritable,

  tagUpdateFailure,

  tagSizeTooSmall,

  zeroLengthMessage,

  /// The unexpected error has occurred.
  unknown,
}