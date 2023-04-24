
part of nfc_sic.models;

class Characteristic {
  Characteristic({
    Uint8List uid,
    int revision,
    int testSt,
    int fwSwVersion,
    int productSt,
    int tableVersion,
    double weOffset,
    double reOffset,
    double dac1ReBuffOffset,
    double dac2WeBuffOffset,
    double gain,
  }) :  _uid = uid,
        _revision = revision ?? 0,
        _testSt = testSt ?? 0,
        _fwSwVersion = fwSwVersion ?? 0,
        _productSt = productSt ?? 0,
        _tableVersion = tableVersion ?? 0,
        _weOffset = weOffset ?? 0.0,
        _reOffset = reOffset ?? 0.0,
        _dac1ReBuffOffset = dac1ReBuffOffset ?? 0.0,
        _dac2WeBuffOffset = dac2WeBuffOffset ?? 0.0,
        _gain = gain ?? 1.0,
        _adcGainErr = List<double>.generate(
          2,
          (i) => 0.0,
          growable: false),
        _adcOffErr = List<int>.generate(
          2,
          (i) => 0,
          growable: false),
        _adcResRng0 = List<int>.generate(
          5,
          (i) => 0,
          growable: false),
        _adcResRng1 = List<int>.generate(
          5,
          (i) => 0,
          growable: false);

  final List<double> _adcGainErr;
  final List<int> _adcOffErr;
  final List<int> _adcResRng0;
  final List<int> _adcResRng1;

  Uint8List _uid;
  int _revision;

  int _testSt;
  int _fwSwVersion;
  int _productSt;
  int _tableVersion;

  double _weOffset;
  double _reOffset;
  double _dac1ReBuffOffset;
  double _dac2WeBuffOffset;

  double _gain;

  // Function getter all variables in model.
  Uint8List get uid => _uid;
  int get revision => _revision;

  int get testSt => _testSt;
  int get fwSwVersion => _fwSwVersion;
  int get productSt => _productSt;
  int get tableVersion => _tableVersion;

  double get dac1ReBuffOffset => _dac1ReBuffOffset;
  double get dac2WeBuffOffset => _dac2WeBuffOffset;
  double get reOffset => _reOffset;
  double get weOffset => _weOffset;

  double get gain => _gain;

  List<double> get adcGainErr => _adcGainErr;
  List<int> get adcOffErr => _adcOffErr;
  List<int> get adcResRng0 => _adcResRng0;
  List<int> get adcResRng1 => _adcResRng1;

  /// Function setter all variables in model.
  set uid(Uint8List value) {
    _uid = value ?? Uint8List.fromList(<int>[]);
  }

  set revision(int value) {
    _revision = value ?? 0;
  }

  set testSt(int value) {
    _testSt = value ?? 0;
  }

  set fwSwVersion(int value) {
    _fwSwVersion = value ?? 0;
  }

  set productSt(int value) {
    _productSt = value ?? 0;
  }

  set tableVersion(int value) {
    _tableVersion = value ?? 0;
  }

  set dac1ReBuffOffset(double value) {
    _dac1ReBuffOffset = value ?? 0.0;
    _reOffset = _dac1ReBuffOffset * 1000.0;
  }

  set dac2WeBuffOffset(double value) {
    _dac2WeBuffOffset = value ?? 0.0;
    _weOffset = _dac2WeBuffOffset * 1000.0;
  }

  set gain(double value) {
    _gain = value ?? 1.0;
  }

  Future<void> setAdcGainErr(int index, double value) async {
    assert(
      (index != null) && (value != null),
      'index and value cannot be null');

    // debugPrint("[setAdcGainErr] index: $index, value: $value");
    _adcGainErr[index] = value;
  }

  Future<void> setAdcOffErr(int index, int value) async {
    assert(
      (index != null) && (value != null),
      'index and value cannot be null');

    // debugPrint("[setAdcOffErr] index: $index, value: $value");
    _adcOffErr[index] = value;
  }

  Future<void> setAdcResRng0(int index, int value) async {
    assert(
      (index != null) && (value != null),
      'index and value cannot be null');

    // debugPrint("[setAdcResRng0] index: $index, value: $value");
    _adcResRng0[index] = value;
  }

  Future<void> setAdcResRng1(int index, int value) async {
    assert(
      (index != null) && (value != null),
      'index and value cannot be null');

    // debugPrint("[setAdcResRng1] index: $index, value: $value");
    _adcResRng1[index] = value;
  }

  @override
  String toString() =>
      "[Characteristic] uid: ${uid.toHexString()}, "
      "revision: $revision, testSt: $testSt, "
      "fwSwVersion: $fwSwVersion, productSt: $productSt, "
      "tableVersion: $tableVersion, weOffset: $weOffset, "
      "reOffset: $reOffset, dac1ReBuffOffset: $dac1ReBuffOffset, "
      "dac2WeBuffOffset: $dac2WeBuffOffset, gain: $gain, "
      "adcGainErr: $adcGainErr, adcOffErr: $adcOffErr, "
      "adcResRng0: $adcResRng0, adcResRng1: $adcResRng1";
}