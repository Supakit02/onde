part of nfc_sic.utils;

/// Used with `NfcSession#startTagSession`.
///
/// This wraps `NFCTagReaderSession.PollingOption` on iOS,
/// `NfcAdapter.FLAG_READER_*` on Android.
///  * iso14443
///  * iso15693
///  * iso18092
enum TagPollingOption {
  /// Represents `iso14443` on iOS,
  /// and `FLAG_READER_A` and `FLAG_READER_B` on Android.
  iso14443,

  /// Represents `iso15693` on iOS,
  /// and `FLAG_READER_V` on Android.
  iso15693,

  /// Represents `iso18092` on iOS,
  /// and `FLAG_READER_F` on Android.
  iso18092,
}

extension TagPollingOptionValue on TagPollingOption {
  String get value {
    switch (this) {
      case TagPollingOption.iso14443:
        return "iso14443";

      case TagPollingOption.iso15693:
        return "iso15693";

      case TagPollingOption.iso18092:
        return "iso18092";

      default:
        throw NoCaseError(
          value: this,
          type: runtimeType,
          method: "getValue",
          message: "Unexpected tag polling option value");
    }
  }
}

extension TagPollingOptionCompare on TagPollingOption {
  bool get isISO14443 =>
      this == TagPollingOption.iso14443;
  bool get isISO15693 =>
      this == TagPollingOption.iso15693;
  bool get isISO18092 =>
      this == TagPollingOption.iso18092;

  bool get isNotISO14443 =>
      this != TagPollingOption.iso14443;
  bool get isNotISO15693 =>
      this != TagPollingOption.iso15693;
  bool get isNotISO18092 =>
      this != TagPollingOption.iso18092;
}