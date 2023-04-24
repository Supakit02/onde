part of service.provider;

class SettingConstantLinear extends GetxController {
  String _vegatable = "";

  double _inhibition = 0.0;
  double _concentration = 0.0;

  String get vegatable => _vegatable;

  double get concentration => _concentration;
  double get inhibition => _inhibition;

  void setVegetableName(String name) {
    _vegatable = name;
    update();
  }

  void setInhibition(double value) {
    _inhibition = value;
    update();
  }

  void setconcentration(double value) {
    _concentration = value;
    update();
  }

  Future<double> get calConcentration async {
    await setConstantLinearEnzyme();
    _concentration = (_inhibition - _c) / _m;
    return _concentration;
  }

  // Constant Linear Equation
  double _m = 0.0;
  double _c = 0.0;

  double get m => _m;
  double get c => _c;

  void setConstantM(double m) {
    _m = m;
    update();
  }

  void setConstantC(double c) {
    _c = c;
    update();
  }

  Future<void> setConstantLinearEnzyme() async {
    switch (_vegatable) {
      case "Broccoli":
        checkLowConcentration(
            lowConcentrationM: 69.163,
            lowConcentrationC: 5.8109,
            highConcentrationM: 9.9566,
            highConcentrationC: 15.722);
        break;
      case "Celery":
        checkLowConcentration(
            lowConcentrationM: 51.286,
            lowConcentrationC: 6.4917,
            highConcentrationM: 9.2571,
            highConcentrationC: 25.217);
        break;
      case "Chinese Kale":
        checkLowConcentration(
            lowConcentrationM: 85.102,
            lowConcentrationC: 1.5802,
            highConcentrationM: 10.024,
            highConcentrationC: 9.8397);
        break;
      case "Water Spinach":
        checkLowConcentration(
            lowConcentrationM: 42.953,
            lowConcentrationC: 4.2972,
            highConcentrationM: 10.169,
            highConcentrationC: 13.17);
        break;
      case "Carrot":
        checkLowConcentration(
            lowConcentrationM: 55.023,
            lowConcentrationC: 4.1253,
            highConcentrationM: 9.8706,
            highConcentrationC: 9.9602);
        break;
      case "Cherry Tomato":
        checkLowConcentration(
            lowConcentrationM: 83.224,
            lowConcentrationC: 2.991,
            highConcentrationM: 9.8186,
            highConcentrationC: 9.4115);
        break;
      case "Brid Chili":
        checkLowConcentration(
            lowConcentrationM: 125.18,
            lowConcentrationC: 23.639,
            highConcentrationM: 8.8197,
            highConcentrationC: 35.269);
        break;
      case "Yardlong Bean":
        checkLowConcentration(
            lowConcentrationM: 44.401,
            lowConcentrationC: 3.9817,
            highConcentrationM: 12.775,
            highConcentrationC: 8.4467);
        break;
      case "Holy Basil":
        checkLowConcentration(
            lowConcentrationM: 69.146,
            lowConcentrationC: 10.786,
            highConcentrationM: 9.5584,
            highConcentrationC: 41.302);
        break;
      case "Gourd":
        checkLowConcentration(
            lowConcentrationM: 94.123,
            lowConcentrationC: 3.5572,
            highConcentrationM: 10.691,
            highConcentrationC: 11.867);
        break;
      case "Radish":
        checkLowConcentration(
            lowConcentrationM: 34.313,
            lowConcentrationC: 4.6283,
            highConcentrationM: 11.468,
            highConcentrationC: 5.9894);
        break;

      default:
        _m = 0.0;
        _c = 0.0;
        break;
    }
  }

  void setConstantLinear(
      {required String vegatableName, required Substance substance}) {
    if (substance == Substance.CYPERMETHRIN) {
      switch (vegatableName) {
        case "Broccoli":
          _m = -2.07;
          _c = 4.62;
          break;
        case "Celery":
          _m = -3.50;
          _c = 7.02;
          break;
        case "Chinese Kale":
          _m = -12.72;
          _c = 25.65;
          break;
        case "Water Spinach":
          _m = -7.04;
          _c = 14.37;
          break;
        case "Carrot":
          _m = -2.02;
          _c = 4.80;
          break;
        case "Cherry Tomato":
          _m = -1.96;
          _c = 4.07;
          break;
        case "Brid Chili":
          _m = -8.62;
          _c = 18.67;
          break;
        case "Red Pepper":
          _m = -8.81;
          _c = 18.95;
          break;
        case "Yardlong Bean":
          _m = -11.57;
          _c = 24.59;
          break;
        case "Holy Basil":
          _m = -2.30;
          _c = 6.22;
          break;
        case "Gourd":
          _m = -2.04;
          _c = 5.60;
          break;
        case "Radish":
          _m = -2.88;
          _c = 5.89;
          break;

        default:
          _m = 0.0;
          _c = 0.0;
          break;
      }
    } else {
      switch (vegatableName) {
        case "Broccoli":
          _m = -2.25;
          _c = 10.22;
          break;
        case "Celery":
          _m = -2.04;
          _c = 8.724;
          break;
        case "Chinese Kale":
          _m = -6.28;
          _c = 25.79;
          break;
        case "Water Spinach":
          _m = -1.73;
          _c = 7.073;
          break;
        case "Carrot":
          _m = -2.71;
          _c = 13.80;
          break;
        case "Cherry Tomato":
          _m = -3.22;
          _c = 12.97;
          break;
        case "Brid Chili":
          _m = -5.23;
          _c = 22.26;
          break;
        case "Red Pepper":
          _m = -5.14;
          _c = 22.66;
          break;
        case "Yardlong Bean":
          _m = -4.94;
          _c = 21.20;
          break;
        case "Holy Basil":
          _m = -1.90;
          _c = 7.715;
          break;
        case "Gourd":
          _m = -3.17;
          _c = 13.35;
          break;
        case "Radish":
          _m = -2.46;
          _c = 10.30;
          break;

        default:
          _m = 0.0;
          _c = 0.0;
          break;
      }
    }
  }

  void checkLowConcentration(
      {required double lowConcentrationM,
      required double lowConcentrationC,
      required double highConcentrationM,
      required double highConcentrationC}) {
    double dataCheck = 0.0;
    dataCheck = (lowConcentrationM * 0.1) + lowConcentrationC;
    if (_inhibition <= dataCheck) {
      _m = lowConcentrationM;
      _c = lowConcentrationC;
    } else if (_inhibition > dataCheck) {
      _m = highConcentrationM;
      _c = highConcentrationC;
    }
  }
}
