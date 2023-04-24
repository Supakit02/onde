part of service.provider;

class SettingProvider extends GetxController {
  Setting _setting = Setting();
  int _operationDuration = 0;
  bool _isCadmium = false;

  bool get isCadmium => _isCadmium;

  void setCadmium(bool cadmium) {
    _isCadmium = cadmium;
    update();
  }

  bool _firstEnzyme = false;

  bool get firstEnzym => _firstEnzyme;

  void setFirstEnzyme(bool firstEnyzme) {
    _firstEnzyme = firstEnyzme;
    update();
  }

  bool _lastEnzyme = false;

  bool get lastEnzyme => _lastEnzyme;

  void setLastEnzyme(bool lastEnzyme) {
    _lastEnzyme = lastEnzyme;
    update();
  }

  SettingProvider() {
    _setting = Setting();
    // _setOperationDuration();
  }

  void _reset({required Substance substance}) {
    _setting = Setting();
    setSubstance(substance);
  }

  void initialize({Setting? model}) {
    model ??= Manager.setting.get();

    if (_setting.substance != model.substance) {
      _reset(substance: _setting.substance);
      return;
    }

    _setting
      ..mode = model.mode
      ..fileName = model.fileName
      ..substance = model.substance
      ..filterOption = model.filterOption
      ..usePrevOffset = model.usePrevOffset
      ..currentRange = model.currentRange
      ..isUse3Pin = model.isUse3Pin
      ..rePin = model.rePin
      ..wePin = model.wePin
      ..cePin = model.wePin
      ..scanRate = model.scanRate
      ..eStep = model.eStep
      ..tStep = model.tStep
      // ..tInterval = model.tInterval
      ..eDc1 = model.eDc1
      ..tRun1 = model.tRun1
      ..eCondition = model.eCondition // add on
      ..tCondition = model.tCondition // add on
      ..eDeposition = model.eDeposition
      ..tDeposition = model.tDeposition
      ..ePulse = model.ePulse
      ..tPulse = model.tPulse;
    // _setOperationDuration();
  }

  Setting get setting => _setting;
  int get operationDuration => _operationDuration;

  String get pinLabel => (_setting.isUse3Pin) ? '3 pin' : '2 pin';

  Mode get mode => _setting.mode;
  String get fileName => _setting.fileName;

  Substance get substance => _setting.substance;
  FilterOption get filterOption => _setting.filterOption;

  // bool get isNoTick => _setting.isNoTick;
  bool get usePrevOffset => _setting.usePrevOffset;
  // bool get useShortDepos => _setting.useShortDepos;

  // partial graph preview
  double get currentRange => _setting.currentRange;

  // custom io
  bool get isUse3Pin => _setting.isUse3Pin;
  int get rePin => _setting.rePin;
  int get wePin => _setting.wePin;
  int get cePin => _setting.cePin;

  // scan rate
  double get scanRate => _setting.scanRate;
  int get eStep => _setting.eStep;
  int get tStep => _setting.tStep;

  // cam
  // int get tInterval => _setting.tInterval;
  double get eDc1 => _setting.eDc1;
  int get tRun1 => _setting.tRun1;

  // cvm
  double get eBegin => _setting.eBegin;
  double get eEnd => _setting.eEnd;

  // lsv
  double get eDeposition => _setting.eDeposition;
  int get tDeposition => _setting.tDeposition;

  // dpv / swv
  // double get ePulse => _setting.ePulse;
  int get tPulse => _setting.tPulse;

  void setSubstance(
    Substance value,
  ) {
    _setting.substance = value;

    Manager.result.setPeak(
      substance: value,
    );

    switch (value) {
      case Substance.ARSENIC:
        _setArsenic();
        break;

      case Substance.CHROMIUM:
        _setChromium();
        break;

      case Substance.MERCURY:
        _setMercury();
        break;

      case Substance.CADMIUM_LEAD:
        _setCadmiumLead();
        break;

      case Substance.CYPERMETHRIN:
        _setCypermethrin();
        break;

      case Substance.CARBARYL:
        _setCarbaryl();
        break;

      case Substance.CHLORPYRIFOS:
        _setChlorpyrifos();
        break;

      default:
        throw UnimplementedError('Unexpected substance value: $value');
    }
  }

  set fileName(String value) {
    _setting.fileName = value;
  }

  void setFilterOption(FilterOption value) {
    if (value != filterOption) {
      _setting.filterOption = value;
      update();
    }
  }

  void setUsePrevOffset(bool value) {
    if (value != usePrevOffset) {
      _setting.usePrevOffset = value;
      update();
    }
  }

  //partial graph preview
  void setCurrentRange(double value) {
    if (value != currentRange) {
      _setting.currentRange = value;
      update();
    }
  }

