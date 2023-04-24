part of nfc_sic.utils;

/// Status enumeration on communication NFC tag.
///  * Disappear `[DISAPPEAR]`
///  * Response Fail `[RESP_FAIL]`
///  * Exchange `[EXCHANGE]`
enum TagStatus {
  DISAPPEAR,
  RESP_FAIL,
  EXCHANGE,
}

extension TagStatusCompare on TagStatus {
  bool get isDisappear =>
      this == TagStatus.DISAPPEAR;
  bool get isRespFail =>
      this == TagStatus.RESP_FAIL;
  bool get isExchange =>
      this == TagStatus.EXCHANGE;

  bool get isNotDisappear =>
      this != TagStatus.DISAPPEAR;
  bool get isNotRespFail =>
      this != TagStatus.RESP_FAIL;
  bool get isNotExchange =>
      this != TagStatus.EXCHANGE;
}