part of nfc_sic.peak;

/// Substances
///  * Arsenic (As III) `[ARSENIC]`
///  * Chromium (Cr) `[CHROMIUM]`
///  * Mercury (Hg) `[MERCURY]`
///  * Cadmium (Cd) & Lead (Pb) `[CADMIUM_LEAD]`
///  * Generic `[GENERIC]`
enum Substance {
  ARSENIC,
  CHROMIUM,
  MERCURY,
  CADMIUM_LEAD,
  GENERIC,
  CYPERMETHRIN,
  CARBARYL,
  CHLORPYRIFOS,
}

extension SubstanceString on Substance {
  String get text {
    switch (this) {
      case Substance.ARSENIC:
        return 'Arsenic (As (III))';

      case Substance.CHROMIUM:
        return 'Chromium (Cr (VI))';

      case Substance.MERCURY:
        return 'Mercury (Hg (II))';

      case Substance.CADMIUM_LEAD:
        return 'Cadmium (Cd) & \nLead (Pb)​';

      case Substance.CYPERMETHRIN:
        return "MIP (Cypermethrin)";

      case Substance.CARBARYL:
        return "MIP (Carbaryl)";

      case Substance.CHLORPYRIFOS:
        return "Enzyme (Chlorpyrifos)";

      default:
        return 'Generic';
    }
  }

  String get shortText {
    switch (this) {
      case Substance.ARSENIC:
        return 'As';

      case Substance.CHROMIUM:
        return 'Cr';

      case Substance.MERCURY:
        return 'Hg';

      case Substance.CADMIUM_LEAD:
        return 'Cd_Pb​';

      case Substance.CYPERMETHRIN:
        return "Cypermethrin";

      case Substance.CARBARYL:
        return "Carbaryl";

      case Substance.CHLORPYRIFOS:
        return "Chlorpyrifos";

      default:
        return 'Generic';
    }
  }
}

extension SubstanceValue on Substance {
  /// List heavy metals type.
  ///
  /// if substances are not heavy metals
  /// then return empty list.
  List<HeavyMetal> get heavyMetal {
    switch (this) {
      case Substance.ARSENIC:
        return <HeavyMetal>[
          HeavyMetal.As,
        ];

      case Substance.CHROMIUM:
        return <HeavyMetal>[
          HeavyMetal.Cr,
        ];

      case Substance.MERCURY:
        return <HeavyMetal>[
          HeavyMetal.Hg,
        ];

      case Substance.CADMIUM_LEAD:
        return <HeavyMetal>[
          HeavyMetal.Cd,
          HeavyMetal.Pb,
        ];

      default:
        return <HeavyMetal>[];
    }
  }

  Pesticide get pesticide {
    switch (this) {
      case Substance.CYPERMETHRIN:
        return Pesticide.Cypermethrin;

      case Substance.CARBARYL:
        return Pesticide.Carbaryl;

      case Substance.CHLORPYRIFOS:
        return Pesticide.Chlorpyrifos;

      default:
        return null;
    }
  }
}

extension SubstanceCompare on Substance {
  // Generic
  bool get isGeneric => this == Substance.GENERIC;

  bool get isHeavyMetals =>
      isArsenic || isChromium || isMercury || isCadmiumLead;

  bool get isPesticides => isCypermethrin || isCarbaryl || isChlorpyrifos;

  // Heavy Metals
  bool get isArsenic => this == Substance.ARSENIC;
  bool get isChromium => this == Substance.CHROMIUM;
  bool get isMercury => this == Substance.MERCURY;
  bool get isCadmiumLead => this == Substance.CADMIUM_LEAD;

  // Pesticides
  bool get isCypermethrin => this == Substance.CYPERMETHRIN;
  bool get isCarbaryl => this == Substance.CARBARYL;
  bool get isChlorpyrifos => this == Substance.CHLORPYRIFOS;

  // Generic
  bool get isNotGeneric => this != Substance.GENERIC;

  // Heavy Metals;
  bool get isNotArsenic => this != Substance.ARSENIC;
  bool get isNotChromium => this != Substance.CHROMIUM;
  bool get isNotMercury => this == Substance.MERCURY;
  bool get isNotCadmiumLead => this != Substance.CADMIUM_LEAD;
}
