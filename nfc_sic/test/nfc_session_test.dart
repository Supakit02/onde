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
        case 'isAvailable':
          return true;

        case 'startSession':
          // debugPrint("startSession: ${call.arguments}");
          return null;

        case 'stopSession':
          // debugPrint("stopSession: ${call.arguments}");
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

  group('Session method check', () {
    test('NFC available', () async {
      expect(
        await NFC.session.isAvailable(),
        true);
    });

    test('NFC open session', () async {
      await NFC.session.startSession();
    });

    test('NFC close session', () async {
      await NFC.session.stopSession();
    });
  });
}