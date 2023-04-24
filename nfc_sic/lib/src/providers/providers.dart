library nfc_sic.providers;

import 'dart:typed_data'
  show Uint8List;

import 'package:flutter/foundation.dart'
  show
    protected,
    // debugPrint,
    mustCallSuper;

import '../chip/sic_chip.dart'
  show SicChip;
import '../utils/utils.dart'
  show
    ReactFunc,
    OthersException;

part 'buffer.dart';
part 'gpio_provider.dart';
part 'register_provider.dart';
part 'status_provider.dart';

abstract class ChipProvider {
  ChipProvider(SicChip chip)
    : _register = chip.getRegister(),
      _chip = chip;

  final SicChip _chip;
  final RegisterProvider _register;

  SicChip get chip => _chip;
  RegisterProvider get register => _register;
}