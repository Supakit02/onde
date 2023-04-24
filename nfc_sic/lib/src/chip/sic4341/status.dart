part of nfc_sic.chip.sic4341;

class Status extends StatusProvider {
  Status._(Sic4341 sic4341): super(sic4341);

  /// Address Status
  ///
  /// Bit position of register:
  ///  * VDD Ready Low [VDD_RDY_L]
  ///  * VDD Ready High [VDD_RDY_H]
  ///  * ADC Continuous Mode [ADC_CONT_FLG]
  ///  * ADC Tick Mode [ADC_TICK_FLG]
  static const int ADDRESS_STATUS = Register.STATUS;

  /// Bit indicates that VDD output is more than 1.2 V / 1.45 V (configure in EEPROM)
  static const int VDD_RDY_L = 0x01;

  /// Bit indicates that VDD output is more than 1.65 V
  static const int VDD_RDY_H = 0x02;

  /// Bit indicates that ADC is operated in Continuous Mode
  static const int ADC_CONT_FLG = 0x04;

  /// Bit indicates that ADC is operated in Tick Mode
  static const int ADC_TICK_FLG  = 0x08;

  /// Gets the `status` on register.
  ///
  ///     [return] byte status data value.
  ///
  @override
  Future<int> getStatus([ int address ]) =>
      super.getStatus(ADDRESS_STATUS);

  /// Bit indicates that adc is operated in `tick mode`.
  ///
  ///     [return] true, if this adc is operated in tick mode.
  ///
  Future<bool> isAdcTickMode() async {
    final _flag = await getStatus();

    return (_flag != null) && ((_flag & ADC_TICK_FLG) == ADC_TICK_FLG);
  }

  /// Bit indicates that adc is operated in `continuous mode`.
  ///
  ///     [return] true, if this adc is operated in continuous mode.
  ///
  Future<bool> isAdcContinuousMode() async {
    final _flag = await getStatus();

    return (_flag != null) && ((_flag & ADC_CONT_FLG) == ADC_CONT_FLG);
  }

  /// Bit indicates that `VDD` output is more than `1.65 V`.
  ///
  ///     [return] true, if [VDD] output is more than 1.65 V
  ///
  Future<bool> isVddHReady() async {
    final _flag = await getStatus();

    return (_flag != null) && ((_flag & VDD_RDY_H) == VDD_RDY_H);
  }

  /// Bit indicates that `VDD` output is more than `1.2 V / 1.45 V`
  /// (configure in `EEPROM`).
  ///
  ///     [return] true, if [VDD] output is more than [1.2 V / 1.45 V]
  ///
  Future<bool> isVddLReady() async {
    final _flag = await getStatus();

    return (_flag != null) && ((_flag & VDD_RDY_L) == VDD_RDY_L);
  }
}