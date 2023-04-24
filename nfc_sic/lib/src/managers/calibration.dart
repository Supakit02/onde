part of nfc_sic.managers;

class CalibrationManager {
  CalibrationManager._()
    : _setting = Manager.setting,
      _characteristic = Manager.characteristic,
      _ioWePin = <int>[],
      _hasData = false,
      _hasFile = false;

  static const String UID_KEY = "uid";
  static const String TIMESTAMP_KEY = "timestamp";
  static const String MODE_KEY = "mode";

  static const String SETTINGS_KEY = "settings";
  static const String CURRENT_RANGE_KEY = "currentRange";
  static const String VOLT_START_KEY = "vStart";
  static const String VOLT_END_KEY = "vEnd";

  static const String OFFSETS_KEY = "offsets";
  static const String OFFSET_PIN0_KEY = "pin0";
  static const String OFFSET_PIN1_KEY = "pin1";
  static const String OFFSET_PIN2_KEY = "pin2";

  final SettingManager _setting;
  final CharacteristicManager _characteristic;

  Map<int, double> _offsetPin0;
  Map<int, double> _offsetPin1;
  Map<int, double> _offsetPin2;

  String _uid;
  DateTime _timestamp;

  List<int> _ioWePin;
  double _currentRange;
  int _vStart, _vEnd;

  File _offsetFile;
  bool _hasFile, _hasData;
  Map<String, dynamic> _rawJson;

  bool get hasData => _hasData;

  String get uid => _uid;
  DateTime get timestamp => _timestamp;

  double get currentRange => _currentRange;
  int get vStart => _vStart;
  int get vEnd => _vEnd;

  List<int> get ioWePin => _ioWePin;

  void setIoWePin(List<bool> value) {
    _ioWePin = <int>[];

    for ( var i = 0 ; i < 3 ; i++ ) {
      if ( value[i] ?? false ) {
        _ioWePin.add(i);
      }
    }
  }

  Map<int, double> get offsetPin0 => _offsetPin0;
  Map<int, double> get offsetPin1 => _offsetPin1;
  Map<int, double> get offsetPin2 => _offsetPin2;

  bool get hasOffsetPin0 =>
      (offsetPin0 != null) && (offsetPin0.isNotEmpty);
  bool get hasOffsetPin1 =>
      (offsetPin1 != null) && (offsetPin1.isNotEmpty);
  bool get hasOffsetPin2 =>
      (offsetPin2 != null) && (offsetPin2.isNotEmpty);

  void initOffset() {
    _offsetPin0?.clear();
    _offsetPin1?.clear();
    _offsetPin2?.clear();
  }

  Future<void> setOffsetPin(int pin, Map<int, double> value) async {
    assert(
      (pin != null) && (value != null),
      'pin and value cannot be null');
    // debugPrint("setOffsetPin(CalibrationsManager) pin: $pin, offset: $value");

    switch (pin) {
      case 0:
        _offsetPin0 = Map.from(value);
        break;

      case 1:
        _offsetPin1 = Map.from(value);
        break;

      case 2:
        _offsetPin2 = Map.from(value);
        break;

      default:
        throw NoCaseError(
          value: pin,
          type: runtimeType,
          method: "setOffsetPin",
          message: "Unexpected pin value");
    }
  }

  Future<bool> checkUid() async {
    try {
      final _uidChip = hex.encode(
        Sic4341.instance.uid.toList()) ?? "";

      if ( _uidChip.trim().toLowerCase().compareTo(
          uid.trim().toLowerCase()) == 0 ) {
        return true;
      }

      return false;
    } catch (error, stackTrace) {
      CaptureException.instance.exception(
        message: "Error on checkUid(CalibrationManager)",
        error: error,
        stackTrace: stackTrace ?? StackTrace.current);

      return false;
    }
  }

  Future<bool> validateOffset() async {
    try {
      final ioWe = _setting.get().wePin;

      switch (ioWe) {
        case 0:
          return hasOffsetPin0;

        case 1:
          return hasOffsetPin1;

        case 2:
          return hasOffsetPin2;

        default:
          throw NoCaseError(
            value: ioWe,
            type: runtimeType,
            method: "validateOffset",
            message: "Unexpected ioWe value");
      }
    } catch (error, stackTrace) {
      CaptureException.instance.exception(
        message: "Error on validateOffset(CalibrationManager)",
        error: error,
        stackTrace: stackTrace ?? StackTrace.current);

      return false;
    }
  }

  Future<bool> validateData() async {
    final setting = _setting.get();

    try {
      if ( setting.currentRange != currentRange ) {
        return false;
      }

      final _start = ReactFunc.toMilli(
        setting.eBegin);
      final _end = ReactFunc.toMilli(
        setting.eEnd);

      if ( vStart == _start ) {
        if ( vEnd == _end ) {
          return true;
        }
      }

      return false;
    } catch (error, stackTrace) {
      CaptureException.instance.exception(
        message: "Error on validateData(CalibrationManager)",
        error: error,
        stackTrace: stackTrace ?? StackTrace.current);

      return false;
    }
  }

