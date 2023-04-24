part of nfc_sic.peak;

/// Pesticides
///  * Cypermethrin `[CYPERMETHRIN]`
///  * Carbaryl `[CARBARYL]`
///  * Chlorpyrifos `[CHLORPYRIFOS]`
enum Pesticide {
  Cypermethrin,
  Carbaryl,
  Chlorpyrifos,
}

extension PesticideString on Pesticide {
  String get text {
    switch (this) {
      case Pesticide.Cypermethrin:
        return 'Cypermethrin';

      case Pesticide.Carbaryl:
        return 'Carbaryl';

      case Pesticide.Chlorpyrifos:
        return 'Chlorpyrifos';

      default:
        throw UnimplementedError('Unexpected pesticide value: $this');
    }
  }

  String get unit {
    switch (this) {
      case Pesticide.Cypermethrin:
      case Pesticide.Carbaryl:
        return 'ppm';

      case Pesticide.Chlorpyrifos:
        return 'ppm';

      default:
        throw UnimplementedError('Unexpected pesticide value: $this');
    }
  }
}

extension PesticideValue on Pesticide {
  double get m {
    switch (this) {
      case Pesticide.Cypermethrin:
        return -33.590;

      case Pesticide.Carbaryl:
        return -21.255;

      case Pesticide.Chlorpyrifos:
        return 0.1705;

      default:
        throw UnimplementedError('Unexpected pesticide value: $this');
    }
  }

  double get c {
    switch (this) {
      case Pesticide.Cypermethrin:
        return 77.880;

      case Pesticide.Carbaryl:
        return 65.530;

      case Pesticide.Chlorpyrifos:
        return 3.6226;

      default:
        throw UnimplementedError('Unexpected pesticide value: $this');
    }
  }
}

extension PesticideCompare on Pesticide {
  bool get isCypermethrin => (this == Pesticide.Cypermethrin);
  bool get isCarbaryl => (this == Pesticide.Carbaryl);
  bool get isChlorpyrifos => (this == Pesticide.Chlorpyrifos);

  bool get isNotCypermethrin => (this != Pesticide.Cypermethrin);
  bool get isNotCarbaryl => (this == Pesticide.Carbaryl);
  bool get isNotChlorpyrifos => (this != Pesticide.Chlorpyrifos);
}
