part of nfc_sic.tasks;

class RegisterTask {
  RegisterTask._()
    : _mNfc = Sic4341.instance;

  final Sic4341 _mNfc;

  Future<void> configPinRegister(
      Setting setting, { bool isUse3Pin }) async {
    // debugPrint("configCalibrationRegister(RegisterTask)");
    final _revision = Manager.characteristic.get().revision;

    final _rangeItem = ReactFunc.getIndexCurrentRange(
      setting.currentRange);

    final _ioPin = ReactFunc.getIoPin(
      isUse3Pin: isUse3Pin);
    final _shrt = ReactFunc.getReCeShortFromPinSelect(_ioPin);

    final _re = setting.rePin;
    final _we = setting.wePin;
    final _ce = ReactFunc.getCePinFromPinSelect(
      setting.cePin, isUse3Pin: isUse3Pin);

    final _register = _mNfc.getRegister();
    _mNfc.timeout = 100;

    await _register.writeParams(
      Register.CHEM_CFG,
      Config.CHEM_RE_CE_SHT | Config.CHEM_RANGE,
      _shrt | _rangeItem
    );
    await RxFunc.checkErrorNfcInvalid(_mNfc);

    await _register.writeParams(
      Register.SENSOR_CFG,
      Config.CHEM_EN | Config.DAC_EN | Config.CHEM_SENS_EN | Config.ADC_ANA_EN,
      Config.CHEM_EN__Enable | Config.DAC_EN__Enable
    );
    await RxFunc.checkErrorNfcInvalid(_mNfc);

    if ( (_ioPin == 0) && (_revision == 2) ) {
      await _register.writeParams(
        Register.DAC_CFG,
        Dac.DAC1_CE_CH | Dac.DAC2_WE_VD_CH | Dac.RE_VG_CH,
        _re | (_we << 2) | (_ce << 4)
      );
    } else {
      await _register.writeParams(
        Register.DAC_CFG,
        Dac.DAC1_CE_CH | Dac.DAC2_WE_VD_CH | Dac.RE_VG_CH,
        _ce | (_we << 2) | (_re << 4)
      );
    }
    await RxFunc.checkErrorNfcInvalid(_mNfc);
  }

  Future<void> configCalibrationRegister(Setting setting) async {
    // debugPrint("configCalibrationRegister(RegisterTask)");
    final _revision = Manager.characteristic.get().revision;

    final _range = ReactFunc.getIndexCurrentRange(
      setting.currentRange);

    final _pin = ReactFunc.getIoPin(
      isUse3Pin: setting.isUse3Pin);
    final _shrt = ReactFunc.getReCeShortFromPinSelect(_pin);

    final _re = setting.rePin;
    final _we = setting.wePin;
    final _ce = ReactFunc.getCePinFromPinSelect(
      setting.cePin, isUse3Pin: setting.isUse3Pin);

    final _register = _mNfc.getRegister();
    _mNfc.timeout = 100;

    await _register.writeParams(
      Register.ADC_DIVIDER,
      Adc.ADC_DIVIDER,
      143
    );
    await RxFunc.checkErrorNfcInvalid(_mNfc);

    await _register.writeParams(
      Register.ADC_PRESCALER,
      Adc.ADC_PRESCALER,
      0
    );
    await RxFunc.checkErrorNfcInvalid(_mNfc);

    await _register.writeParams(
      Register.ADC_CONV_CFG,
      Adc.ADC_CONV_MODE,
      Adc.ADC_CONV_MODE__Normal
    );
    await RxFunc.checkErrorNfcInvalid(_mNfc);

    await _register.writeParams(
      Register.CHEM_CFG,
      Config.CHEM_RE_CE_SHT | Config.CHEM_RANGE,
      _shrt | _range
    );
    await RxFunc.checkErrorNfcInvalid(_mNfc);

    await _register.writeParams(
      Register.SENSOR_CFG,
      Config.CHEM_EN | Config.DAC_EN | Config.CHEM_SENS_EN | Config.ADC_ANA_EN,
      Config.CHEM_EN__Enable | Config.DAC_EN__Enable
    );
    await RxFunc.checkErrorNfcInvalid(_mNfc);

    // if ( setting.isNoTick ) {
    //   await _register.writeParams(
    //     Register.ADC_NBIT,
    //     Adc.ADC_OSR | Adc.ADC_AVG | Adc.ADC_SIGNED,
    //     Adc.ADC_OSR__512_14b | Adc.ADC_AVG__Time_2 | Adc.ADC_SIGNED__Signed
    //   );
    // } else {
    await _register.writeParams(
      Register.ADC_NBIT,
      Adc.ADC_OSR | Adc.ADC_AVG | Adc.ADC_SIGNED,
      Adc.ADC_OSR__1024_14b | Adc.ADC_AVG__Time_4 | Adc.ADC_SIGNED__Signed
    );
    // }
    await RxFunc.checkErrorNfcInvalid(_mNfc);

    if ( (_pin == 0) && (_revision == 2) ) {
      await _register.writeParams(
        Register.DAC_CFG,
        Dac.DAC1_CE_CH | Dac.DAC2_WE_VD_CH | Dac.RE_VG_CH,
        _re | (_we << 2) | (_ce << 4)
      );
    } else {
      await _register.writeParams(
        Register.DAC_CFG,
        Dac.DAC1_CE_CH | Dac.DAC2_WE_VD_CH | Dac.RE_VG_CH,
        _ce | (_we << 2) | (_re << 4)
      );
    }
    await RxFunc.checkErrorNfcInvalid(_mNfc);

    await _register.clearFlags();
    await RxFunc.checkErrorNfcInvalid(_mNfc);
  }

