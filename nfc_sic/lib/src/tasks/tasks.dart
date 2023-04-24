library nfc_sic.tasks;

import 'dart:math' as math;
import 'dart:typed_data';

// import 'package:flutter/foundation.dart'
//   show
//     debugPrint;
//     listEquals;


import 'package:get/get.dart';
import 'package:nfc_sic/controller/DataController.dart';
import 'package:nfc_sic/nfc_sic.dart';

import '../chip/sic4341.dart';
import '../cmd/cmd.dart';
import '../managers/managers.dart'
  show
    IoData,
    Manager,
    CharacteristicManager;
import '../models/models.dart'
  show
    Setting,
    Characteristic;
import '../utils/utils.dart'
  show
    RxFunc,
    ReactFunc;
import '../utils/utils.dart';




part 'reaction.dart';
part 'rx.dart';
part 'register.dart';

class Task {
  Task._();

  static RxTask _rx;

  /// Singleton instance of ReactionRxTask.
  static RxTask get rx =>
      _rx ??= RxTask._();

  static ReactionTask _reaction;

  /// Singleton instance of ReactionTask.
  static ReactionTask get reaction =>
      _reaction ??= ReactionTask._();

  static RegisterTask _register;

  /// Singleton instance of RegisterTask.
  static RegisterTask get register =>
      _register ??= RegisterTask._();
}