library nfc_sic.nfc;

import 'dart:typed_data'
  show
    Int8List,
    Uint8List;

import 'package:flutter/services.dart'
  show
    MethodCall,
    MethodChannel,
    PlatformException;
import 'package:flutter/foundation.dart'
  show
    required,
    // debugPrint,
    mustCallSuper;

import 'chip/sic4341.dart'
  show Sic4341;
import 'utils/utils.dart';

part 'nfc_session.dart';

const MethodChannel channel = MethodChannel("plugin.sic.co.th/nfc_sic");

/// Plugin for managing NFC communication (`transceive`).
///
/// This class call function others via instance class only.
///
/// ### Example
///
/// {@tool snippet}
/// ```dart
/// NFC.instance.transceive(
///   disconnect: true,
///   data: Uint8List.fromList([ 0xFF ]),
/// );
/// ```
/// {@end-tool}
class NFC {
  NFC()
    : _tagStatus = TagStatus.DISAPPEAR,
      _timeout = 0;

  static NFC _instance;

  /// Singleton instance of NFC.
  // ignore: prefer_constructors_over_static_methods
  static NFC get instance => _instance ??= NFC();

  static _NfcSession _session;

  /// Singleton instance of NfcSession.
  static _NfcSession get session =>
      _session ??= _NfcSession._();

  Uint8List _uid;
  TagStatus _tagStatus;
  int _timeout;

  /// Get status communication tag transceive.
  TagStatus get status => _tagStatus;

  /// Get uid with NFC tag.
  Uint8List get uid => _uid;

  // ignore: use_setters_to_change_properties
  @mustCallSuper
  void setUid(Uint8List newUid) {
    _uid = newUid;
  }

  /// Gets the `NFC` timeout in milliseconds.
  ///
  ///     [return] integer, timeout value in milliseconds
  ///
  int get timeout => _timeout ?? 0;

  /// Sets the NFC timeout in milliseconds.
  ///
  ///     [@param] timeout timeout value in milliseconds
  ///
  set timeout(int timeout) {
    _timeout = timeout ?? 0;
  }

  /// `NFC` transceive function connects and closes `NFC` software service.
  ///
  ///     [@param] disconnect  auto disconnection.
  ///     [@param] data        raw data sent from device.
  ///     [return] data received from [NFC].
  ///
  Future<List<int>> transceive({
    @required Uint8List data,
    bool disconnect = true,
  }) async {
    assert(
      data != null && data.isNotEmpty,
      'data cannot be null and empty');

    try {
      // debugPrint("send: $data");

      final _recv = Int8List.fromList(
        await channel.invokeMethod(
          "transceive", {
            'data': data ?? <int>[],
            'disconnect': disconnect ?? true,
            'timeout': timeout,
          }));

      // debugPrint("recv: $_recv");

      _tagStatus = TagStatus.EXCHANGE;

      return _recv.toList();
    } catch (error, stackTrace) {
      if ( error == null ) {
        _tagStatus = TagStatus.DISAPPEAR;
      } else {
        _tagStatus = TagStatus.RESP_FAIL;
      }

      throw PlatformException(
        code: "transceive",
        message: "NFC features are not communication NFC tag",
        details: error,
        stacktrace: stackTrace?.toString()
          ?? StackTrace.current.toString());
    }
  }

  /// `NFC` transceive function connects and closes `NFC` software service.
  ///
  ///     [@param] disconnect   auto disconnection.
  ///     [@param] data         list raw data sent from device.
  ///     [return] data received from [NFC].
  ///
  Future<List<int>> transceives({
    @required List<Uint8List> data,
    bool disconnect = true,
  }) async {
    assert(
      data != null && data.isNotEmpty,
      'data cannot be null and empty');

    try {
      final _recv = Int8List.fromList(
        await channel.invokeMethod(
          "transceives", {
            'data': data ?? <Uint8List>[],
            'disconnect': disconnect ?? true,
            'timeout': timeout,
          }));

      _tagStatus = TagStatus.EXCHANGE;

      return _recv.toList();
    } catch (error, stackTrace) {
      if ( error == null ) {
        _tagStatus = TagStatus.DISAPPEAR;
      } else {
        _tagStatus = TagStatus.RESP_FAIL;
      }

      throw PlatformException(
        code: "transceives",
        message: "NFC features are not communication NFC tag",
        details: error,
        stacktrace: stackTrace?.toString()
          ?? StackTrace.current.toString());
    }
  }

  /// NFC send completed function NFC software service.
  ///
  ///     [return] true: if status send exchange.
  ///
  bool isSendCompleted() =>
      status?.isExchange ?? false;
}