part of nfc_sic.peak;

class HeavyMetalData {
  HeavyMetalData({
    Substance substance,
    Pesticide pesticide,
    HeavyMetal heavyMetal,
  })  : _substance = substance,
        _heavyMetal = heavyMetal,
        _pesticide = pesticide,
        _current = 0.0;

  final Substance _substance;
  final HeavyMetal _heavyMetal;
  final Pesticide _pesticide;

  double _m;
  double _c;
  bool _first;
  bool _firstEnzyme;

  double _current;

  double _inhibition;
  double _interference;
  double _concentration;

  Pesticide get pesticide => _pesticide;
  HeavyMetal get type => _heavyMetal;
  String get text => _heavyMetal.text;
  String get unit => _heavyMetal.unit;

  bool get isHeavyMetal => (_heavyMetal != null) && _substance.isHeavyMetals;
  bool get isPesticides => (_pesticide != null) && _substance.isPesticides;

  // ignore: unnecessary_getters_setters
  bool get firstEnzyme => _firstEnzyme;

  // ignore: unnecessary_getters_setters
  set firstEnzyme(bool value) {
    _firstEnzyme = value;
  }

  // ignore: unnecessary_getters_setters
  bool get first => _first;

  // ignore: unnecessary_getters_setters
  set first(bool value) {
    _first = value;
  }

  // ignore: unnecessary_getters_setters
  double get m => _m;

  // ignore: unnecessary_getters_setters
  set m(double value) {
    _m = value;
  }

  // ignore: unnecessary_getters_setters
  double get c => _c;

  // ignore: unnecessary_getters_setters
  set c(double value) {
    _c = value;
  }

  double get current => _current;

  double get inhibition => _inhibition;
  double get interference => _interference;
  // ignore: unnecessary_getters_setters
  double get concentration => _concentration;

  //! Add Setter Concentration
  // ignore: unnecessary_getters_setters
  set concentration(double value) {
    _concentration = value;
  }

  Future<void> findPeak({
    Peak data,
    List<Result> result,
  }) async {
    print(_substance.isArsenic);
    print(_substance.isChromium);
    if (_substance.isHeavyMetals) {
      try {
        _current = await data.findCurrent(type: _heavyMetal);

        if (_heavyMetal.isMercury) {
          _interference = await data.findCurrent(type: HeavyMetal.Cu);
        } else {
          _interference = null;
        }

        _concentration =
            await data.findConcentration(m: _m, c: _c, y: _current, s: text);
      } catch (error, stackTrace) {
        throw OthersException(
            code: 'HeavyMetalData',
            message: 'find peak error',
            details: error,
            stackTrace: stackTrace ?? StackTrace.current);
      }
    } else {
      //! add Pesticide Cal
      try {
        var _i100 = 0.0;
        var _i280 = 0.0;
        var _i400 = 0.0;

        // todo test _i10, _i30

        var _i10 = 0.0;
        var _i30 = 0.0;

        // todo : add _i180 and _i300 for check
        var _i180 = 0.0;
        var _i300 = 0.0;

        for (var _res in result) {
          var _time = _res.tSamp / 1000.0;
          if (_time == 100.0) {
            _i100 = _res.filter;
            print("i100 => ${_res.adcOut}");
          } else if (_time == 10.0) {
            //! test
            print("i10 => ${_res.adcOut}");
            _i10 = _res.filter;
          } else if (_time == 30.0) {
            //! test
            _i30 = _res.filter;
            print("i300 => ${_res.adcOut}");
          } else if (_time == 180.0) {
            _i180 = _res.filter;
          } else if (_time == 280.0) {
            _i280 = _res.filter;
            print("i200 => ${_res.adcOut}");
          } else if (_time == 300.0) {
            _i300 = _res.filter;
          } else if (_time == 400.0) {
            _i400 = _res.filter;
            print("i400 => ${_res.adcOut}");
          }
        }

        if (_pesticide.isChlorpyrifos) {
          if (_first) {
            _current = _i100;
            // _current = _i10;
            await Preference.setting.setFirstCurrent(_current);
            _concentration = null;
          } else {
            final _firstCurrent = Preference.setting.getFirstCurrent();
            if (_firstCurrent != null) {
              _current = _i400 - _firstCurrent;
              // _current = _i30 - _firstCurrent;
              if (_firstEnzyme) {
                await Preference.setting.setPrevCurrent(_current);
              } else {
                final _prevCurrentEnzyme = Preference.setting.getPrevCurrent();
                if (_prevCurrentEnzyme != null) {
                  _inhibition =
                      ((_prevCurrentEnzyme - _current) / _prevCurrentEnzyme) *
                          100.0;
                }
              }
            }
          }
        } else {
          //! add from [OLD ONDE]
          if (_first) {
            _current = _i100;
            await Preference.setting.setFirstCurrent(_current);
            _concentration = null;
          } else {
            final _firstCurrent = Preference.setting.getFirstCurrent();
            if (_firstCurrent != null) {
              _current = _i280 -
                  _firstCurrent; // todo _i280 mean current at 180 sec (perv Result not clean if user not use Calibration)
              _concentration = (_current - _c) / _m;
            }
          }
          // _current = _i280 - _i100;
        }
      } catch (error, stackTrace) {
        throw OthersException(
            code: 'HeavyMetalData (Pesticide)',
            message: 'find peak error',
            details: error,
            stackTrace: stackTrace ?? StackTrace.current);
      }
    }
  }

