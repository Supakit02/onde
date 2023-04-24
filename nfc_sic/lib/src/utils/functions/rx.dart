part of nfc_sic.utils;

/// Function checking error with NFC tag.
class RxFunc {
  RxFunc._();

  /// Checking NFC tag status send transceive.
  static Future<void> checkErrorNfcInvalid(Sic4341 nfc) async {
    if ( !nfc.isSendCompleted() ) {
      throw OthersException(
        code: "send incompleted",
        message: "ERROR! : checkErrorNfcInvalid",
        stackTrace: StackTrace.current);
    }
  }

  /// Checking length response receiver on NFC tag transceive.
  static Future<void> checkErrorMismatchSize(List<int> recv, int length) async {
    if ( (recv == null) || (recv.length < length) ) {
      throw OthersException(
        code: "mismatch size",
        message: "ERROR! : checkErrorMismatchSize",
        stackTrace: StackTrace.current);
    }
  }

  /// Checking flag response on NFC tag transceive.
  static Future<void> checkErrorLowPower(Sic4341 nfc) async {
    if ( nfc.isVddHError() || nfc.isVddLError() ) {
      throw OthersException(
        code: "low power",
        message: "ERROR! : checkErrorLowPower",
        stackTrace: StackTrace.current);
    }
  }

  /// Checking counter downto zero (`Timeout`) on NFC tag validate power task.
  static Future<void> checkErrorZeroCounter(int counter) async {
    if ( counter == 0 ) {
      throw OthersException(
        code: "zero counter",
        message: "ERROR! : Power is not enough",
        stackTrace: StackTrace.current);
    }
  }

  /// Checking NFC tag status send transceive.
  static Future<void> checkErrorSendComplete(Sic4341 nfc) async {
    if ( !nfc.isSendCompleted() ) {
      throw OthersException(
        code: "send incompleted",
        message: "ERROR! : checkErrorSendComplete",
        stackTrace: StackTrace.current);
    }
  }

  /// Checking length response receiver on NFC tag transceive.
  static Future<void> checkErrorLeastArray(List<int> recv, int length) async {
    if ( (recv == null) || (recv.length < length) ) {
      throw OthersException(
        code: "least array",
        message: "ERROR! : checkErrorLeastArray",
        stackTrace: StackTrace.current);
    }
  }

  /// Checking flag response on NFC tag transceive.
  static Future<void> checkErrorVdd(Sic4341 nfc) async {
    if ( nfc.isVddHError() || nfc.isVddLError() ) {
      throw OthersException(
        code: "low power",
        message: "ERROR! : checkErrorVdd",
        stackTrace: StackTrace.current);
    }
  }
}