  // custom io
  void setRePin(int value) {
    if (value != rePin) {
      _setting.rePin = value;
      update();
    }
  }

  void setWePin(int value) {
    if (value != wePin) {
      _setting.wePin = value;
      update();
    }
  }

  void setCePin(int value) {
    if (value != cePin) {
      _setting.cePin = value;
      update();
    }
  }

  // scan rate
  void setEStep(int value) {
    if (value != eStep) {
      _setting.eStep = value;

      update();
    }
  }

  void setTStep(int value) {
    if (value != tStep) {
      _setting.tStep = value;

      update();
    }
  }

  // cam
  // void setTInterval(int value) {
  //   if (value != tInterval) {
  //     _setting.tInterval = value;
  //     update();
  //   }
  // }

  void setEDc1(double value) {
    if (value != eDc1) {
      _setting.eDc1 = value;
      update();
    }
  }

  void setTRun1(int value) {
    if (value != tRun1) {
      _setting.tRun1 = value;
      // _setOperationDuration();
      update();
    }
  }

  // cvm
  void setEBegin(double value) {
    if (value != eBegin) {
      _setting.eBegin = value;
      // _setOperationDuration();
      update();
    }
  }

  void setEEnd(double value) {
    if (value != eEnd) {
      _setting.eEnd = value;
      // _setOperationDuration();
      update();
    }
  }

  // lsv
  void setEDeposition(double value) {
    if (value != eDeposition) {
      _setting.eDeposition = value;
      // _setOperationDuration();
      update();
    }
  }

  void setTDeposition(int value) {
    if (value != tDeposition) {
      _setting.tDeposition = value;
      // _setOperationDuration();
      update();
    }
  }

  // dpv / swv
  // void setEPulse(double value) {
  //   if (value != ePulse) {
  //     _setting.ePulse = value;
  //     update();
  //   }
  // }

  void _setArsenic() {
    _setting.mode = Mode.DIFFERENTIAL_PULSE_VOLTAMMETRY_MODE;
    // _setting.filterOption = FilterOption.BW_10; // ?????

    _setting.currentRange = SettingArray.CURRENT_RANGE[1];

    _setting.isUse3Pin = false;
    _setting.rePin = SettingArray.PIN[0];
    _setting.wePin = SettingArray.PIN[1];
    _setting.cePin = SettingArray.PIN[2]; // ?????

    // _setting.tInterval = SettingArray.T_INTERVAL[0]; // ??? 100 ms

    _setting.eCondition = -0.5;
    _setting.tCondition = 1;
    _setting.eDeposition = -0.5;
    _setting.tDeposition = 160; // OLD [ 60 / 180 s ] NEW ONDE 160 s

    _setting.eBegin = -0.5;
    _setting.eEnd = 0.5;

    _setting.ePulse = 100; //! mV
    _setting.tPulse = 100;

    _setting.eStep = 40;
    _setting.tStep = 200;
    _setting.scanRate = 0.2;

    // _setOperationDuration();
  }

  void _setChromium() {
    _setting.mode = Mode.DIFFERENTIAL_PULSE_VOLTAMMETRY_MODE;
    // _setting.filterOption = FilterOption.BW_10;

    _setting.currentRange = SettingArray.CURRENT_RANGE[1];

    _setting.isUse3Pin = false;
    _setting.rePin = SettingArray.PIN[0];
    _setting.wePin = SettingArray.PIN[1];
    _setting.cePin = SettingArray.PIN[2]; // ?????

    // _setting.tInterval = SettingArray.T_INTERVAL[0];

    _setting.eCondition = 0.75; // fix
    _setting.tCondition = 1;
    _setting.eDeposition = 0.75; // fix
    _setting.tDeposition = 1;

    _setting.eBegin = 0.75; // fix
    _setting.eEnd = -0.3;

    _setting.ePulse = 100;
    _setting.tPulse = 100;

    _setting.eStep = 40;
    _setting.tStep = 200;
    _setting.scanRate = 0.2;

    // _setOperationDuration();
  }

  void _setMercury() {
    _setting.mode = Mode.DIFFERENTIAL_PULSE_VOLTAMMETRY_MODE;
    // _setting.filterOption = FilterOption.BW_10;

    _setting.currentRange = SettingArray.CURRENT_RANGE[1];

    _setting.isUse3Pin = false;
    _setting.rePin = SettingArray.PIN[0];
    _setting.wePin = SettingArray.PIN[1];
    _setting.cePin = SettingArray.PIN[2];

    // _setting.tInterval = SettingArray.T_INTERVAL[0];

    _setting.eCondition = -0.8;
    _setting.tCondition = 1;
    _setting.eDeposition = -0.8;
    _setting.tDeposition = 60;

    _setting.eBegin = -0.5;
    _setting.eEnd = 0.5;

    _setting.ePulse = 100;
    _setting.tPulse = 100;

    _setting.eStep = 40;
    _setting.tStep = 200;
    _setting.scanRate = 0.2;

    // _setOperationDuration();
  }

