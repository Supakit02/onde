part of nfc_sic.managers;

class CharacteristicManager {
  CharacteristicManager._()
    : _characteristic = Characteristic(),
      _offset = <int, double>{},
      _externalOffset = <int, double>{},
      _coefficient = <double>[],
      _min = 0,
      _max = 0,
      _size = 0,
      _divide = 0;

  static const int OFFSET_SIZE = 32;

  static const int CHARACTERISTICS_VERSION__1 = 0x10;
  static const int CHARACTERISTICS_VERSION__2 = 0x20;
  static const int CHARACTERISTICS_VERSION__3 = 0x30;

  static const int RECEIVER_ADC_OFFSET = 0;
  static const int RECEIVER_ADC_ERROR = 4;
  static const int RECEIVER_CHIP_INFO = 12;

  final Characteristic _characteristic;

  final Map<int, double> _offset;
  final Map<int, double> _externalOffset;

  List<double> _coefficient;

  int _min;
  int _max;
  int _size;
  int _divide;

  Characteristic get() => _characteristic;

  Uint8List get uid => _characteristic.uid;
  int get tableVersion => _characteristic.tableVersion;

  set uid(Uint8List uid) {
    _characteristic.uid = uid;
  }

  void setRevision(int rev) {
    _characteristic.revision = rev ?? 0;
  }

  // Map<int, double> get offset => _offset;
  Map<int, double> get externalOffset => _externalOffset;

  void initOffset() {
    _offset?.clear();
    _externalOffset?.clear();
  }

  Future<void> setOffset(Map<int, double> value) async {
    if ( value == null ) {
      return;
    }

    final _tableVersion = tableVersion;

    for ( final _key in value.keys ) {
      var _adc = value[_key] ?? 0.0;

      _externalOffset?.update(
        _key,
        (value) => _adc,
        ifAbsent: () => _adc,
      );

      if ( _tableVersion == CHARACTERISTICS_VERSION__3 ) {
        _adc = await _getOffsetFit(_adc);

        _offset?.update(
          _key,
          (value) => _adc,
          ifAbsent: () => _adc,
        );
      }
    }

    await setOffsetVariable();
  }

  Future<void> addOffset(int volt, double offset) async {
    assert(
      (volt != null) && (offset != null),
      'volt and offset cannot be null');

    _externalOffset?.update(
      volt,
      (value) => offset,
      ifAbsent: () => offset,
    );

    if ( tableVersion == CHARACTERISTICS_VERSION__3 ) {
      final _offsetFit = await _getOffsetFit(offset);

      _offset?.update(
        volt,
        (value) => _offsetFit,
        ifAbsent: () => _offsetFit,
      );
    }
  }

  Future<void> setOffsetVariable({
    int min,
    int max,
    int size,
    int divide,
  }) async {
    switch (tableVersion) {
      case CHARACTERISTICS_VERSION__1:
      case CHARACTERISTICS_VERSION__2:
        if ( _externalOffset.isNotEmpty ) {
          _min = min ?? _externalOffset.keys.first;
          _max = max ?? _externalOffset.keys.last;
          _size = size ?? _externalOffset.length - 1;
          _divide = divide ?? (_max - _min);
        }
        break;

      case CHARACTERISTICS_VERSION__3:
        if ( _offset.isNotEmpty ) {
          _min = min ?? _offset.keys.first;
          _max = max ?? _offset.keys.last;
          _size = size ?? _offset.length - 1;
          _divide = divide ?? (_max - _min);
        }
        break;
    }

    _min ??= 0;
    _max ??= 0;
    _size ??= 0;
    _divide ??= 0;
  }

  Future<void> setChipInfoFromPage28(List<int> recv) async {
    assert(
      (recv != null) && (recv.isNotEmpty),
      'recv cannot be null and empty');
    // debugPrint("Page28: ${recv.join(", ")}");

    switch (tableVersion) {
      case CHARACTERISTICS_VERSION__1:
      case CHARACTERISTICS_VERSION__2:
        break;

      case CHARACTERISTICS_VERSION__3:
        await setAdcRange1(recv);
        break;
    }
  }

  Future<void> setChipInfoFromPage2C(List<int> recv) async {
    assert(
      (recv != null) && (recv.isNotEmpty),
      'recv cannot be null and empty');
    // debugPrint("Page2C: ${recv.join(", ")}");

    await setInternalInfo(
      recv, RECEIVER_CHIP_INFO);

    switch (tableVersion) {
      case CHARACTERISTICS_VERSION__1:
      case CHARACTERISTICS_VERSION__2:
        await setAdcOffset(
          recv, RECEIVER_ADC_OFFSET);
        await setAdcError(
          recv, RECEIVER_ADC_ERROR);
        break;

      case CHARACTERISTICS_VERSION__3:
        await setAdcRange2(recv);
        await setAdcError(
          recv, RECEIVER_ADC_ERROR);
        break;
    }

    final _currentRange = Manager.setting.get().currentRange;
    final _index = ReactFunc.getIndexCurrentRange(_currentRange);

    _characteristic.gain = 1.0 + (_characteristic.adcGainErr[_index] ?? 0.0);
  }