  Future<void> configReactionRegister(Setting setting) async {
    // debugPrint("configReactionRegister(RegisterTask)");
    final _revision = Manager.characteristic.get().revision;

    final _pin = ReactFunc.getIoPin(
      isUse3Pin: setting.isUse3Pin);
    final _re = setting.rePin;
    final _we = setting.wePin;
    final _ce = ReactFunc.getCePinFromPinSelect(
      setting.cePin, isUse3Pin: setting.isUse3Pin);
    final _tick = setting.tPulse;

    var _tickPeriod = Adc.ADC_TICK_TIME_PERIOD__100ms;
    var _adcAvg = Adc.ADC_AVG__Time_4;
    var _osr = Adc.ADC_OSR__512_14b;
    var _nWait = (12 << 4) | 7;

    switch (_tick) {
      case 200:
        _tickPeriod = Adc.ADC_TICK_TIME_PERIOD__200ms;
        _adcAvg = Adc.ADC_AVG__Time_4;
        _osr = Adc.ADC_OSR__1024_14b;
        _nWait = (14 << 4) | 8;
        break;

      case 500:
        _tickPeriod = Adc.ADC_TICK_TIME_PERIOD__500ms;
        _adcAvg = Adc.ADC_AVG__Time_4;
        _osr = Adc.ADC_OSR__1024_14b;
        _nWait = (9 << 4) | 11;
        break;

      case 1000:
        _tickPeriod = Adc.ADC_TICK_TIME_PERIOD__1000ms;
        _adcAvg = Adc.ADC_AVG__Time_32;
        _osr = Adc.ADC_OSR__1024_14b;
        _nWait = (12 << 4) | 10;
        break;

      default:
        _tickPeriod = Adc.ADC_TICK_TIME_PERIOD__100ms;
        _adcAvg = Adc.ADC_AVG__Time_4;
        _osr = Adc.ADC_OSR__512_14b;
        _nWait = (12 << 4) | 7;
    }

    final _register = _mNfc.getRegister();

    _mNfc.timeout = _tick;

    await _register.writeParams(
      Register.SENSOR_CFG,
      Config.CHEM_EN | Config.DAC_EN | Config.CHEM_SENS_EN | Config.ADC_ANA_EN,
      Config.CHEM_EN__Enable | Config.DAC_EN__Enable
    );
    await RxFunc.checkErrorNfcInvalid(_mNfc);

    // if ( setting.isNoTick ) {
    //   await _register.writeParams(
    //     Register.ADC_CONV_CFG,
    //     Adc.ADC_CONV_MODE,
    //     Adc.ADC_CONV_MODE__Normal
    //   );

    //   await _register.writeParams(
    //     Register.ADC_NBIT,
    //     Adc.ADC_OSR | Adc.ADC_AVG | Adc.ADC_SIGNED,
    //     Adc.ADC_OSR__512_14b | Adc.ADC_AVG__Time_2 | Adc.ADC_SIGNED__Signed
    //   );

    //   await _register.writeParams(
    //     Register.ADC_NWAIT,
    //     Adc.NWAIT_MUL | Adc.NWAIT_PRESCALER,
    //     0x47
    //   );
    // } else {
    await _register.writeParams(
      Register.ADC_CONV_CFG,
      Adc.ADC_CONV_MODE | Adc.ADC_TICK_RSP | Adc.ADC_TICK_TIME_PERIOD,
      Adc.ADC_CONV_MODE__Tick | Adc.ADC_TICK_RSP__AtTickPeriod | _tickPeriod
    );

    await _register.writeParams(
      Register.ADC_NBIT,
      Adc.ADC_OSR | Adc.ADC_AVG | Adc.ADC_SIGNED,
      _osr | _adcAvg | Adc.ADC_SIGNED__Signed
    );

    await _register.writeParams(
      Register.ADC_NWAIT,
      Adc.NWAIT_MUL | Adc.NWAIT_PRESCALER,
      _nWait
    );
    // }
    await RxFunc.checkErrorNfcInvalid(_mNfc);

    if ( (_pin == 0) && (_revision == 2) ) {
      await _register.writeParams(
        Register.DAC_CFG,
        Dac.DAC1_CE_CH | Dac.DAC2_WE_VD_CH | Dac.RE_VG_CH,
        _re | (_we << 2) | (_ce << 4)
      );
    } else {
      await _register.writeParams(
        Register.DAC_CFG,
        Dac.DAC1_CE_CH | Dac.DAC2_WE_VD_CH | Dac.RE_VG_CH,
        _ce | (_we << 2) | (_re << 4)
      );
    }
    await RxFunc.checkErrorNfcInvalid(_mNfc);
  }

