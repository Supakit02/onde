part of nfc_sic.utils;

/// Mode enumeration for checking selection process communication on NFC tag.
///  * Chronoamperometry `[CHRONOAMPEROMETRY_MODE]`
///  * Multi-Chronoamperometry `[MULTI_CHRONOAMPEROMETRY_MODE]`
///  * Cyclic Voltammetry `[CYCLIC_VOLTAMMETRY_MODE]`
///  * Linear Sweep Voltammetry `[LINEAR_SWEEP_VOLTAMMETRY_MODE]`
///  * Differential Pulse Voltammetry `[DIFFERENTIAL_PULSE_VOLTAMMETRY_MODE]`
///  * Square Wave Voltammetry `[SQUARE_WAVE_VOLTAMMETRY_MODE]`
enum Mode {
  /// Chronoamperometry Mode
  CHRONOAMPEROMETRY_MODE,

  /// Multi-Chronoamperometry Mode
  MULTI_CHRONOAMPEROMETRY_MODE,

  /// Cyclic Voltammetry Mode
  CYCLIC_VOLTAMMETRY_MODE,

  /// Linear Sweep Voltammetry Mode
  LINEAR_SWEEP_VOLTAMMETRY_MODE,

  /// Differential Pulse Voltammetry Mode
  DIFFERENTIAL_PULSE_VOLTAMMETRY_MODE,

  /// Square Wave Voltammetry Mode
  SQUARE_WAVE_VOLTAMMETRY_MODE,
}

extension ModeDescription on Mode {
  String get text {
    switch (this) {
      case Mode.CHRONOAMPEROMETRY_MODE:
        return "chronoamperometry";

      case Mode.MULTI_CHRONOAMPEROMETRY_MODE:
        return "multi-chronoamperometry";

      case Mode.CYCLIC_VOLTAMMETRY_MODE:
        return "cyclic-voltammetry";

      case Mode.LINEAR_SWEEP_VOLTAMMETRY_MODE:
        return "linear-sweep-voltammetry";

      case Mode.DIFFERENTIAL_PULSE_VOLTAMMETRY_MODE:
        return "differential-pulse-voltammetry";

      case Mode.SQUARE_WAVE_VOLTAMMETRY_MODE:
        return "square-wave-voltammetry";

      default:
        throw NoCaseError(
          value: this,
          type: runtimeType,
          method: "getText",
          message: "Unexpected mode value",
        );
    }
  }

  String get shortText {
    switch (this) {
      case Mode.CHRONOAMPEROMETRY_MODE:
        return "cam";

      case Mode.MULTI_CHRONOAMPEROMETRY_MODE:
        return "mca";

      case Mode.CYCLIC_VOLTAMMETRY_MODE:
        return "cv";

      case Mode.LINEAR_SWEEP_VOLTAMMETRY_MODE:
        return "lsv";

      case Mode.DIFFERENTIAL_PULSE_VOLTAMMETRY_MODE:
        return "dpv";

      case Mode.SQUARE_WAVE_VOLTAMMETRY_MODE:
        return "swv";

      default:
        throw NoCaseError(
          value: this,
          type: runtimeType,
          method: "getShortText",
          message: "Unexpected mode value",
        );
    }
  }
}

extension ModeCompare on Mode {
  bool get isAmpero =>
      (isChrono || isMultiChrono);
  bool get isVoltam =>
      (isCyclic || isLinearSweep || isDifferentialPulse || isSquareWave);

  bool get isChrono =>
      (this == Mode.CHRONOAMPEROMETRY_MODE);
  bool get isMultiChrono =>
      (this == Mode.MULTI_CHRONOAMPEROMETRY_MODE);
  bool get isCyclic =>
      (this == Mode.CYCLIC_VOLTAMMETRY_MODE);
  bool get isLinearSweep =>
      (this == Mode.LINEAR_SWEEP_VOLTAMMETRY_MODE);
  bool get isDifferentialPulse =>
      (this == Mode.DIFFERENTIAL_PULSE_VOLTAMMETRY_MODE);
  bool get isSquareWave =>
      (this == Mode.SQUARE_WAVE_VOLTAMMETRY_MODE);

  bool get isNotChrono =>
      (this != Mode.CHRONOAMPEROMETRY_MODE);
  bool get isNotMultiChrono =>
      (this != Mode.MULTI_CHRONOAMPEROMETRY_MODE);
  bool get isNotCyclic =>
      (this == Mode.CYCLIC_VOLTAMMETRY_MODE);
  bool get isNotLinearSweep =>
      (this != Mode.LINEAR_SWEEP_VOLTAMMETRY_MODE);
  bool get isNotDifferentialPulse =>
      (this != Mode.DIFFERENTIAL_PULSE_VOLTAMMETRY_MODE);
  bool get isNotSquareWave =>
      (this != Mode.SQUARE_WAVE_VOLTAMMETRY_MODE);
}