  Future<void> setChipInfoFromPage30(List<int> recv) async {
    assert(
      (recv != null) && (recv.isNotEmpty),
      'recv cannot be null and empty');
    // debugPrint("Page30: ${recv.join(", ")}");

    switch (tableVersion) {
      case CHARACTERISTICS_VERSION__1:
      case CHARACTERISTICS_VERSION__2:
        await setAdcRange(recv);
        break;

      case CHARACTERISTICS_VERSION__3:
        await setAdcOffset(
          recv, RECEIVER_ADC_OFFSET);

        final _currentRange = Manager.setting.get().currentRange;

        _coefficient = _getPolynomialFit(
          _currentRange == SettingArray.CURRENT_RANGE[0]);
        break;
    }
  }

  Future<void> setInternalInfo(List<int> recv, int index) async {
    assert(
      (recv != null) && (recv.isNotEmpty) && (index != null),
      'index cannot be null and recv cannot be null and empty');

    _characteristic
      ..testSt = recv[index] & 0xFF
      ..fwSwVersion = recv[index + 1] & 0xFF
      ..productSt = recv[index + 2] & 0xFF
      ..tableVersion = recv[index + 3] & 0xFF;
  }

  Future<void> setAdcError(List<int> recv, int index) async {
    assert(
      (recv != null) && (recv.isNotEmpty) && (index != null),
      'index cannot be null and recv cannot be null and empty');

    await _characteristic.setAdcGainErr(
      0,
      ((recv[index + 4] << 8) |
      (recv[index + 5] & 0xFF)) /
      100000.0);

    await _characteristic.setAdcOffErr(
      0,
      (recv[index + 6] << 8) |
      (recv[index + 7] & 0xFF));

    await _characteristic.setAdcGainErr(
      1,
      ((recv[index] << 8) |
      (recv[index + 1] & 0xFF)) /
      100000.0);

    await _characteristic.setAdcOffErr(
      1,
      (recv[index + 2] << 8) |
      (recv[index + 3] & 0xFF));
  }

  Future<void> setAdcOffset(List<int> recv, int index) async {
    assert(
      (recv != null) && (recv.isNotEmpty) && (index != null),
      'index cannot be null and recv cannot be null and empty');

    _characteristic
      ..dac1ReBuffOffset = ((recv[index] << 8) | (recv[index + 1] & 0xFF)) / 100000.0
      ..dac2WeBuffOffset = ((recv[index + 2] << 8) | (recv[index + 3] & 0xFF)) / 100000.0;
  }

  Future<void> setAdcRange(List<int> recv) async {
    assert(
      (recv != null) && (recv.isNotEmpty),
      'recv cannot be null and empty');

    for ( var i = 0 ; i < 4 ; i++ ) {
      final _index1 = i << 1;
      final _index0 = (i + 4) << 1;

      await _characteristic.setAdcResRng1(
        i,
        (recv[_index1] << 8) |
        (recv[_index1 + 1] & 0xFF));

      await _characteristic.setAdcResRng0(
        i,
        (recv[_index0] << 8) |
        (recv[_index0 + 1] & 0xFF));
    }
  }

  Future<void> setAdcRange1(List<int> recv) async {
    assert(
      (recv != null) && (recv.isNotEmpty),
      'recv cannot be null and empty');

    for ( var i = 0 ; i < 5 ; i++ ) {
      final _index1 = i << 1;
      final _index0 = (i + 5) << 1;

      await _characteristic.setAdcResRng1(
        i,
        (recv[_index1] << 8) |
        (recv[_index1 + 1] & 0xFF));

      if ( _index0 <= 14 ) {
        await _characteristic.setAdcResRng0(
          i,
          (recv[_index0] << 8) |
          (recv[_index0 + 1] & 0xFF));
      }
    }
  }

  Future<void> setAdcRange2(List<int> recv) async {
    assert(
      (recv != null) && (recv.isNotEmpty),
      'recv cannot be null and empty');

    for ( var i = 3 ; i < 5 ; i++ ) {
      final _index0 = (i - 3) << 1;

      await _characteristic.setAdcResRng0(
        i,
        (recv[_index0] << 8) |
        (recv[_index0 + 1] & 0xFF));
    }
  }

  Future<double> getCurrent(int raw, int bias) async {
    // debugPrint("getCurrent(ReactionRxTask) raw: $raw, bias: $bias");
    final _settings = Manager.setting.get();

    try {
      final _offset = await _getOffset(bias);

      switch (tableVersion) {
        case CHARACTERISTICS_VERSION__1:
        case CHARACTERISTICS_VERSION__2:
          final _adc = raw - _offset;

          final _currentRange = _settings.currentRange;
          final _gain = _characteristic.gain;

          final _current = (_adc * _currentRange) * _gain / 16384.0;

          return -_current;

        case CHARACTERISTICS_VERSION__3:
          final _y = await _getOffsetFit(raw.toDouble());

          final _current = _y - _offset;
          // debugPrint("[getCurrent] y: $_y, offset: $_offset, adc: $raw, current: $_current");

          return _current;

        default:
          throw NoCaseError(
            value: tableVersion,
            type: runtimeType,
            method: "getCurrent",
            message: "Unexpected tableVersion value");
      }
    } catch (error, stackTrace) {
      throw TaskException(
        task: "CharacteristicManager",
        method: "getCurrent",
        details: error,
        stackTrace: stackTrace ?? StackTrace.current);
    }
  }

