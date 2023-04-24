library nfc_sic.chip;

import 'dart:typed_data'
  show Uint8List;

import 'package:flutter/foundation.dart'
  show mustCallSuper;

import '../nfc.dart';
import '../providers/providers.dart'
  show RegisterProvider;

import 'sic4341.dart'
  show Flag;

abstract class SicChip extends NFC {
  SicChip()
    : _autoDisconnect = true,
      _response = Flag.NULL,
      super();

  static const int SIC43XX_UID_0 = 0x39;

  bool _autoDisconnect;
  int _response;

  @mustCallSuper
  bool checkedUid() =>
    !((uid == null) ||
      (uid.length < 4)) &&
      (uid[0] == SIC43XX_UID_0);

  /// Register
  RegisterProvider getRegister() =>
    throw UnimplementedError(
      'getRegister() has not been implemented.');

  int get response => _response;
  bool get autoDisconnect => _autoDisconnect;

  set autoDisconnect(bool value) {
    _autoDisconnect = value ?? true;
  }

  /// `NFC` transceive function connects and closes
  /// `NFC` software service automatically.
  ///
  ///     [@param] send_data  raw data sent from device.
  ///     [return] data       received from [NFC].
  ///
  Future<List<int>> autoTransceive(Uint8List data) async {
    final _recv = await transceive(
      data: data,
      disconnect: autoDisconnect);

    if ( (_recv != null) && (_recv.isNotEmpty) ) {
      _response = _recv[0];
    } else {
      _response = Flag.NULL;
    }

    return _recv;
  }

  /// `NFC` transceive function connects and closes
  /// `NFC` software service automatically.
  ///
  ///     [@param] send_data  list raw data sent from device.
  ///     [return] data       received from [NFC].
  ///
  Future<List<int>> autoTransceives(List<Uint8List> data) async {
    final _recv = await transceives(
      data: data,
      disconnect: autoDisconnect);

    if ( (_recv != null) && (_recv.isNotEmpty) ) {
      _response = _recv[0];
    } else {
      _response = Flag.NULL;
    }

    return _recv;
  }
}