part of nfc_sic.tasks;

class RxTask {
  RxTask._()
      : _task = Task.reaction,
        _config = Task.register;

  final ReactionTask _task;
  final RegisterTask _config;

  Stream<IoData> clearResultTest(IoData data) async* {
    // debugPrint("validatePower(RxTask)");
    try {
      await _task.validatePower();
      await _task.checkRevision(data.characteristic);
      await _task.validateEeprom(data.characteristic);

      await Future.delayed(const Duration(seconds: 5), () => null);

      yield data;
    } catch (error, stackTrace) {
      throw TaskException(
          task: "RxTask",
          method: "validatePower",
          details: error,
          stackTrace: stackTrace ?? StackTrace.current);
    }
  }

  Stream<IoData> validatePower(IoData data) async* {
    // debugPrint("validatePower(RxTask)");
    try {
      await _task.validatePower();
      await _task.checkRevision(data.characteristic);
      await _task.validateEeprom(data.characteristic);

      await Future.delayed(const Duration(seconds: 5), () => null);

      yield data;
    } catch (error, stackTrace) {
      throw TaskException(
          task: "RxTask",
          method: "validatePower",
          details: error,
          stackTrace: stackTrace ?? StackTrace.current);
    }
  }

  Stream<IoData> calibrateSensor(IoData data) async* {
    // debugPrint("calibrateSensor(RxTask)");
    final _setting = data.setting.get();

    try {
      await _config.configCalibrationRegister(_setting);

      if (!_setting.usePrevOffset) {
        await data.initOffset();
      } else {
        await data.calibration.setOffset(_setting.wePin);
      }

      await data.initResult();

      yield data;
    } catch (error, stackTrace) {
      throw TaskException(
          task: "RxTask",
          method: "calibrateSensor",
          details: error,
          stackTrace: stackTrace ?? StackTrace.current);
    }
  }

  // ! ADD ON [08/11/2021 ONDE Supakit]

  Stream<IoData> calibrateSingle(IoData data) async* {
    final _setting = data.setting.get();

    try {
      if (!_setting.usePrevOffset) {
        final _characteristic = data.characteristic.get();

        var _vBias = ReactFunc.toMilli(_setting.eDc1);
        await _config.configDacRegister(_characteristic, _vBias);
        await _task.calibrate(data.characteristic, _vBias);

        await data.characteristic.setOffsetVariable();

        await data.calibration
            .setOffsetPin(_setting.wePin, data.characteristic.externalOffset);

        await Future<void>.delayed(const Duration(milliseconds: 200));
        await data.calibration
            .storeOffsetData(_characteristic.uid, DateTime.now());
      }

      await _config.configResetTimeRegister();
    } catch (error, stackTrace) {
      throw TaskException(
          task: "RxTask",
          method: "calibrateSingle",
          details: error,
          stackTrace: stackTrace ?? StackTrace.current);
    } finally {
      yield data;
    }
  }

  Stream<IoData> calibrateMultiple(IoData data) async* {
    // debugPrint("calibrateMultiple(RxTask)");
    final _setting = data.setting.get();

    try {
      if (!_setting.usePrevOffset) {
        final _characteristic = data.characteristic.get();
        const _size = CharacteristicManager.OFFSET_SIZE;

        final _eBegin = ReactFunc.toMilli(-0.8);
        final _eEnd = ReactFunc.toMilli(0.8);

        final _min = math.min(_eBegin, _eEnd).toDouble();
        final _max = math.max(_eBegin, _eEnd).toDouble();

        final _ratio = (_max - _min) / (_size - 1);

        for (var _index = 0; _index < _size; _index++) {
          final _volt = (_index * _ratio + _min).round();

          await _config.configDacRegister(_characteristic, _volt);

          await _task.calibrate(data.characteristic, _volt);
        }

        await data.characteristic.setOffsetVariable();

        await data.calibration
            .setOffsetPin(_setting.wePin, data.characteristic.externalOffset);

        await data.calibration
            .storeOffsetData(_characteristic.uid, DateTime.now());
      }

      await _config.configResetTimeRegister();

      yield data;
    } catch (error, stackTrace) {
      throw TaskException(
          task: "RxTask",
          method: "calibrateMultiple",
          details: error,
          stackTrace: stackTrace ?? StackTrace.current);
    }
  }