  void _setCadmiumLead() {
    _setting.mode = Mode.DIFFERENTIAL_PULSE_VOLTAMMETRY_MODE;
    // _setting.filterOption = FilterOption.BW_10;

    _setting.currentRange = SettingArray.CURRENT_RANGE[1];

    _setting.isUse3Pin = false;
    _setting.rePin = SettingArray.PIN[0];
    _setting.wePin = SettingArray.PIN[1];
    _setting.cePin = SettingArray.PIN[2];

    // _setting.tInterval = SettingArray.T_INTERVAL[0];

    _setting.eCondition = -1.2;
    _setting.tCondition = 1;
    _setting.eDeposition = -1.2;
    _setting.tDeposition = 120;

    _setting.eBegin = -1.2;
    _setting.eEnd = -0.3;

    _setting.ePulse = 125;
    _setting.tPulse = 100;

    _setting.eStep = 20;
    _setting.tStep = 200;
    _setting.scanRate = 0.1;
    // _setOperationDuration();
  }

  void _setCypermethrin() {
    _setting.mode = Mode.CHRONOAMPEROMETRY_MODE;
    _setting.filterOption = FilterOption.BW_1;

    _setting.currentRange = SettingArray.CURRENT_RANGE[1];

    _setting.isUse3Pin = true;
    _setting.rePin = SettingArray.PIN[0];
    _setting.wePin = SettingArray.PIN[1];
    _setting.cePin = SettingArray.PIN[2];

    // _setting.tInterval = SettingArray.T_INTERVAL[0];

    // add on REF TOXIN-SIC [ONDE]
    _setting.eCondition = 0;
    _setting.tCondition = 0;
    _setting.eDeposition = 0;
    _setting.tDeposition = 0;

    // _setting.eDc1 = -0.08; //TODO : 20/12/2021

    _setting.eDc1 = -0.24;

    _setting.tRun1 = 100;

    // _setOperationDuration();
  }

  void _setCarbaryl() {
    _setting.mode = Mode.CHRONOAMPEROMETRY_MODE;
    _setting.filterOption = FilterOption.BW_1;

    _setting.currentRange = SettingArray.CURRENT_RANGE[1];

    _setting.isUse3Pin = true;
    _setting.rePin = SettingArray.PIN[0];
    _setting.wePin = SettingArray.PIN[1];
    _setting.cePin = SettingArray.PIN[2];

    // _setting.tInterval = SettingArray.T_INTERVAL[0];

    // add on REF TOXIN-SIC [ONDE]
    _setting.eCondition = 0;
    _setting.tCondition = 0;
    _setting.eDeposition = 0;
    _setting.tDeposition = 0;

    // _setting.eDc1 = 0.23; //TODO : 20/12/2021

    _setting.eDc1 = 0.60;

    _setting.tRun1 = 100;

    // _setOperationDuration();
  }

  void _setChlorpyrifos() {
    _setting.mode = Mode.CHRONOAMPEROMETRY_MODE;
    _setting.filterOption = FilterOption.BW_1;

    _setting.currentRange = SettingArray.CURRENT_RANGE[1];

    _setting.isUse3Pin = true; // [TOXIN false] [ONDE true]
    _setting.rePin = SettingArray.PIN[0];
    _setting.wePin = SettingArray.PIN[1];
    _setting.cePin = SettingArray.PIN[2];

    // _setting.tInterval = SettingArray.T_INTERVAL[1];

    _setting.eCondition = 0;
    _setting.tCondition = 0;
    _setting.eDeposition = 0;
    _setting.tDeposition = 0;

    _setting.eDc1 = 0.8;
    _setting.tRun1 = 100;
    // _setting.tRun1 = 10;

    // _setOperationDuration();
  }

  // void _setOperationDuration() {
  //   switch (mode) {
  //     case Mode.CHRONOAMPEROMETRY_MODE:
  //       _operationDuration = (tDeposition + tRun1);
  //       break;

  //     case Mode.DIFFERENTIAL_PULSE_VOLTAMMETRY_MODE:
  //       _operationDuration = (tDeposition +
  //               (tStep * ((eBegin.abs() + eEnd.abs()) / eStep.abs())))
  //           .round();
  //       break;

  //     default:
  //       _operationDuration = 0;
  //   }
  // }
}
