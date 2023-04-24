part of nfc_sic.utils;

/// Function build export data to string in each modes.
class _ReportFunc {
  _ReportFunc._();

  static final _setting = Manager.setting.get();

  static String get uid => hex.encode(
    Manager.characteristic.get().uid).toUpperCase();

  static String getReport({
    DateTime date,
    String version = "unknown",
    String note = "",
  }) {
    final _result = Manager.result.result;
    final _secondResult = Manager.result.secondResult;

    final _peak = Manager.result.toPeakReport();
    final _coef = Manager.characteristic.toReport();
    final _offset = Manager.characteristic.externalOffset;

    final _date = _getDate(date);
    final _time = _getTime(date);

    final _report = StringBuffer(
      "File : \t${_setting.fileName ?? ""}\n");

    if ( (note != null) && (note.isNotEmpty) ) {
      _report.write(
        "Note : \n$note\n\n");
    }

    _report.write(
      "UID : \t$uid\n"
      "Date : \t$_date\n"
      "Time : \t$_time\n"
      "Mode : \tDifferential Pulse Voltammetry\n"
      "App version : \t$version\n"
      "\nSetting\n"
      "Current range : \t${_setting.currentRange}\tuA\n"
      "E condition : \t${_setting.eCondition}\tV\n"
      "t condition : \t${_setting.tCondition}\ts\n"
      "E deposition : \t${_setting.eDeposition}\tV\n"
      "t deposition : \t${_setting.tDeposition}\ts\n"
      "t equilibration : \t${_setting.tEquilibration}\ts\n"
      "E Begin : \t${_setting.eBegin}\tV\n"
      "E Final : \t${_setting.eEnd}\tV\n"
      "E Amp : \t${_setting.ePulse}\tmV\n"
      "Pulse Duration : \t${_setting.tPulse}\tms\n"
      "E Step : \t${_setting.eStep}\tmV\n"
      "T Step : \t${_setting.tStep}\tms\n"
      "Scan Rate : \t${_setting.scanRate}\tV/s\n"
      "$_coef"
      "$_peak"
      "\nOffset Table\n"
      "Index \t Iwe(uA) \t ADCout\n");

    for ( var i = 0 ; i < _offset.length ; i++ ) {
      _report.write("$i\t"
        "${_offset.keys.elementAt(i)}\t"
        "${_offset.values.elementAt(i).toInt()}\n");
    }

    _report.write(
      "\nConversion\n"
      "Index \t Tsamp (ms) \t Vbias (mV) \t Iwe (uA) \t ADCout\n");

    for ( final _data in _secondResult ) {
      _report.write(
        "${_data.index}\t"
        "${_data.tSamp}\t"
        "${_data.voltage}\t"
        "${_data.current.toStringAsFixed(10)}\t"
        "${_data.adcOut}\n");
    }

    _report.write(
      "\nDifferential Current\n"
      "Index \t Tsamp (ms) \t Vbias (mV) \t Iwe (uA) \t ADCout\n");

    for ( final _data in _result ) {
      _report.write(
        "${_data.index}\t"
        "${_data.tSamp}\t"
        "${_data.voltage}\t"
        "${_data.current.toStringAsFixed(10)}\t"
        "${_data.adcOut}\n");
    }

    return _report.toString();
  }

  static String getDateTime(DateTime date) {
    assert(
      date != null,
      'date cannot be null');

    final y = _fourDigits(date.year);
    final m = _twoDigits(date.month);
    final d = _twoDigits(date.day);
    final h = _twoDigits(date.hour);
    final min = _twoDigits(date.minute);
    final sec = _twoDigits(date.second);

    return "$y-$m-${d}_$h-$min-$sec";
  }

  static String _getDate(DateTime date) {
    assert(
      date != null,
      'date cannot be null');

    final d = _twoDigits(date.day);
    final m = _twoDigits(date.month);
    final y = _fourDigits(date.year);

    return "$y/$m/$d";
  }

  static String _getTime(DateTime date) {
    assert(
      date != null,
      'date cannot be null');

    final hour = _twoDigits(date.hour);
    final min = _twoDigits(date.minute);
    final sec = _twoDigits(date.second);

    return "$hour:$min:$sec";
  }

  static String _fourDigits(int n) =>
      n.toString().padLeft(4, "0");

  static String _twoDigits(int n) =>
      n.toString().padLeft(2, "0");
}