  Stream<IoData> condition(IoData data) async* {
    // debugPrint("condition(RxTask)");
    final _setting = data.setting.get();
    final _characteristic = data.characteristic.get();

    final _isUse3Pin = _setting.isUse3Pin;
    final _useShortDepos = _setting.useShortDepos;
    final _tCondition = _setting.tCondition;

    try {
      await _config.configReactionRegister(_setting);

      if (_useShortDepos && _isUse3Pin) {
        await _config.configPinRegister(_setting, isUse3Pin: false);
      }

      if (_tCondition > 0) {
        final _vBias =
            ReactFunc.round(ReactFunc.toMilli(_setting.eCondition) ~/ 2, 5);

        await _config.configDacRegister(_characteristic, _vBias,
            isNE: true, last: _vBias >= 0);
      }

      yield data;
    } catch (error, stackTrace) {
      throw TaskException(
          task: "RxTask",
          method: "condition",
          details: error,
          stackTrace: stackTrace ?? StackTrace.current);
    }
  }

  Stream<IoData> deposition(IoData data) async* {
    // debugPrint("deposition(RxTask)");
    final _setting = data.setting.get();
    final _characteristic = data.characteristic.get();

    final _tDeposition = _setting.tDeposition;

    try {
      if (_setting.mode == Mode.CHRONOAMPEROMETRY_MODE) {
        if (_tDeposition > 0) {
          await _config.configDacRegister(
              _characteristic, ReactFunc.toMilli(_setting.eDeposition));
        }
      } else if (_setting.mode == Mode.DIFFERENTIAL_PULSE_VOLTAMMETRY_MODE) {
        if (_tDeposition > 0) {
          final _vBias =
              ReactFunc.round(ReactFunc.toMilli(_setting.eDeposition) ~/ 2, 5);

          await _config.configDacRegister(_characteristic, _vBias,
              isNE: true, last: _vBias >= 0);
        }
      }

      yield data;
    } catch (error, stackTrace) {
      throw TaskException(
          task: "RxTask",
          method: "deposition",
          details: error,
          stackTrace: stackTrace ?? StackTrace.current);
    }
  }

  Stream<IoData> equilibration(IoData data) async* {
    // debugPrint("equilibration(RxTask)");
    final _setting = data.setting.get();
    final _characteristic = data.characteristic.get();

    final _tEquilibration = _setting.tEquilibration;

    try {
      if (_tEquilibration > 0) {
        final _vBias =
            ReactFunc.round(ReactFunc.toMilli(_setting.eBegin) ~/ 2, 5);

        await _config.configDacRegister(_characteristic, _vBias,
            isNE: true, last: _vBias >= 0);
      }

      yield data;
    } catch (error, stackTrace) {
      throw TaskException(
          task: "RxTask",
          method: "equilibration",
          details: error,
          stackTrace: stackTrace ?? StackTrace.current);
    }
  }

  Stream<IoData> initReaction(IoData data) async* {
    // debugPrint("initReaction(RxTask)");
    final _setting = data.setting.get();
    final _characteristic = data.characteristic.get();

    final _isUse3Pin = _setting.isUse3Pin;
    final _useShortDepos = _setting.useShortDepos;
    int _vBias = 0;

    try {
      if (_useShortDepos && _isUse3Pin) {
        await _config.configPinRegister(_setting, isUse3Pin: _isUse3Pin);
      }
      if (_setting.mode == Mode.CHRONOAMPEROMETRY_MODE) {
        _vBias = ReactFunc.round(ReactFunc.toMilli(_setting.eDc1), 5);
        await _config.configReactionRegister(_setting);
        await _config.configDacRegister(
          _characteristic,
          _vBias,
        );
      } else if (_setting.mode == Mode.DIFFERENTIAL_PULSE_VOLTAMMETRY_MODE) {
        _vBias = ReactFunc.round(ReactFunc.toMilli(_setting.eBegin) ~/ 2, 5);
        await _config.configReactionRegister(_setting);
        await _config.configDacRegister(_characteristic, _vBias,
            isNE: true, last: _vBias >= 0);
      }

      // isNE: true, last: _vBias >= 0);

      await _task.reactIgnore();

      yield data;
    } catch (error, stackTrace) {
      throw TaskException(
        task: "RxTask",
        method: "initReaction",
        details: error,
        stackTrace: stackTrace ?? StackTrace.current,
      );
    }
  }

  Stream<IoData> cleanProcess(IoData data) async* {
    // debugPrint("cleanProcess(RxTask)");
    try {
      await _config.configEndProcessRegister();

      yield data;
    } catch (error, stackTrace) {
      throw TaskException(
          task: "RxTask",
          method: "cleanProcess",
          details: error,
          stackTrace: stackTrace ?? StackTrace.current);
    }
  }