  String toReportPesticide() {
    final _prevCurrent = Preference.setting.getPrevCurrent();
    String title = "";
    if (_pesticide.isCarbaryl) {
      title = "Carbaryl";
    } else if (_pesticide.isCypermethrin) {
      title = "Cypermerthrin";
    } else if (_pesticide.isChlorpyrifos) {
      title = "Chlorpyrifos";
    }
    final _report = StringBuffer("\n$title\n"
        "m : \t${_m ?? 'N/A'}\tuA/ppm\n"
        "c : \t${_c ?? 'N/A'}\tuA\n");

    if (isPesticides) {
      if (_pesticide?.isChlorpyrifos ?? false) {
        if (_prevCurrent == null) {
          _report.write("△I : \t${_current.toStringAsFixed(10)}\tuA\n");
        } else {
          _report.write(
              "△I 1 : \t${_prevCurrent?.toStringAsFixed(10) ?? 'N/A'}\tuA\n"
              "△I 2 : \t${_current.toStringAsFixed(10)}\tuA\n");
        }

        _report.write(
            "% inhibition : \t\t${_inhibition?.toStringAsFixed(10) ?? 'N/A'}\t%\n");
      } else {
        _report.write("△I : \t${_current.toStringAsFixed(10)}\tuA\n");
      }
    } else {
      _report.write("△I peak : \t\t${_current.toStringAsFixed(10)}\tuA\n");
    }

    _report.write(
        "Concentration : \t${_concentration?.toStringAsFixed(10) ?? 'N/A'}\tppm\n");

    return _report.toString();
  }

  String toReport() {
    final _report = StringBuffer("\n$text\n"
        "m : \t${m ?? 'N/A'}\tuA/$unit\n"
        "c : \t${c ?? 'N/A'}\tuA\n"
        "△I peak : \t${current.toStringAsFixed(10) ?? 'N/A'}\tuA\n");

    if (_heavyMetal.isMercury) {
      _report.write(
          "Cu △I peak : \t${interference.toStringAsFixed(10) ?? 'N/A'}\tuA\n");
    }

    _report.write(
        "Concentration : \t${concentration?.toStringAsFixed(10) ?? 'N/A'}\t$unit\n");

    return _report.toString();
  }

  @override
  String toString() => "[HeavyMetalData] m: $m, c: $c, △I peak: $current, "
      "interference: $interference, concentration: $concentration";
}

/// Heavy Metals
///  * Arsenic `[As]`
///  * Chromium `[Cr]`
///  * Copper `[Cu]`
///  * Mercury `[Hg]`
///  * Cadmium `[Cd]`
///  * Lead `[Pb]`
enum HeavyMetal {
  As,
  Cr,
  Cu,
  Hg,
  Cd,
  Pb,
}

extension HeavyMetalString on HeavyMetal {
  String get text {
    switch (this) {
      case HeavyMetal.As:
        return 'Arsenic (As (III))';

      case HeavyMetal.Cr:
        return 'Chromium (Cr (VI))';

      case HeavyMetal.Cu:
        return 'Copper (Cu)';

      case HeavyMetal.Hg:
        return 'Mercury (Hg (II))';

      case HeavyMetal.Cd:
        return 'Cadmium (Cd)​';

      case HeavyMetal.Pb:
        return 'Lead (Pb)​';

      default:
        throw UnimplementedError('Unexpected heavy metal value: $this');
    }
  }

  String get unit {
    switch (this) {
      case HeavyMetal.Cr:
      case HeavyMetal.Hg:
        return 'ppm';

      case HeavyMetal.As:
      case HeavyMetal.Cd:
      case HeavyMetal.Pb:
        return 'ppb​';

      default:
        throw UnimplementedError('Unexpected heavy metal value: $this');
    }
  }
}

