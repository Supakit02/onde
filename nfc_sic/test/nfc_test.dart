import 'dart:typed_data'
  show Uint8List;

// import 'package:flutter/foundation.dart'
//   show debugPrint;

import 'package:flutter_test/flutter_test.dart';

import 'package:nfc_sic/nfc_sic.dart';
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

        case 'timeout#GET':
          return 123;

        case 'timeout#SET':
          // debugPrint("timeout: ${call.arguments}");
          return null;

        default:
          throw Exception(
            "Not implemented: ${call.method}");
      }
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  group('NFC checking set values', () {
    test('timeout', () async {
      const _timeout = 100;
      NFC.instance.timeout = _timeout;

      expect(
        NFC.instance.timeout,
        _timeout);
    });

    test('transceive', () async {
      final _transceive =  await NFC.instance.transceive(
        data: Uint8List.fromList([ 0xFF, 0xFF ]));

      expect(
        _transceive,
        [ 0x1A, 0x1A ]);

      expect(
        NFC.instance.isSendCompleted(),
        true);
    });
  });
}