  //! add Conversion CA
  Stream<int> conversionCA(
      IoData data, int bias, int eStep, int start, int end, int time) async* {
    print(
        "bias : $bias , eStep : $eStep , start : $start , end : $end , time : $time");
    final _characteristic = data.characteristic.get();
    int a = 0;
    Get.put(DataController()).setTime(end ~/ 10); //!
    try {
      Sic4341.instance.timeout = 4000;

      await _config.configDacRegister(_characteristic, bias);

      for (var _index = 0; _index < end; _index++) {
        // debugPrint("convAmpero(RxTask) index $_index/$count");
        // debugPrint("convAmpero(RxTask) time: ${DateTime.now().toString()}");

        final _adc = await _task.react();
        print("_adc $_index : $_adc");
        final _current = await data.characteristic.getCurrent(_adc, bias);
        // debugPrint("convAmpero(RxTask) bias: $bias, adc: $_adc, _current: $_current");

        //!
        if (_index % 10 == 0 && _index != 0) {
          Get.put(DataController()).setData();
          print(_index);
        }

        yield data.collectResult(
          time: time,
          bias: bias,
          current: _current,
          adc: _adc,
        );
      }

      Get.put(DataController()).setConversionState(false);

      //! Change Detail
      // for (var i = 0; i <= end; i++) {
      //   var _index = (start + i);
      //   // debugPrint("conversion(RxTask) index $_index/$end, bias: $bias, eStep: $eStep");

      //   var _prevBias = (_index * eStep) + bias;
      //   var _bias = _prevBias + eStep;

      //   // debugPrint("conversion(RxTask) time: ${DateTime.now().toString()}");
      //   await _config.configDacRegister(_characteristic, _bias);

      //   var _prevAdc = await _task.react();
      //   final _prevCurrent =
      //       await data.characteristic.getCurrent(_prevAdc, _prevBias);
      //   // debugPrint("conversion(RxTask) prevAdc: $_prevAdc, prevBias: $_prevBias, prevCurrent: $_prevCurrent");

      //   yield data.collectResult(
      //     time: time,
      //     bias: _prevBias,
      //     current: _prevCurrent,
      //     adc: _prevAdc,
      //   );
      // }
    } catch (error, stackTrace) {
      throw TaskException(
        task: "RxTask",
        method: "conversion",
        details: error,
        stackTrace: stackTrace ?? StackTrace.current,
      );
    }
  }

  Stream<int> conversion(
    IoData data, {
    int bias,
    int ePulse,
    int eStep,
    int tStep,
    int size,
    int round1,
    int round2,
  }) async* {
    final _characteristic = data.characteristic.get();

    try {
      // debugPrint("conversion(RxTask) round1: $_round1, round2: $_round2");
      final _time1 = round1 * tStep;
      final _time2 = round2 * tStep;
      // debugPrint("conversion(RxTask) time1: $_time1, time2: $_time2");

      final _bias = bias ~/ 2;
      final _eStep = eStep ~/ 2;
      final _ePulse = ePulse ~/ 2;

      var _prevBias = _bias;
      var _bias1 = _bias + _ePulse;
      var _bias2 = _eStep + _bias;

      Sic4341.instance.timeout = 4000;

      for (var _index = 0;
          _index <= size;
          _index++, _prevBias += _eStep, _bias1 += _eStep, _bias2 += _eStep) {
        // debugPrint("conversion(RxTask) index $_index/$size");
        // debugPrint("_prevBias: $_prevBias, _bias1: $_bias1, _bias2: $_bias2");
        // if ( _bias1 > 800 ) {
        //   break;
        // }

        for (var i = 1; i < round1; i++) {
          await _task.react();
        }

        await _config.configDacRegister(_characteristic, _bias1,
            isNE: true, last: _bias2 >= 0);

        final _prevAdc = await _task.react();
        final _prevCurrent =
            await data.characteristic.getCurrent(_prevAdc, _prevBias);

        data.collectSecondResult(
          time: _time2,
          bias: _prevBias,
          current: _prevCurrent,
          adc: _prevAdc,
        );
        // debugPrint("conversion(RxTask) before --> bias: $_prevBias, I: $_prevCurrent");

        for (var i = 1; i < round2; i++) {
          await _task.react();
        }

        await _config.configDacRegister(_characteristic, _bias2,
            isNE: true, last: _bias2 >= 0);

        final _adc = await _task.react();
        final _current = await data.characteristic.getCurrent(_adc, _bias1);

        data.collectSecondResult(
          time: _time1,
          bias: _bias1,
          current: _current,
          adc: _adc,
        );
        // debugPrint("conversion(RxTask) after --> bias: $_bias1, I: $_current");

        final _iOutput = _current - _prevCurrent;
        final _adcOutput = _adc - _prevAdc;

        yield data.collectResult(
          time: _time1 + _time2,
          bias: _prevBias,
          current: _iOutput,
          adc: _adcOutput,
        );
      }
    } catch (error, stackTrace) {
      throw TaskException(
          task: "RxTask",
          method: "conversion",
          details: error,
          stackTrace: stackTrace ?? StackTrace.current);
    }
  }

  Future<void> delayTime() async {}
}
