part of nfc_sic.tasks;

class ReactionTask {
  ReactionTask._() : _mNfc = Sic4341.instance;

  static const String UID_SAMPLE_4340 = "3948FFFF03";
  static const String UID_PRODUCTION_4340 = "394803";

  final Sic4341 _mNfc;

  bool checkUid({String uid = ''}) {
    if (_mNfc.checkedUid()) {
      // debugPrint("checkUid: $uid");

      final _uidSample = uid.substring(0, 10);
      final _uidProduction = uid.substring(0, 6);

      return (_uidSample != UID_SAMPLE_4340) &&
          (_uidProduction != UID_PRODUCTION_4340);
    } else {
      return false;
    }
  }

  Future<void> validatePower() async {
    // debugPrint("validate power(ReactionTask)");
    const _flag = Status.VDD_RDY_L | Status.VDD_RDY_H;
    var _limit = 10;

    try {
      _mNfc.timeout = 100;

      final _register = _mNfc.getRegister();
      var _status = 0x00;

      //! TEST

      // await _register.clearFlags();

      // await _register.write(0x39, 0x3D);
      // await _register.write(0x3B, 0xF0);
      // await _register.write(0x13, 0x00);

      do {
        await _register.clearFlags();

        await RxFunc.checkErrorNfcInvalid(_mNfc);
        await RxFunc.checkErrorZeroCounter(_limit--);

        await Future.delayed(const Duration(milliseconds: 500), () => null);

        _status = await _mNfc.getStatus().getStatus();
      } while (_mNfc.isVddHError() ||
          _mNfc.isVddLError() ||
          ((_status & _flag) != _flag));
    } catch (error, stackTrace) {
      throw TaskException(
          task: "ReactionTask",
          method: "validatePower",
          details: error,
          stackTrace: stackTrace ?? StackTrace.current);
    }
  }

  Future<void> checkRevision(CharacteristicManager characteristic) async {
    final _revision = await _mNfc.getRegister().read(0x1F);

    characteristic.setRevision(_revision);
    // debugPrint("rev $_revision");
  }

  Future<void> validateEeprom(CharacteristicManager characteristic) async {
    // debugPrint("validate eeprom(ReactionTask)");

    // if ( listEquals(characteristic.get().uid, _mNfc.uid) ) {
    //   return;
    // }

    characteristic.uid = _mNfc.uid;

    var _recv = await _mNfc.autoTransceive(Eeprom.getPackageRead(0x2C));
    // debugPrint("validate eeprom(ReactionTask) Package Read(0x2C): $_recv");

    await RxFunc.checkErrorMismatchSize(_recv, 16);
    await characteristic.setChipInfoFromPage2C(_recv);

    _recv = await _mNfc.autoTransceive(Eeprom.getPackageRead(0x28));
    // debugPrint("validate eeprom(ReactionTask) Package Read(0x28): $_recv");

    await RxFunc.checkErrorMismatchSize(_recv, 16);
    await characteristic.setChipInfoFromPage28(_recv);

    //! TEST
    _recv = await _mNfc.autoTransceive(Eeprom.getPackageRead(0x2F));

    // _recv = await _mNfc.autoTransceive(Uint8List.fromList([0x30, 0x2F]));

    print(_recv);

    _recv = await _mNfc.autoTransceive(Eeprom.getPackageRead(0x33));

    print(_recv);

    _recv = await _mNfc.autoTransceive(Eeprom.getPackageRead(0x30));
    // debugPrint("validate eeprom(ReactionTask) Package Read(0x30): $_recv");

    await RxFunc.checkErrorMismatchSize(_recv, 16);
    await characteristic.setChipInfoFromPage30(_recv);
  }

  Future<bool> calibrate(
      CharacteristicManager characteristic, int vBias) async {
    // debugPrint("calibration(ReactionTask)");
    _mNfc.timeout = 4000;
    await _mNfc.getRegister().clearFlags();

    final _recv = await _mNfc.autoTransceive(Adc.getPackageConvAdc());
    // debugPrint("calibration(ReactionTask) receiver: $_recv");

    await RxFunc.checkErrorNfcInvalid(_mNfc);
    await RxFunc.checkErrorLowPower(_mNfc);
    await RxFunc.checkErrorMismatchSize(_recv, 3);

    final _result = (_recv[1] << 8) | (0xFF & _recv[2]);

    await characteristic.addOffset(vBias, _result.toDouble());
    // debugPrint("calibration(ReactionTask) offset: $_result, bias: $vBias");

    return true;
  }

  Future<void> passDropDetect(Characteristic characteristic) async {
    // debugPrint("pass drop detection(ReactionTask)");
    _mNfc.timeout = 2000;

    await Task.register.configDacRegister(characteristic, 0);

    final _recv = await _mNfc.autoTransceive(Adc.getPackageConvAdc());
    // debugPrint("pass drop detection(ReactionTask) receiver: $_recv");

    print("pass drop detection(ReactionTask) receiver: $_recv");

    await RxFunc.checkErrorSendComplete(_mNfc);
    await RxFunc.checkErrorVdd(_mNfc);
    await RxFunc.checkErrorLeastArray(_recv, 3);
  }

  Future<void> reactIgnore() async {
    // debugPrint("react ignore(ReactionTask)");
    _mNfc.timeout = 4000;

    await _mNfc.autoTransceive(Adc.getPackageConvAdc());

    await RxFunc.checkErrorNfcInvalid(_mNfc);
    await RxFunc.checkErrorLowPower(_mNfc);

    _mNfc.autoDisconnect = false;
  }

  Future<int> react() async {
    // debugPrint("react(ReactionTask) react get adc");
    final _recv = await _mNfc.autoTransceive(Adc.getPackageConvAdc());
    // debugPrint("react(ReactionTask) receive: $_recv");

    /*
    await RxFunc.checkErrorNfcInvalid(_mNfc);
    await RxFunc.checkErrorLowPower(_mNfc);
    await RxFunc.checkErrorMismatchSize(_recv, 3);
    */

    return (_recv[1] << 8) | (0xFF & _recv[2]);
  }
}
