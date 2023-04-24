library nfc_sic.managers;

import 'dart:convert'
  show json;
import 'dart:io'
  show File;
import 'dart:math' as math;
import 'dart:typed_data'
  show Uint8List;

// import 'package:flutter/foundation.dart'
//   show debugPrint;

import 'package:convert/convert.dart'
  show hex;
import 'package:path_provider/path_provider.dart'
  show getApplicationSupportDirectory;

import '../chip/sic4341.dart'
  show Sic4341;
import '../models/models.dart';
import '../peak/peak.dart';
import '../preferences/preferences.dart'
  show Preference;
import '../utils/utils.dart';

part 'calibration.dart';
part 'characteristic.dart';
part 'iodata.dart';
part 'result.dart';
part 'setting.dart';

class Manager {
  Manager._();

  static SettingManager _setting;

  /// Singleton instance of SettingManager.
  static SettingManager get setting =>
      _setting ??= SettingManager._();

  static CalibrationManager _calibration;

  /// Singleton instance of CalibrationManager.
  static CalibrationManager get calibration =>
      _calibration ??= CalibrationManager._();

  static CharacteristicManager _characteristic;

  /// Singleton instance of CharacteristicManager.
  static CharacteristicManager get characteristic =>
      _characteristic ??= CharacteristicManager._();

  static ResultManager _result;

  /// Singleton instance of ResultManager.
  static ResultManager get result =>
      _result ??= ResultManager._();
}

class _Matrix {
  _Matrix._(int row, int col)
    : _row = row,
      _column = col,
      _elements = List<double>(row * col);

  factory _Matrix.empty() =>
      _Matrix._(0, 0);

  factory _Matrix.xy(Map<double, double> xy) {
    // String _val = xy.entries.map(
    //   (val) => "x: ${val.key}, y: ${val.value}").join("\n");

    // debugPrint("value:\n$_val\n");

    final _matrix = _Matrix._(xy.length - 1, xy.length);

    for ( var i = 0 ; i < _matrix.row ; i++ ) {
      for ( var j = 0 ; j < _matrix.column ; j++ ) {
        var _sum = 0.0;

        if ( (i == 0) && (j == 0) ) {
          _matrix.setData(
            i, j, xy.length.toDouble());
          continue;
        }

        if ( j == (xy.length - 1) ) {
          xy.forEach(
            (x, y) => _sum += math.pow(x, i) * y);

          _matrix.setData(
            i, j, _sum);
          continue;
        }

        // xy.keys.forEach(
        //   (x) => _sum += math.pow(x, i + j));

        for ( final _x in xy.keys ) {
          _sum += math.pow(_x, i + j);
        }

        _matrix.setData(
          i, j, _sum);
        continue;
      }
    }

    return _matrix;
  }

  final int _row;
  final int _column;
  final List<double> _elements;

  int get row => _row;
  int get column => _column;

  List<double> get elements => _elements;

  double getData(int r, int c) =>
      _elements[r * _column + c];

  void setData(int r, int c, double value) {
    _elements[r * _column + c] = value;
  }

  List<double> getRow(int r) {
    final _rowData = List<double>(_column);

    for ( var i = 0 ; i < _column ; i++ ) {
      _rowData[i] = getData(r, i);
    }

    return _rowData;
  }

  List<double> getColumn(int c) {
    final _colData = List<double>(_row);

    for ( var i = 0 ; i < _row ; i++ ) {
      _colData[i] = getData(i, c);
    }

    return _colData;
  }

  List<double> getPolynomialFit() {
    final _coef = List<double>(_row);
    final _gauss = List<List<double>>.generate(
      _row,
      (r) => List<double>.generate(
        _column,
        (c) => getData(r, c)));

    for ( var j = 0 ; j < _row ; j++ ) {
      for ( var i = 0 ; i < _row ; i++ ) {
        if ( i > j ) {
          final _c = _gauss[i][j] / _gauss[j][j];

          for ( var k = 0 ; k <= _row ; k++ ) {
            _gauss[i][k] = _gauss[i][k] - _c * _gauss[j][k];
          }
        }
      }
    }

    _coef[_row - 1] = _gauss[_row - 1][_row] / _gauss[_row - 1][_row - 1];

    for ( var i = _row - 2 ; i >= 0 ; i-- ) {
      var _sum = 0.0;

      for ( var j = i + 1 ; j < _row ; j++ ) {
        _sum += _gauss[i][j] * _coef[j];
      }

      _coef[i] = (_gauss[i][_row] - _sum) / _gauss[i][i];
    }

    return _coef;
  }

  @override
  String toString() {
    final _string = StringBuffer(
      "Matrix[$_row x $_column]:");

    for ( var i = 0 ; i < _row ; i++ ) {
      _string.write("\n\t");

      for ( var j = 0 ; j < _column ; j++ ) {
        _string.write(
          getData(i, j).toStringAsExponential(10));

        if ( j < (_column - 1) ) {
          _string.write(", ");
        }
      }
    }

    return _string.toString();
  }
}