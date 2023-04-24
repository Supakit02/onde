part of nfc_sic.managers;

class IoData {
  IoData()
    : _setting = Manager.setting,
      _characteristic = Manager.characteristic,
      _calibration = Manager.calibration,
      _result = Manager.result;

  /// data manager input
  final SettingManager _setting;
  final CharacteristicManager _characteristic;

  /// calibration offsets WE pin manager
  final CalibrationManager _calibration;

  /// data manager output
  final ResultManager _result;

  // ignore: avoid_returning_this
  IoData start() => this;

  SettingManager get setting => _setting;
  CharacteristicManager get characteristic => _characteristic;
  CalibrationManager get calibration => _calibration;
  ResultManager get result => _result;

  Future<void> initOffset() async {
    _calibration.initOffset();
    _characteristic.initOffset();
  }

  Future<void> initResult() async {
    _result
      ..clearResult()
      ..clearSecondResult();
  }

  int collectResult({ int bias, double current, int adc, int time }) {
    try {
      final _index = _result.result.length;
      // debugPrint("collect result(IoData) record $_index -> bias: $bias, current: $current, adc: $adc");
      
      _result.addResult(
        Result(
          index: _index,
          tSamp: _index * time,
          voltage: bias * 2,
          current: current,
          adcOut: adc));
      // debugPrint("[addResult] result: ${_result.result.last}");

      return _index;
    } catch (error, stackTrace) {
      throw OthersException(
        code: "collectResult(IoData)",
        details: error,
        stackTrace: stackTrace ?? StackTrace.current);
    }
  }

  int collectSecondResult({ int bias, double current, int adc, int time }) {
    try {
      final _index = _result.secondResult.length;
      final _tSamp = _result.secondResult.isEmpty
          ? 0
          : (_result.secondResult.last.tSamp + time);
      // debugPrint("collect second result(IoData) record $_index -> bias: $bias, current: $current, adc: $adc");

      _result.addSecondResult(
        Result(
          index: _index,
          tSamp: _tSamp,
          voltage: bias * 2,
          current: current,
          adcOut: adc));
      // debugPrint("[addSecondResult] result: ${_result.secondResult.last}");

      return _index;
    } catch (error, stackTrace) {
      throw OthersException(
        code: "collectSecondResult(IoData)",
        details: error,
        stackTrace: stackTrace ?? StackTrace.current);
    }
  }
}