  Future<void> configResetTimeRegister() async {
    // debugPrint("configResetTimeRegister(RegisterTask)");
    await _mNfc.getRegister().writeParams(
      Register.DAC_CFG,
      Dac.DAC1_CE_CH | Dac.DAC2_WE_VD_CH | Dac.RE_VG_CH,
      0x3F
    );
    await RxFunc.checkErrorNfcInvalid(_mNfc);
  }

  Future<void> configEndProcessRegister() async {
    // debugPrint("configEndProcessRegister(RegisterTask)");
    // await Future.delayed(
    //   const Duration(milliseconds: 500), () => null);

    final _register = _mNfc.getRegister();

    await _register.writeParams(
      Register.ADC_CONV_CFG,
      Adc.ADC_CONV_MODE,
      Adc.ADC_CONV_MODE__Normal
    );
    await RxFunc.checkErrorNfcInvalid(_mNfc);

    await _register.writeParams(
      Register.ADC_NBIT,
      Adc.ADC_OSR | Adc.ADC_AVG | Adc.ADC_SIGNED,
      Adc.ADC_OSR__128_10b | Adc.ADC_AVG__Time_2 | Adc.ADC_SIGNED__Signed
    );
    await RxFunc.checkErrorNfcInvalid(_mNfc);

    await _register.writeParams(
      Register.ADC_NWAIT,
      Adc.NWAIT_MUL | Adc.NWAIT_PRESCALER,
      0
    );
    await RxFunc.checkErrorNfcInvalid(_mNfc);

    await _register.writeParams(
      Register.SENSOR_CFG,
      Config.CHEM_EN | Config.DAC_EN | Config.CHEM_SENS_EN | Config.ADC_ANA_EN,
      0
    );

    await _register.writeParams(
      Register.DAC_CFG,
      Dac.DAC1_CE_CH | Dac.DAC2_WE_VD_CH | Dac.RE_VG_CH | Dac.DAC1_BUF_EN | Dac.DAC2_BUF_EN,
      0
    );
    await RxFunc.checkErrorNfcInvalid(_mNfc);
  }

  Future<void> configDacRegister(
    Characteristic characteristic,
    int bias, {
    bool isNE = false,
    bool last = false,
  }) async {
    final _dac1 = await getDac1(
      characteristic,
      bias,
      isNE: isNE,
      last: last);
    final _dac2 = await getDac2(
      characteristic,
      bias,
      isNE: isNE,
      last: last);
    // debugPrint("configDacRegister(RegisterTask) bias: $bias, dac1: $_dac1, dac2: $_dac2");

    await fastWriteParam(
      Register.DAC1_VALUE,
      Dac.DAC1_VALUE,
      _dac1 ~/ 5
    );

    await fastWriteParam(
      Register.DAC2_VALUE,
      Dac.DAC2_VALUE,
      _dac2 ~/ 5
    );
    await RxFunc.checkErrorNfcInvalid(_mNfc);

    // debugPrint("bias: $bias, time: ${DateTime.now().toString()}");
  }

  Future<int> getDac1(
    Characteristic characteristic,
    int bias, {
    bool isNE = false,
    bool last = false,
  }) async {
    int _dac1;

    final _reOffset = characteristic.reOffset;

    if ( isNE ) {
      if ( last ) {
        _dac1 = (1200 - _reOffset).round();
      } else {
        _dac1 = (1200 + bias - _reOffset).round();
      }
    } else {
      if ( bias >= 0 ) {
        _dac1 = (400 - _reOffset).round();
      } else {
        _dac1 = (400 - _reOffset - bias).round();
      }
    }

    return _dac1.abs();
  }

  Future<int> getDac2(
    Characteristic characteristic,
    int bias, {
    bool isNE = false,
    bool last = false,
  }) async {
    int _dac2;

    final _weOffset = characteristic.weOffset;

    if ( isNE ) {
      if ( last ) {
        _dac2 = (450 + (bias * 2) - _weOffset).round();
      } else {
        _dac2 = (450 - _weOffset).round();
      }
    } else {
      if ( bias >= 0 ) {
        _dac2 = (400 + bias - _weOffset).round();
      } else {
        _dac2 = (400 - _weOffset).round();
      }
    }

    return _dac2.abs();
  }

  Future<void> fastWriteParam(
      int address, int pos, int value) async {
    // debugPrint("[write] address: $address, pos: $pos value: $value");

    await _mNfc.getRegister().write(
      address,
      value & pos);

    // debugPrint("receive: $_recv");
  }
}