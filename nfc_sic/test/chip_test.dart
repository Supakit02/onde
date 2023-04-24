import 'dart:typed_data'
  show Uint8List;

// import 'package:flutter/foundation.dart'
//   show debugPrint;

import 'package:flutter_test/flutter_test.dart';

import 'package:nfc_sic/src/chip/sic4341.dart';
import 'package:nfc_sic/src/nfc.dart'
  show channel;

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((call) async {
      switch (call.method) {
        case 'transceive':
          // debugPrint("transceive: ${call.arguments}");
          return Uint8List.fromList([ 0x1A, 0x1A ]);

        default:
          throw Exception(
            "Not implemented: ${call.method}");
      }
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  group('SIC4341 NFC checking set values', () {
    test('UID', () {
      final _uid = Uint8List.fromList([
        0x39, 0x48, 0xFF, 0xFF,
        0xFF, 0x00, 0x00,
      ]);

      Sic4341.instance.setUid(_uid);

      expect(
        Sic4341.instance.uid,
        _uid);

      expect(
        Sic4341.instance.checkedUid(),
        true);
    });

    test('auto disconnect', () {
      const _autoDisconnect = false;
      Sic4341.instance.autoDisconnect = _autoDisconnect;

      expect(
        Sic4341.instance.autoDisconnect,
        _autoDisconnect);
    });

    test('timeouts', () async {
      const _timeout = 100;
      Sic4341.instance.timeout = _timeout;

      expect(
        Sic4341.instance.timeout,
        _timeout);
    });

    test('transceive', () async {
      final _transceive =  await Sic4341.instance.transceive(
        data: Uint8List.fromList([ 0xFF, 0xFF ]));

      expect(
        _transceive,
        [ 0x1A, 0x1A ]);

      expect(
        Sic4341.instance.isSendCompleted(),
        true);
    });
  });
}