library nfc_sic.process;

import 'dart:async'
  show Timer;
import 'dart:ui'
  show VoidCallback;

import 'package:flutter/widgets.dart'
  show required;
// import 'package:flutter/foundation.dart'
//   show debugPrint;

import 'package:rxdart/rxdart.dart';

import '../managers/managers.dart'
  show IoData;
import '../tasks/tasks.dart'
  show
    Task,
    RxTask;
import '../utils/utils.dart';

part 'calibration.dart';
part 'conversion.dart';

typedef _TimeCountCallback = void Function(int sec);
typedef _IoDataCallback = void Function(IoData data);
typedef _MapIoDataCallback = IoData Function(IoData data);
typedef _MapResultCallback<S> = S Function(IoData data, int index);
typedef _IndexCallback<S> = void Function(S data);