part of nfc_sic.peak;

class Filter {
  Filter._();

  static Future<List<Result>> process({
    List<Result> data,
    FilterOption option,
  }) async {
    // debugPrint("option: ${option.text}, value: $value");

    assert(option != null, 'option cannot be null');
    assert(
        (data != null) && (data.isNotEmpty), 'data cannot be null and empty');

    var _result = <Result>[];
    var _first = data.first;
    _first = _first.copyWith(
      filter: _first.current,
    );
    var _data = List.generate(
      3,
      (i) => _first,
    );

    _result.addAll(_data);
    _data.addAll(data);

    // debugPrint("result: $_result");
    // debugPrint("data: $_data");

    var _length = _data.length;

    for (var i = 3; i < _length; i++) {
      var _res = await _calculate(x: <double>[
        _data[i].current,
        _data[i - 1].current,
        _data[i - 2].current,
        _data[i - 3].current,
      ], y: <double>[
        _result[i - 1].filter,
        _result[i - 2].filter,
        _result[i - 3].filter,
      ], option: option, order: 3);

      // debugPrint("res: $_res");

      _result.add(_data[i].copyWith(
        filter: _res,
      ));
    }

    // debugPrint("result: $_result");

    return _result.sublist(3);
  }

  static Future<double> _calculate({
    List<double> x,
    List<double> y,
    FilterOption option,
    int order = 3,
  }) async {
    assert(option != null, 'option cannot be null');

    assert((x != null) && (y != null), 'x and y cannot be null');

    assert((x.length == (order + 1)) && (y.length == order),
        'x and y have data length incorrect');

    var _result = 0.0;

    var _a = option.a;
    var _b = option.b;
    var _g = option.G;

    var _x = _b.first * x.first;
    var _y = 0.0;

    for (var i = 1; i < order; i++) {
      _x += _b[i] * x[i];
      _y += _a[i] * y[i - 1];
    }

    _result = _g * _x - _y;

    return _result;
  }
}

/// Filter options.
///  * 50 % `[BW_50]`
///  * 20 % `[BW_20]`
///  * 10 % `[BW_10]`
///  * 5 % `[BW_5]`
///  * 2 % `[BW_2]`
///  * 1 % `[BW_1]`
enum FilterOption {
  BW_50,
  BW_20,
  BW_10,
  BW_5,
  BW_2,
  BW_1,
}

extension FilterOptionValue on FilterOption {
  String get text {
    switch (this) {
      case FilterOption.BW_50:
        return '50';

      case FilterOption.BW_20:
        return '20';

      case FilterOption.BW_10:
        return '10';

      case FilterOption.BW_5:
        return '5';

      case FilterOption.BW_2:
        return '2';

      case FilterOption.BW_1:
        return '1';

      default:
        throw NoCaseError(
          value: this,
          type: runtimeType,
          method: "getText",
          message: "Unexpected filter value",
        );
    }
  }

  List<double> get a {
    switch (this) {
      case FilterOption.BW_50:
        return <double>[1.0, 0.0, 0.171570, 0.0];

      case FilterOption.BW_20:
        return <double>[1.0, -1.142980, 0.412800, 0.0];

      case FilterOption.BW_10:
        return <double>[1.0, -1.561020, 0.641350, 0.0];

      case FilterOption.BW_5:
        return <double>[1.0, -1.778630, 0.800800, 0.0];

      case FilterOption.BW_2:
        return <double>[1.0, -1.911200, 0.914980, 0.0];

      case FilterOption.BW_1:
        return <double>[1.0, -1.955580, 0.956540, 0.0];

      default:
        throw NoCaseError(
          value: this,
          type: runtimeType,
          method: "get a",
          message: "Unexpected filter value",
        );
    }
  }

  List<double> get b => <double>[1.0, 2.0, 1.0, 0.0];

  double get G {
    switch (this) {
      case FilterOption.BW_50:
        return 0.29289250;

      case FilterOption.BW_20:
        return 0.06745500;

      case FilterOption.BW_10:
        return 0.02008250;

      case FilterOption.BW_5:
        return 0.00554250;

      case FilterOption.BW_2:
        return 0.00094500;

      case FilterOption.BW_1:
        return 0.00024000;

      default:
        throw NoCaseError(
          value: this,
          type: runtimeType,
          method: "get G",
          message: "Unexpected filter value",
        );
    }
  }
}

extension ModeFilterOption on Mode {
  FilterOption get defaultFilter {
    switch (this) {
      case Mode.CHRONOAMPEROMETRY_MODE:
      case Mode.MULTI_CHRONOAMPEROMETRY_MODE:
        return FilterOption.BW_1;

      case Mode.CYCLIC_VOLTAMMETRY_MODE:
      case Mode.LINEAR_SWEEP_VOLTAMMETRY_MODE:
      case Mode.DIFFERENTIAL_PULSE_VOLTAMMETRY_MODE:
      case Mode.SQUARE_WAVE_VOLTAMMETRY_MODE:
        return FilterOption.BW_10;

      default:
        return null;
    }
  }

  List<FilterOption> get filter {
    switch (this) {
      case Mode.CHRONOAMPEROMETRY_MODE:
      case Mode.MULTI_CHRONOAMPEROMETRY_MODE:
        return <FilterOption>[
          FilterOption.BW_5,
          FilterOption.BW_2,
          FilterOption.BW_1,
        ];

      case Mode.CYCLIC_VOLTAMMETRY_MODE:
      case Mode.LINEAR_SWEEP_VOLTAMMETRY_MODE:
      case Mode.DIFFERENTIAL_PULSE_VOLTAMMETRY_MODE:
      case Mode.SQUARE_WAVE_VOLTAMMETRY_MODE:
        return <FilterOption>[
          FilterOption.BW_50,
          FilterOption.BW_20,
          FilterOption.BW_10,
        ];

      default:
        throw NoCaseError(
          value: this,
          type: runtimeType,
          method: "getFilterOption",
          message: "Unexpected mode value",
        );
    }
  }
}

extension FilterOptionCompare on FilterOption {
  bool get is50percent => this == FilterOption.BW_50;
  bool get is20percent => this == FilterOption.BW_20;
  bool get is10percent => this == FilterOption.BW_10;
  bool get is5percent => this == FilterOption.BW_5;
  bool get is2percent => this == FilterOption.BW_2;
  bool get is1percent => this == FilterOption.BW_1;

  bool get isNot50percent => this != FilterOption.BW_50;
  bool get isNot20percent => this != FilterOption.BW_20;
  bool get isNot10percent => this != FilterOption.BW_10;
  bool get isNot5percent => this != FilterOption.BW_5;
  bool get isNot2percent => this != FilterOption.BW_2;
  bool get isNot1percent => this != FilterOption.BW_1;
}
