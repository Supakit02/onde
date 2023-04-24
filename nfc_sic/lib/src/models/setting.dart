part of nfc_sic.models;

class Setting {
  /// [Setting] set initial value in model
  /// when create new class.
  Setting({
    //! add enum Mode [MODE] , add FilterOption
    Mode mode,
    FilterOption filterOption,
    Substance substance,
    String fileName,
    // bool isNoTick,
    bool usePrevOffset,
    double currentRange,
    bool isUse3Pin,
    int rePin,
    int wePin,
    int cePin,
    double eCondition,
    int tCondition,
    double eDeposition,
    int tDeposition,
    bool useShortDepos,
    int tEquilibration,

    // ! add on Setting CA [E dc and T Run]
    double eDc1,
    int tRun1,
    double eBegin,
    double eEnd,
    int ePulse,
    int tPulse,
    int eStep,
    int tStep,
    double scanRate,
  })  : _mode = mode,
        _filterOption = filterOption,
        _substance = substance,
        _fileName = fileName ?? _SettingValue.fileName,
        // _isNoTick = isNoTick ?? _SettingValue.isNoTick,
        _usePrevOffset = usePrevOffset ?? _SettingValue.usePrevOffset,
        _currentRange = currentRange ?? _SettingValue.currentRange,
        _isUse3Pin = isUse3Pin ?? _SettingValue.isUse3Pin,
        _rePin = rePin ?? _SettingValue.rePin,
        _wePin = wePin ?? _SettingValue.wePin,
        _cePin = cePin ?? _SettingValue.cePin,
        _eCondition = eCondition ?? _SettingValue.eCondition,
        _tCondition = tCondition ?? _SettingValue.tCondition,
        _eDeposition = eDeposition ?? _SettingValue.eDeposition,
        _tDeposition = tDeposition ?? _SettingValue.tDeposition,
        _useShortDepos = useShortDepos ?? _SettingValue.useShortDepos,
        _tEquilibration = tEquilibration ?? _SettingValue.tEquilibration,
        _eDc1 = eDc1 ?? _SettingValue.eDc1,
        _tRun1 = tRun1 ?? _SettingValue.tRun1,
        _eBegin = eBegin ?? _SettingValue.eBegin,
        _eEnd = eEnd ?? _SettingValue.eEnd,
        _ePulse = ePulse ?? _SettingValue.ePulse,
        _tPulse = tPulse ?? _SettingValue.tPulse,
        _eStep = eStep ?? _SettingValue.eStep,
        _tStep = tStep ?? _SettingValue.tStep,
        _scanRate = scanRate ?? _SettingValue.scanRate;

  //! add enum Mode [MODE] , add FilterOption
  Mode _mode;
  FilterOption _filterOption;

  String _fileName;

  // Substance
  Substance _substance;

  // Configuration
  // bool _isNoTick;
  bool _usePrevOffset;
  double _currentRange;

  // Custom I/O
  bool _isUse3Pin;
  int _rePin;
  int _wePin;
  int _cePin;

  // Pretreatment
  double _eCondition;
  int _tCondition;
  double _eDeposition;
  int _tDeposition;
  bool _useShortDepos;

  // Reaction
  int _tEquilibration;

  // ! add CA [E dc , T Run]
  double _eDc1;
  int _tRun1;
  // Voltam
  double _eBegin;
  double _eEnd;

  // DPV / SWV
  int _ePulse;
  int _tPulse;

  // Scan Rate
  int _eStep;
  int _tStep;
  double _scanRate;

  //! Add Mode , add FilterOption
  Mode get mode => _mode;
  FilterOption get filterOption => _filterOption;

  /// Function setter all variables in model.
  String get fileName => _fileName;

  // Substance
  Substance get substance => _substance;

  // Configuration
  // bool get isNoTick => _isNoTick;
  bool get usePrevOffset => _usePrevOffset;
  double get currentRange => _currentRange;

  // Custom I/O
  bool get isUse3Pin => _isUse3Pin;
  int get rePin => _rePin;
  int get wePin => _wePin;
  int get cePin => _cePin;

  // Pretreatment
  double get eCondition => _eCondition;
  int get tCondition => _tCondition;
  double get eDeposition => _eDeposition;
  int get tDeposition => _tDeposition;
  bool get useShortDepos => _useShortDepos;

  // Reaction
  int get tEquilibration => _tEquilibration;

  //! CA
  double get eDc1 => _eDc1;
  int get tRun1 => _tRun1;

  // Voltam
  double get eBegin => _eBegin;
  double get eEnd => _eEnd;

  // DPV / SWV
  int get ePulse => _ePulse;
  int get tPulse => _tPulse;