extension HeavyMetalValue on HeavyMetal {
  double get m {
    switch (this) {
      case HeavyMetal.As:
        return 0.0472;

      case HeavyMetal.Cr:
        return 0.3655;

      case HeavyMetal.Hg:
        return 2.5935;

      case HeavyMetal.Cd:
        return 0.0300;

      case HeavyMetal.Pb:
        return 0.0443;

      default:
        throw UnimplementedError('Unexpected heavy metal value: $this');
    }
  }

  double get c {
    switch (this) {
      case HeavyMetal.As:
        return 0.1744;

      case HeavyMetal.Cr:
        return 0.3097;

      case HeavyMetal.Hg:
        return 1.4927;

      case HeavyMetal.Cd:
        return 8.2224;

      case HeavyMetal.Pb:
        return 1.8772;

      default:
        throw UnimplementedError('Unexpected heavy metal value: $this');
    }
  }
}

extension HeavyMetalCheckValue on HeavyMetal {
  bool checkLower(int value) {
    switch (this) {
      case HeavyMetal.As:
        if (value >= -200) {
          if (value <= -100) {
            return true;
          }
        }
        break;

      case HeavyMetal.Cr:
        if (value >= 0) {
          if (value <= 200) {
            return true;
          }
        }
        break;

      case HeavyMetal.Cu:
        if (value >= -500) {
          if (value <= -400) {
            return true;
          }
        }
        break;

      case HeavyMetal.Hg:
        if (value >= -250) {
          if (value <= -100) {
            return true;
          }
        }
        break;

      case HeavyMetal.Cd:
        if (value >= -1000) {
          if (value <= -960) {
            return true;
          }
        }
        break;

      case HeavyMetal.Pb:
        if (value >= -800) {
          if (value <= -700) {
            return true;
          }
        }
        break;

      default:
        throw UnimplementedError('Unexpected heavy metal value: $this');
    }

    return false;
  }

  bool checkUpper(int value) {
    switch (this) {
      case HeavyMetal.As:
        if (value >= 140) {
          if (value <= 300) {
            return true;
          }
        }
        break;

      case HeavyMetal.Cr:
        if (value > 400) {
          if (value < 600) {
            return true;
          }
        }
        break;

      case HeavyMetal.Cu:
        if (value >= -300) {
          if (value <= -180) {
            return true;
          }
        }
        break;

      case HeavyMetal.Hg:
        if (value >= 100) {
          if (value <= 250) {
            return true;
          }
        }
        break;

      case HeavyMetal.Cd:
        if (value >= -800) {
          if (value <= -700) {
            return true;
          }
        }
        break;

      case HeavyMetal.Pb:
        if (value >= -600) {
          if (value <= -450) {
            return true;
          }
        }
        break;

      default:
        throw UnimplementedError('Unexpected heavy metal value: $this');
    }

    return false;
  }

  bool check(int value) {
    switch (this) {
      case HeavyMetal.As:
        if (value > -200) {
          if (value < 200) {
            return true;
          }
        }
        break;

      case HeavyMetal.Cr:
        if (value > 0) {
          if (value < 350) {
            return true;
          }
        }
        break;

      case HeavyMetal.Cu:
        if (value > -500) {
          if (value < -200) {
            return true;
          }
        }
        break;

      case HeavyMetal.Hg:
        if (value > -100) {
          if (value < 100) {
            return true;
          }
        }
        break;

      case HeavyMetal.Cd:
        if (value >= -960) {
          if (value <= -800) {
            return true;
          }
        }
        break;

      case HeavyMetal.Pb:
        if (value >= -700) {
          if (value <= -600) {
            return true;
          }
        }
        break;

      default:
        throw UnimplementedError('Unexpected heavy metal value: $this');
    }

    return false;
  }
}

extension HeavyMetalCompare on HeavyMetal {
  bool get isArsenic => this == HeavyMetal.As;
  bool get isChromium => this == HeavyMetal.Cr;
  bool get isCopper => this == HeavyMetal.Cu;
  bool get isMercury => this == HeavyMetal.Hg;
  bool get isCadmium => this == HeavyMetal.Cd;
  bool get isLead => this == HeavyMetal.Pb;

  bool get isNotArsenic => this != HeavyMetal.As;
  bool get isNotChromium => this != HeavyMetal.Cr;
  bool get isNotCopper => this != HeavyMetal.Cu;
  bool get isNotMercury => this != HeavyMetal.Hg;
  bool get isNotCadmium => this != HeavyMetal.Cd;
  bool get isNotLead => this != HeavyMetal.Pb;
}
