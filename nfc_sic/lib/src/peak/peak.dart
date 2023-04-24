library nfc_sic.peak;

import 'package:flutter/foundation.dart' show required;
import 'package:nfc_sic/nfc_sic.dart';
import 'package:nfc_sic/src/preferences/preferences.dart';
import 'package:nfc_sic/src/utils/utils.dart';
// debugPrint;

import '../models/models.dart' show Result;
import '../utils/utils.dart' show OthersException;

part 'substance.dart';
part 'heavy_metals.dart';
part 'pesticides.dart';
part 'filter.dart';

class Peak {
  Peak({
    @required List<Result> data,
  })  : assert(data != null, ''),
        _data = data.map((res) => _PeakData(res.voltage, res.current)).toList();

  final List<_PeakData> _data;

  Future<double> findCurrent({HeavyMetal type}) async {
    final _tempL = _data.where((d) => type.checkLower(d.x)).toList();
    final _tempH = _data.where((d) => type.checkUpper(d.x)).toList();

    _tempL.sort((a, b) => a.y.compareTo(b.y));
    _tempH.sort((a, b) => a.y.compareTo(b.y));

    // debugPrint("tempL: $_tempL");
    // debugPrint("tempH: $_tempH");

    final _l = _tempL.first;
    final _h = _tempH.first;

    // debugPrint("l: $_l");
    // debugPrint("h: $_h");

    final _m = (_h.y - _l.y) / (_h.x - _l.x);
    final _c = _h.y - _m * _h.x;

    // debugPrint("c: $_c");
    // debugPrint("m: $_m");

    for (final d in _data) {
      d.yh = _m * d.x + _c;
    }

    final _temp = _data.where((d) => type.check(d.x)).toList()
      ..sort((a, b) => b.y.compareTo(a.y));

    return _temp.first.dI;
  }

  Future<double> findConcentration({
    double y = 0.0,
    double m,
    double c,
    String s,
  }) async {
    // switch (s) {
    //   case "Chromium (Cr (VI))":
    //   case "Cadmium (Cd)":
    //   case "Lead (Pb)":
    //     return ((y - c) / m) * 2;

    //   default:
    //     return (y - c) / m;
    // }

    if ((y == null) || (m == null) || (m == 0.0) || (c == null)) {
      return null;
    }

    return ((y - c) / m) * 2;
  }

  @override
  String toString() => '[Peak] data:\n${_data.join('\n')}';
}

class _PeakData {
  _PeakData(this._x, this._y);

  final int _x;
  final double _y;

  double _yh = 0;

  int get x => _x;

  double get y => _y;
  double get yh => _yh;

  double get dI => _y - _yh;

  set yh(double value) {
    _yh = value ?? 0.0;
  }

  @override
  String toString() => 'x: $_x, y: $_y, yh: $_yh';
}
