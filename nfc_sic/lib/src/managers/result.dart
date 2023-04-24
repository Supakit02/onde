part of nfc_sic.managers;

class ResultManager {
  ResultManager._()
      : _result = <Result>[],
        _secondResult = <Result>[],
        _peak = <HeavyMetalData>[];

  List<Result> _result;
  List<Result> _secondResult;

  List<HeavyMetalData> _peak;

  Uint8List _imageByte;

  /// Function `Getter` all list results in [ResultManager].
  List<Result> get result => _result;
  List<Result> get secondResult => _secondResult;

  /// Function `Clear` all list results in [ResultManager].
  ///
  /// clean all data result in results list.
  void clearResult() {
    _result.clear();
  }

  void clearSecondResult() {
    _secondResult.clear();
  }

  /// Function `Add` all list results in [ResultManager].
  ///
  /// add result model to results list.
  void addResult(Result result) {
    _result.add(result);
  }

  void addSecondResult(Result result) {
    _secondResult.add(result);
  }

  Uint8List get imageByte => _imageByte;

  Future<void> setImageByte(Uint8List value) async {
    _imageByte = value;
  }

  //! add Run filter

  Future<void> runFilter({
    FilterOption option,
  }) async {
    try {
      if (_result.isNotEmpty) {
        _result = await Filter.process(
          data: _result,
          option: option,
        );
      }

      // if ( _secondResult.isNotEmpty ) {
      //   _secondResult = await Filter.process(
      //     data: _secondResult,
      //     option: option,
      //   );
      // }
    } catch (error, stackTrace) {
      CaptureException.instance.exception(
          message: 'filter error',
          error: error,
          stackTrace: stackTrace ?? StackTrace.current);
    }
  }

  List<HeavyMetalData> get peak => _peak;

  void setPeak({
    Substance substance,
  }) {
    if (substance == null) {
      return;
    }

    _peak.clear();

    // print(substance.isHeavyMetals);
    // print(substance.isChromium);

    //! change Flow , add Substance
    if (substance.isHeavyMetals) {
      for (final _type in substance.heavyMetal) {
        _peak.add(HeavyMetalData(heavyMetal: _type, substance: substance));
      }
    } else {
      _peak.add(
          HeavyMetalData(substance: substance, pesticide: substance.pesticide));
    }
  }

  Future<void> findPeak() async {
    try {
      if (_result.isNotEmpty && _peak.isNotEmpty) {
        final _data = Peak(data: _result);

        for (final _p in _peak) {
          await _p.findPeak(data: _data, result: _result);
        }
      }
    } catch (error, stackTrace) {
      CaptureException.instance.exception(
          message: 'find peak error',
          error: error,
          stackTrace: stackTrace ?? StackTrace.current);
    }
  }

  String toPeakReport() {
    if (_peak.isNotEmpty) {
      final _report = StringBuffer("\nCalibration Curve\n");

      for (final _p in _peak) {
        _report.write(_p.toReport());
      }

      return _report.toString();
    }

    return '';
  }

  String toPeakPesticideReport() {
    if (_peak.isNotEmpty) {
      final _report = StringBuffer("\nCalibration Curve\n");

      for (final _p in _peak) {
        _report.write(_p.toReportPesticide());
      }

      return _report.toString();
    }

    return '';
  }
}