  // Scan Rate
  int get eStep => _eStep;
  int get tStep => _tStep;
  double get scanRate => _scanRate;

  //! set mode
  set mode(Mode value) {
    _mode = value;
  }

  set filterOption(FilterOption value) {
    _filterOption = value;
  }

  /// Function setter all variables in model.
  set fileName(String value) {
    _fileName = value ?? _SettingValue.fileName;
  }

  // Substance
  set substance(Substance value) {
    _substance = value ?? _SettingValue.substance;
  }

  // Configuration
  // set isNoTick(bool value) {
  //   _isNoTick = value ?? _SettingValue.isNoTick;
  // }
  set usePrevOffset(bool value) {
    _usePrevOffset = value ?? _SettingValue.usePrevOffset;
  }

  set currentRange(double value) {
    _currentRange = value ?? _SettingValue.currentRange;
  }

  // Custom I/O
  set isUse3Pin(bool value) {
    _isUse3Pin = value ?? _SettingValue.isUse3Pin;
  }

  set rePin(int value) {
    _rePin = value ?? _SettingValue.rePin;
  }

  set wePin(int value) {
    _wePin = value ?? _SettingValue.wePin;
  }

  set cePin(int value) {
    _cePin = value ?? _SettingValue.cePin;
  }

  // Pretreatment
  set eCondition(double value) {
    _eCondition = value ?? _SettingValue.eCondition;
  }

  set tCondition(int value) {
    _tCondition = value ?? _SettingValue.tCondition;
  }

  set eDeposition(double value) {
    _eDeposition = value ?? _SettingValue.eDeposition;
  }

  set tDeposition(int value) {
    _tDeposition = value ?? _SettingValue.tDeposition;
  }

  set useShortDepos(bool value) {
    _useShortDepos = value ?? _SettingValue.useShortDepos;
  }

  // Reaction
  set tEquilibration(int value) {
    _tEquilibration = value ?? _SettingValue.tEquilibration;
  }

  //! CA
  set eDc1(double value) {
    _eDc1 = value ?? _SettingValue.eDc1;
  }

  set tRun1(int value) {
    _tRun1 = value ?? _SettingValue.tRun1;
  }

  // Voltam
  set eBegin(double value) {
    _eBegin = value ?? _SettingValue.eBegin;
  }

  set eEnd(double value) {
    _eEnd = value ?? _SettingValue.eEnd;
  }

  // DPV / SWV
  set ePulse(int value) {
    _ePulse = value ?? _SettingValue.ePulse;
  }

  set tPulse(int value) {
    _tPulse = value ?? _SettingValue.tPulse;
  }

  // Scan Rate
  set eStep(int value) {
    _eStep = value ?? _SettingValue.eStep;
  }

  set tStep(int value) {
    _tStep = value ?? _SettingValue.tStep;
  }

  set scanRate(double value) {
    _scanRate = value ?? _SettingValue.scanRate;
  }

  @override
  String toString() => "[Setting] fileName: $fileName, "
      // "isNoTick: $isNoTick, "
      "usePrevOffset: $usePrevOffset, "
      "currentRange: $currentRange, isUse3Pin: $isUse3Pin, "
      "rePin: $rePin, wePin: $wePin, cePin: $cePin, "
      "eCondition: $eCondition, tCondition: $tCondition, "
      "eDeposition: $eDeposition, tDeposition: $tDeposition, "
      // "useShortDepos: $useShortDepos, "
      "tEquilibration: $tEquilibration, "
      "eBegin: $eBegin, eEnd: $eEnd, "
      "ePulse: $ePulse, tPulse: $tPulse, "
      "eStep: $eStep, tStep: $tStep, "
      "scanRate: $scanRate, "
      "ADD ON Edc : $eDc1 , T Run : $tRun1";
}

class _SettingValue {
  static const String fileName = "";

  static const Substance substance = Substance.GENERIC;

  // static const bool isNoTick = false;
  static const bool usePrevOffset = false;

  static const int tEquilibration = 0;
  static const double currentRange = 20;

  static const bool isUse3Pin = true;
  static const int rePin = 0;
  static const int wePin = 1;
  static const int cePin = 2;

  static const double eCondition = 0;
  static const int tCondition = 0;
  static const double eDeposition = 0;
  static const int tDeposition = 0;
  static const bool useShortDepos = false;

  //! Settinh Constant CA [E dc , T Run]
  static const double eDc1 = -0.8;
  static const int tRun1 = 5;

  static const double eBegin = 0;
  static const double eEnd = 0;

  static const int ePulse = 50;
  static const int tPulse = 100;

  static const int eStep = 10;
  static const int tStep = 200;
  static const double scanRate = 0.05;
}