  Future<double> _getOffset(int bias) async {
    // debugPrint("[getOffset] bias: $bias");
    var _index = (bias - _min) * _size / _divide;
    // debugPrint("[getOffset] min: $min, size: $size, divide: $divide, index: $index");

    if ( _index.isNaN ) {
      _index = 0.0;
    }

    switch (tableVersion) {
      case CHARACTERISTICS_VERSION__1:
      case CHARACTERISTICS_VERSION__2:
        if ( _index < 0 ) {
          return _externalOffset[_min] ?? 0.0;
        }

        if ( _index > _size ) {
          return _externalOffset[_max] ?? 0.0;
        }

        final _top = _externalOffset.keys.elementAt(_index.ceil());
        final _bottom = _externalOffset.keys.elementAt(_index.floor());
        // debugPrint("[getOffset] top: $top, bottom: $bottom");

        if ( _top == _bottom ) {
          return _externalOffset[_bottom];
        }

        try {
          return (((_externalOffset[_top] - _externalOffset[_bottom]) *
              ((bias - _bottom) / (_top - _bottom))) +
              _externalOffset[_bottom]).roundToDouble();
        } catch (error, stackTrace) {
          CaptureException.instance.exception(
            message: "getOffset Table version 1/2",
            error: error,
            stackTrace: stackTrace ?? StackTrace.current);

          return _externalOffset[bias] ?? 0.0;
        }
        break;

      case CHARACTERISTICS_VERSION__3:
        if ( _index < 0 ) {
          return _offset[_min] ?? 0.0;
        }

        if ( _index > _size ) {
          return _offset[_max] ?? 0.0;
        }

        final _top = _offset.keys.elementAt(_index.ceil());
        final _bottom = _offset.keys.elementAt(_index.floor());
        // debugPrint("[getOffset] top: $top, bottom: $bottom");

        if ( _top == _bottom ) {
          return _offset[_bottom];
        }

        try {
          return ((_offset[_top] - _offset[_bottom]) *
              ((bias - _bottom) / (_top - _bottom))) +
              _offset[_bottom];
        } catch (error, stackTrace) {
          CaptureException.instance.exception(
            message: "getOffset Table version 3",
            error: error,
            stackTrace: stackTrace ?? StackTrace.current);

          return _offset[bias] ?? 0.0;
        }
        break;
    }

    return 0;
  }

  Future<double> _getOffsetFit(double offset) async {
    // debugPrint("offset: $offset");
    var _y = 0.0;

    for ( var i = 0 ; i < _coefficient.length ; i++ ) {
      _y += _coefficient[i] * math.pow(offset, i);
    }
    // debugPrint("y: $_y");

    return _y;
  }

  List<double> _getPolynomialFit(bool is2_5uA) {
    var _gauss = _Matrix.empty();

    if ( is2_5uA ) {
      final _adcResRng = _characteristic.adcResRng0.map(
        (val) => val.toDouble()).toList();
      // debugPrint("2.5uA: ${_characteristic.adcResRng0}");

      _gauss = _Matrix.xy({
        _adcResRng[0]: -2,
        _adcResRng[1]: -1,
        _adcResRng[2]: 0,
        _adcResRng[3]: 1,
        _adcResRng[4]: 2,
      });
      // debugPrint("[gaussian] ${_gauss.toString()}");
    } else {
      final _adcResRng = _characteristic.adcResRng1.map(
        (val) => val.toDouble()).toList();
      // debugPrint("20.0uA: ${_characteristic.adcResRng1}");

      _gauss = _Matrix.xy({
        _adcResRng[0]: -16,
        _adcResRng[1]: -8,
        _adcResRng[2]: 0,
        _adcResRng[3]: 8,
        _adcResRng[4]: 16,
      });
      // debugPrint("[gaussian] ${_gauss.toString()}");
    }

    final _coef = _gauss.getPolynomialFit();
    // debugPrint("coefficient:\n\t${_coef.map((val) => val.toStringAsExponential(10)).join(", ")}\n");

    return List<double>.from(_coef);
  }

  String toReport() {
    if ( tableVersion == CHARACTERISTICS_VERSION__3 ) {
      final _report = StringBuffer(
        "\nCoefficient\n");

      for ( var i = 0 ; i < _coefficient.length ; i++ ) {
        _report.write(
          "a$i : \t"
          "${_coefficient[i].toStringAsExponential(10)}\n");
      }

      return _report.toString();
    }

    return "";
  }
}