  Future<void> setOffset(int ioWe) async {
    try {
      switch (ioWe) {
        case 0:
          if ( hasOffsetPin0 ) {
            await _characteristic.setOffset(
              offsetPin0);
          }
          break;

        case 1:
          if ( hasOffsetPin1 ) {
            await _characteristic.setOffset(
              offsetPin1);
          }
          break;

        case 2:
          if ( hasOffsetPin2 ) {
            await _characteristic.setOffset(
              offsetPin2);
          }
          break;

        default:
          throw NoCaseError(
            value: ioWe,
            type: runtimeType,
            method: "setOffset",
            message: "Unexpected ioWe value");
      }
    } catch (error, stackTrace) {
      CaptureException.instance.exception(
        message: "Error on setOffset(CalibrationManager)",
        error: error,
        stackTrace: stackTrace ?? StackTrace.current);
    }
  }

  Future<bool> loadOffsetData() async {
    try {
      if ( _hasData ) {
        return true;
      }

      if ( !_hasFile ) {
        _offsetFile ??= await _jsonFile;
        _hasFile = _offsetFile.existsSync();

        if ( !_hasFile ) {
          return false;
        }
      }

      final _data = await _offsetFile.readAsString();
      _rawJson = json.decode(_data) as Map<String, dynamic>;

      _uid = _rawJson[UID_KEY].toString();
      _timestamp = DateTime.tryParse(
        _rawJson[TIMESTAMP_KEY].toString());

      _currentRange = _rawJson[SETTINGS_KEY][CURRENT_RANGE_KEY] as double;
      _vStart = _rawJson[SETTINGS_KEY][VOLT_START_KEY] as int;

      if ( _rawJson[SETTINGS_KEY][VOLT_END_KEY] != null ) {
        _vEnd = _rawJson[SETTINGS_KEY][VOLT_END_KEY] as int;
      }

      if ( _rawJson[OFFSETS_KEY][OFFSET_PIN0_KEY] != null ) {
        _offsetPin0 = Map<String, double>.from(_rawJson[OFFSETS_KEY][OFFSET_PIN0_KEY] as Map)
            .map((key, value) => MapEntry(
              int.tryParse(key.toString()), value));
      }

      if ( _rawJson[OFFSETS_KEY][OFFSET_PIN1_KEY] != null ) {
        _offsetPin1 = Map<String, double>.from(_rawJson[OFFSETS_KEY][OFFSET_PIN1_KEY] as Map)
            .map((key, value) => MapEntry(
              int.tryParse(key.toString()), value));
      }

      if ( _rawJson[OFFSETS_KEY][OFFSET_PIN2_KEY] != null ) {
        _offsetPin2 = Map<String, double>.from(_rawJson[OFFSETS_KEY][OFFSET_PIN2_KEY] as Map)
            .map((key, value) => MapEntry(
              int.tryParse(key.toString()), value));
      }

      _hasData = true;

      return true;
    } catch (error, stackTrace) {
      CaptureException.instance.exception(
        message: "Error on loadOffsetData(CalibrationManager)",
        error: error,
        stackTrace: stackTrace ?? StackTrace.current);

      _hasData = false;

      return false;
    }
  }

  Future<void> storeOffsetData(Uint8List uidRaw, DateTime date) async {
    final setting = _setting.get();

    _uid = hex.encode(uidRaw);
    _timestamp = date;
    _currentRange = setting.currentRange;

    final _offset0 = offsetPin0?.map<String, double>(
      (key, value) => MapEntry(key.toString(), value));

    final _offset1 = offsetPin1?.map<String, double>(
      (key, value) => MapEntry(key.toString(), value));

    final _offset2 = offsetPin2?.map<String, double>(
      (key, value) => MapEntry(key.toString(), value));

    _vStart = ReactFunc.toMilli(
      setting.eBegin);
    _vEnd = ReactFunc.toMilli(
      setting.eEnd);

    final _dataRaw = <String, dynamic>{
      UID_KEY : uid,
      TIMESTAMP_KEY : date.toString(),
      SETTINGS_KEY : {
        CURRENT_RANGE_KEY : currentRange,
        VOLT_START_KEY : vStart,
        VOLT_END_KEY : vEnd,
      },
      OFFSETS_KEY : {
        OFFSET_PIN0_KEY : _offset0,
        OFFSET_PIN1_KEY : _offset1,
        OFFSET_PIN2_KEY : _offset2,
      },
    };

    _rawJson = _dataRaw;
    _hasData = true;

    try {
      final _data = json.encode(_dataRaw);
      // debugPrint("storeOffsetData(CalibrationsManager) data: $data");

      _offsetFile ??= await _jsonFile;
      _hasFile = _offsetFile.existsSync();

      if ( !_hasFile ) {
        _offsetFile = await _offsetFile.create();
        _offsetFile = await _offsetFile.writeAsString(_data);
        _hasFile = _offsetFile.existsSync();
      } else {
        _offsetFile = await _offsetFile.writeAsString(_data);
        _hasFile = true;
      }
    } catch (error, stackTrace) {
      _hasFile = false;

      throw OthersException(
        code: "storeOffsetData(CalibrationsManager)",
        message: "$error",
        stackTrace: stackTrace ?? StackTrace.current);
    }
  }

  Future<File> get _jsonFile async {
    final _directory = await getApplicationSupportDirectory();
    // final directory = await getExternalStorageDirectory();

    return File(
      "${_directory.path}/calibrate.json");
  }

  @override
  String toString() =>
      "[CalibrationManager] uid: $_uid, timestamp: ${_timestamp.toString()}, "
      "settings: { currentRange: $_currentRange, vStart: $_vStart, "
      "vEnd: $_vEnd }, offsets: { pin0: $_offsetPin0, "
      "pin1: $_offsetPin1, pin2: $_offsetPin2 }";
}