part of nfc_sic.cmd;

class Eeprom {
  Eeprom._();

  /// Eeprom Address Page 0x35.
  ///  * [Byte 0] ADC_DIVIDER
  ///  * [Byte 1] ADC_PRESCALER
  ///  * [Byte 2] ADC_SAMP_DLY
  ///  * [Byte 3] ADC_NWAIT
  static const int PAGE_35 = 0x35;

  /// Eeprom Address Page 0x36.
  ///  * [Byte 0] ADC_NBIT
  ///  * [Byte 1] ADC_CONV_CFG
  ///  * [Byte 2] ADC_BUF_CFG
  ///  * [Byte 3] ADC_CH_CFG
  static const int PAGE_36 = 0x36;

  /// Eeprom Address Page 0x37.
  ///  * [Byte 0] IDRV_CFG
  ///  * [Byte 1] IDRV_VALUE
  ///  * [Byte 2] DAC1_VALUE
  ///  * [Byte 3] DAC2_VALUE
  static const int PAGE_37 = 0x37;

  /// Eeprom Address Page 0x38.
  ///  * [Byte 0] DAC_CFG
  ///  * [Byte 1] CHEM_CFG
  ///  * [Byte 2] - (not use)
  ///  * [Byte 3] VDD_CFG
  static const int PAGE_38 = 0x38;

  /// Eeprom Address Page 0x39.
  ///  * [Byte 0] TEMPSEN_CFG
  ///  * [Byte 1] - (not use)
  ///  * [Byte 2] GPIO_MODE
  ///  * [Byte 3] GPIO_INOUT
  static const int PAGE_39 = 0x39;

  /// Eeprom Address Page 0x3A.
  ///  * [Byte 0] SENSOR_CONFIG
  ///  * [Byte 1] - (not use)
  ///  * [Byte 2] GAP_WID_CFG
  ///  * [Byte 3] TEST
  static const int PAGE_3A = 0x3A;

  /// Gets the read `EEPROM` protocol.
  ///
  ///     [@param] address [EEPROM] address.
  ///
  ///     [return] byte array, data with Read [EEPROM] command.
  ///
  static Uint8List getPackageRead(int address) =>
      Uint8List.fromList([ 0x30, address ]);

  /// Gets the write `EEPROM` protocol.
  ///
  ///     [@param] address [EEPROM] address.
  ///     [@param] data    register data 4 bytes.
  ///
  ///     [return] byte array, data with Write [EEPROM] command.
  ///
  static Uint8List getPackageWrite(int address, Uint8List data) {
    if ( ReactFunc.checkArraySize(data, 4) ) {
      return Uint8List.fromList([
        0xA2,
        address,
        data[0],
        data[1],
        data[2],
        data[3],
      ]);
    }

    return null;
  }

  /// Gets the compatible write `EEPROM` protocol.
  ///
  ///     [@param] address [EEPROM] address.
  ///     [@param] data    register data 16 bytes
  ///                      (some tag can be written 4 bytes only).
  ///
  ///     [return] byte array, data with compatible write [EEPROM] command.
  ///
  static List<Uint8List> getPackageCompatibleWrite(int address, Uint8List data) {
    if ( ReactFunc.checkArraySize(data, 16) ) {
      return <Uint8List>[
        Uint8List.fromList([
          0xA0,
          address,
        ]),
        data,
      ];
    }

    return null;
  }
}