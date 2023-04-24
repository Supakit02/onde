library nfc_sic.chip.sic4341;

import 'dart:math' as math;
import 'dart:typed_data'
  show Uint8List;

// import 'package:flutter/foundation.dart'
//   show debugPrint;

import '../providers/providers.dart';
import '../utils/utils.dart'
  show OthersException;
import 'sic_chip.dart'
  show SicChip;

part 'sic4341/adc.dart';
part 'sic4341/dac.dart';
part 'sic4341/flag.dart';
part 'sic4341/gpio.dart';
part 'sic4341/idrv.dart';
part 'sic4341/config.dart';
part 'sic4341/status.dart';
part 'sic4341/register.dart';

class Sic4341 extends SicChip {
  Sic4341._() : super();

  /// 0x3948 for LG
  static const int SIC4341_UID_1 = 0x48;

  static Sic4341 _instance;

  /// Singleton instance of Sic4341.
  // ignore: prefer_constructors_over_static_methods
  static Sic4341 get instance =>
      _instance ??= Sic4341._();

  Register _register;
  Adc _adc;
  Config _config;
  Dac _dac;
  Gpio _gpio;
  Idrv _idrv;
  Status _status;

  Adc getAdc() =>
      _adc ??= Adc._(this);
  Dac getDac() =>
      _dac ??= Dac._(this);
  Idrv getIdrv() =>
      _idrv ??= Idrv._(this);
  Gpio getGpio() =>
      _gpio ??= Gpio._(this);
  Config getConfig() =>
      _config ??= Config._(this);
  Status getStatus() =>
      _status ??= Status._(this);

  @override
  Register getRegister() =>
      _register ??= Register._(this);

  @override
  bool checkedUid() =>
      super.checkedUid() && (uid[1] == SIC4341_UID_1);

  /// Checks the latest response flag for a `VDD_RDY_L`.
  ///
  ///     [return] true, if a [VDD L] ready.
  ///
  bool isVddLError() =>
      Flag.isNakVddL(response);

  /// Checks the latest response flag for a `VDD_RDY_H`.
  ///
  ///     [return] true, if a [VDD H] ready.
  ///
  bool isVddHError() =>
      Flag.isNakVddH(response);
}