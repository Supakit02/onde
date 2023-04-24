part of utils;

extension Uint8ListExtension on Uint8List {
  String toHexString() => hex.encode(toList()).toUpperCase();
}

// extension ModeExtension on Mode {
//   String get display {
//     switch (this) {
//       case Mode.CHRONOAMPEROMETRY_MODE:
//         return 'Chronoamperometry';

//       case Mode.MULTI_CHRONOAMPEROMETRY_MODE:
//         return 'Multi-Chronoamperometry';

//       case Mode.CYCLIC_VOLTAMMETRY_MODE:
//         return 'Cyclic Voltammetry';

//       case Mode.LINEAR_SWEEP_VOLTAMMETRY_MODE:
//         return 'Linear Sweep Voltammetry';

//       case Mode.DIFFERENTIAL_PULSE_VOLTAMMETRY_MODE:
//         return 'Differential Pulse Voltammetry';

//       case Mode.SQUARE_WAVE_VOLTAMMETRY_MODE:
//         return 'Square Wave Voltammetry';

//       default:
//         throw UnimplementedError('Unexpected mode value: $this');
//     }
//   }
// }

extension SubstanceText on Substance {
  String get text {
    switch (this) {
      case Substance.ARSENIC:
        return 'Arsenic (As (III))';

      case Substance.CHROMIUM:
        return 'Chromium (Cr (VI))';

      case Substance.MERCURY:
        return 'Mercury (Hg (II))';

      case Substance.CADMIUM_LEAD:
        return 'Cadmium (Cd) & Lead (Pb)​';

      // case Substance.CYPERMETHRIN:
      //   return 'Cypermethrin';

      // case Substance.CARBARYL:
      //   return 'Carbaryl';

      // case Substance.CHLORPYRIFOS:
      //   return 'Chlorpyrifos';

      default:
        throw UnimplementedError('Unexpected substance value: $this');
    }
  }

  String get header {
    switch (this) {
      case Substance.ARSENIC:
      case Substance.CHROMIUM:
      case Substance.MERCURY:
      case Substance.CADMIUM_LEAD:
        return 'Heavy Metals';

      // case Substance.CYPERMETHRIN:
      // case Substance.CARBARYL:
      // case Substance.CHLORPYRIFOS:
      //   return 'Pesticides';

      default:
        throw UnimplementedError('Unexpected substance value: $this');
    }
  }
}
