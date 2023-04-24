library nfc_sic.utils;

import 'dart:async' show StreamSubscription;
import 'dart:io' show File, Platform, Directory;
import 'dart:typed_data' show Uint8List;

import 'package:flutter/foundation.dart'
    show
        required,
        // debugPrint,
        FlutterError,
        ErrorDescription,
        FlutterErrorDetails;

import 'package:convert/convert.dart' show hex;
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart'
    show getExternalStorageDirectory, getApplicationDocumentsDirectory;
import 'package:permission_handler/permission_handler.dart';

import '../chip/sic4341.dart' show Config, Sic4341;
import '../managers/managers.dart' show Manager;
import '../peak/peak.dart' show Substance;

part 'enums/polling.dart';
part 'enums/tag_status.dart';

part 'errors/error.dart';
part 'errors/exception.dart';

part 'functions/functions.dart';
part 'functions/file.dart';
part 'functions/react.dart';
part 'functions/report.dart';
part 'functions/rx.dart';

part 'mode.dart';
part 'array.dart';
part 'rx_helper.dart';

extension Uint8ListExtension on Uint8List {
  String toHexString() => hex.encode(toList()).toUpperCase();
}
