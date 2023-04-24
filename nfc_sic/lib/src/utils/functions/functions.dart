part of nfc_sic.utils;

extension SubstanceFunction on Substance {
  String getReport({
    DateTime date,
    String version = "unknown",
    String note = "",
  }) => _ReportFunc.getReport(
    date: date,
    version: version,
    note: note);
}