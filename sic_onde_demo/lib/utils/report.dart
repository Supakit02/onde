part of utils;

class ReportFunc {
  static final _setting = Manager.setting.get();

  static String get uid =>
      hex.encode(Manager.characteristic.get().uid).toUpperCase();

  static String fileName({required Substance substance}) {
    final dateTime = getDateTime(DateTime.now());

    if (substance.isHeavyMetals) {
      return "${substance.shortText}_${dateTime.toString()}";
    } else {
      return "${substance.shortText}_${dateTime.toString()}";
    }
  }

  static String getReportHeavy({
    required DateTime date,
    String version = "1.0.7.DEV",
  }) {
    final _result = Manager.result.result;
    final _peak = Manager.result.toPeakReport();
    final _date = _getDate(date);
    final _time = _getTime(date);

    final _report = StringBuffer("UID : \t$uid\n"
        "Date : \t$_date\n"
        "Time : \t$_time\n"
        "Mode : \tDifferential Pulse Voltammetry\n"
        "App version : \t$version\n"
        "$_peak");

    _report.write("\nResult\n"
        "Index \t Tsamp (ms) \t Vbias (mV) \t Iwe (uA) \t ADCout\n");

    for (final _data in _result) {
      _report.write("${_data.index}\t"
          "${_data.tSamp}\t"
          "${_data.voltage}\t"
          "${_data.current.toStringAsFixed(10)}\t"
          "${_data.adcOut}\n");
    }

    return _report.toString();
  }

  static String getReportPesticide({
    required DateTime date,
    String version = "1.0.7.DEV",
  }) {
    final _result = Manager.result.result;
    final _peak = Manager.result.toPeakPesticideReport();
    final _date = _getDate(date);
    final _time = _getTime(date);
    final _vegetable = Get.find<APIController>().vegetable;

    final _report = StringBuffer("UID : \t$uid\n"
        "Date : \t$_date\n"
        "Time : \t$_time\n"
        "Mode : \tChronoamperometry\n"
        "App version : \t$version\n"
        "Vegetable : \t$_vegetable\n"
        "$_peak");

    _report.write("\nResult\n"
        "Index \t Tsamp (ms) \t Vbias (mV) \t Iwe (uA) \t ADCout\n");

    for (final _data in _result) {
      _report.write("${_data.index}\t"
          "${_data.tSamp}\t"
          "${_data.voltage}\t"
          "${_data.current.toStringAsFixed(10)}\t"
          "${_data.adcOut}\n");
    }

    return _report.toString();
  }

  static String getDateTime(DateTime date) {
    assert(date != null, 'date cannot be null');

    final y = _fourDigits(date.year);
    final m = _twoDigits(date.month);
    final d = _twoDigits(date.day);
    final h = _twoDigits(date.hour);
    final min = _twoDigits(date.minute);
    final sec = _twoDigits(date.second);

    return "$y-$m-${d}_$h-$min-$sec";
  }

  static String _getDate(DateTime date) {
    assert(date != null, 'date cannot be null');

    final d = _twoDigits(date.day);
    final m = _twoDigits(date.month);
    final y = _fourDigits(date.year);

    return "$y/$m/$d";
  }

  static String _getTime(DateTime date) {
    assert(date != null, 'date cannot be null');

    final hour = _twoDigits(date.hour);
    final min = _twoDigits(date.minute);
    final sec = _twoDigits(date.second);

    return "$hour:$min:$sec";
  }

  static String _fourDigits(int n) => n.toString().padLeft(4, "0");

  static String _twoDigits(int n) => n.toString().padLeft(2, "0");
}
