part of nfc_sic.chip.sic4341;

class Config extends ChipProvider {
  Config._(Sic4341 sic4341): super(sic4341);

  /// Address CHEM Config
  ///
  /// Bit position of register:
  ///  * CHEM WE GND [CHEM_WE_GND]
  ///  * CHEM RE CE Short [CHEM_RE_CE_SHT]
  ///  * CHEM Range [CHEM_RANGE]
  static const int ADDRESS_CHEM_CFG = Register.CHEM_CFG;

  /// CHEM WE GND [default: 0]
  ///
  /// Bit controlling sensor connection 1 pins connection,
  /// CE and RE pins are connected to GND
  ///  * [0] : No Connect [CHEM_WE_GND__NoConnect]
  ///  * [1] : Connect [CHEM_WE_GND__Connect]
  static const int CHEM_WE_GND = 0x04;
  static const int CHEM_WE_GND__NoConnect = 0x00;
  static const int CHEM_WE_GND__Connect = 0x04;

  /// CHEM RE CE Short [default: -]
  ///
  /// Bit controlling sensor connection 2 pins connection,
  /// CE and RE are internally connected
  ///  * [0] : No Connect [CHEM_RE_CE_SHT__NoConnect]
  ///  * [1] : Connect [CHEM_RE_CE_SHT__Connect]
  static const int CHEM_RE_CE_SHT = 0x02;
  static const int CHEM_RE_CE_SHT__NoConnect = 0x00;
  static const int CHEM_RE_CE_SHT__Connect = 0x02;

  /// CHEM Range [default: -]
  ///
  /// Bit defining input current range
  ///  * [0] : +/- 2.5 uA [CHEM_RANGE__2_5uA]
  ///  * [1] : +/- 20 uA [CHEM_RANGE__20uA]
  static const int CHEM_RANGE = 0x01;
  static const int CHEM_RANGE__2_5uA = 0x00;
  static const int CHEM_RANGE__20uA = 0x01;

  /// Address VDD Config
  ///
  /// Bit position of register:
  ///  * VDD [VDD_EN]
  static const int ADDRESS_VDD_CFG = Register.VDD_CFG;

  /// VDD [default: 0]
  ///
  /// Bit enabling LDO 1.8 V for sensor biasing circuit
  ///  * [0] : Disable [VDD_EN__Disable]
  ///  * [1] : Enable [VDD_EN__Enable]
  static const int VDD_EN = 0x01;
  static const int VDD_EN__Disable = 0x00;
  static const int VDD_EN__Enable = 0x01;

  /// Address Temperature Sensor Config
  ///
  /// Bit position of register:
  ///  * ADC Input Mode [ADC_I_MODE]
  ///  * Temperature Sensor Mode [TEMPSEN_MODE]
  static const int ADDRESS_TEMPSEN_CFG = Register.TEMPSEN_CFG;

  /// ADC Input Mode [default: 0]
  ///
  /// Bit controlling the ADC input mode
  ///  * [0] : Voltage mode [ADC_I_MODE__Voltage]
  ///  * [1] : Current mode (transfer to voltage by transimpedance circuit) [ADC_I_MODE__Current]
  static const int ADC_I_MODE = 0x02;
  static const int ADC_I_MODE__Voltage = 0x00;
  static const int ADC_I_MODE__Current = 0x02;

  /// Temperature Sensor Mode [default: 0]
  ///
  /// Bit enabling temperature sensor All device can switch
  /// from its default mode to temperature sensor mode by
  /// change this bit
  ///  * [0] : Disable [TEMPSEN_MODE__Disable]
  ///  * [1] : Enable [TEMPSEN_MODE__Enable]
  static const int TEMPSEN_MODE = 0x01;
  static const int TEMPSEN_MODE__Disable = 0x00;
  static const int TEMPSEN_MODE__Enable = 0x01;

  /// Address Sensor Config
  ///
  /// Bit position of register:
  ///  * Chemical Sensing [CHEM_SENS_EN]
  ///  * Temperature [TEMP_EN]
  ///  * ISFET [ISFET_EN]
  ///  * Chemical [CHEM_EN]
  ///  * IDRV [IDRV_EN]
  ///  * DAC [DAC_EN]
  ///  * ADC – Analog [ADC_ANA_EN]
  static const int ADDRESS_SENSOR_CFG = Register.SENSOR_CFG;

  /// Chemical Sensing [default: 0]
  ///
  /// Bit enabling chemical current sensing circuit
  ///  * [0] : Disable [CHEM_SENS_EN__Disable]
  ///  * [1] : Enable [CHEM_SENS_EN__Enable]
  static const int CHEM_SENS_EN = 0x40;
  static const int CHEM_SENS_EN__Disable = 0x00;
  static const int CHEM_SENS_EN__Enable = 0x40;

  /// Temperature [default: 0]
  ///
  /// Bit enabling temperature sensor
  ///  * [0] : Disable [TEMP_EN__Disable]
  ///  * [1] : Enable [TEMP_EN__Enable]
  static const int TEMP_EN = 0x20;
  static const int TEMP_EN__Disable = 0x00;
  static const int TEMP_EN__Enable = 0x20;

  /// ISFET [default: 0]
  ///
  /// Bit enabling ISFET biasing circuit
  ///  * [0] : Disable [ISFET_EN__Disable]
  ///  * [1] : Enable [ISFET_EN__Enable]
  static const int ISFET_EN = 0x10;
  static const int ISFET_EN__Disable = 0x00;
  static const int ISFET_EN__Enable = 0x10;

  /// Chemical [default: 0]
  ///
  /// Bit enabling chemical biasing circuit
  ///  * [0] : Disable [CHEM_EN__Disable]
  ///  * [1] : Enable [CHEM_EN__Enable]
  static const int CHEM_EN = 0x08;
  static const int CHEM_EN__Disable = 0x00;
  static const int CHEM_EN__Enable = 0x08;

  /// IDRV [default: 0]
  ///
  /// Bit enabling current driving circuit
  ///  * [0] : Disable [IDRV_EN__Disable]
  ///  * [1] : Enable [IDRV_EN__Enable]
  static const int IDRV_EN = 0x04;
  static const int IDRV_EN__Disable = 0x00;
  static const int IDRV_EN__Enable = 0x04;

  /// DAC [default: 0]
  ///
  /// Bit enabling DAC
  ///  * [0] : Disable [DAC_EN__Disable]
  ///  * [1] : Enable [DAC_EN__Enable]
  static const int DAC_EN = 0x02;
  static const int DAC_EN__Disable = 0x00;
  static const int DAC_EN__Enable = 0x02;

  /// ADC – Analog [default: 0]
  ///
  /// Bit enabling ADC – Analog circuit
  ///  * [0] : Disable [ADC_ANA_EN__Disable]
  ///  * [1] : Enable [ADC_ANA_EN__Enable]
  static const int ADC_ANA_EN = 0x01;
  static const int ADC_ANA_EN__Disable = 0x00;
  static const int ADC_ANA_EN__Enable = 0x01;

  /// Address GAP Compensation Config
  ///
  /// Bit position of register:
  ///  * Gap Compensation [GAP_CMPEN_EN]
  ///  * Gap Width Compensation [GAP_WID_CMPEN]
  static const int ADDRESS_GAP_CMPEN_CFG = Register.GAP_WID_CFG;

  /// Gap Compensation [default: 0]
  ///
  /// Bit enabling timer compensation when gap appear in `ADC_TICK` Mode
  ///  * [0] : Disable [GAP_CMPEN_EN__Disable]
  ///  * [1] : Enable [GAP_CMPEN_EN__Enable]
  static const int GAP_CMPEN_EN = 0x10;
  static const int GAP_CMPEN_EN__Disable = 0x00;
  static const int GAP_CMPEN_EN__Enable = 0x10;

  /// Gap Width Compensation [default: 000]
  ///
  /// Value setting value of compensation
  ///  * [000] : + 32 CLK [GAP_WID_CMPEN__Clk32]
  ///  * [001] : + 36 CLK [GAP_WID_CMPEN__Clk36]
  ///  * [010] : + 40 CLK [GAP_WID_CMPEN__Clk40]
  ///  * [011] : + 44 CLK [GAP_WID_CMPEN__Clk44]
  ///  * [100] : + 16 CLK [GAP_WID_CMPEN__Clk16]
  ///  * [101] : + 20 CLK [GAP_WID_CMPEN__Clk20]
  ///  * [110] : + 24 CLK [GAP_WID_CMPEN__Clk24]
  ///  * [111] : + 28 CLK [GAP_WID_CMPEN__Clk28]
  ///
  /// Default gap width from ISO14443A is 32 CLK.
  static const int GAP_WID_CMPEN = 0x07;
  static const int GAP_WID_CMPEN__Clk32 = 0x00;
  static const int GAP_WID_CMPEN__Clk36 = 0x01;
  static const int GAP_WID_CMPEN__Clk40 = 0x02;
  static const int GAP_WID_CMPEN__Clk44 = 0x03;
  static const int GAP_WID_CMPEN__Clk16 = 0x04;
  static const int GAP_WID_CMPEN__Clk20 = 0x05;
  static const int GAP_WID_CMPEN__Clk24 = 0x06;
  static const int GAP_WID_CMPEN__Clk28 = 0x07;

  /// Checks the 1 pins connection, `WE` pins are connected to `GND` or not?
  ///
  ///     [return]
  ///         false : not connection.
  ///         true  : [WE] pins are connected to [GND].
  ///
  Future<bool> isWeGndConnected() async =>
      ((await register.readBuffer(
        ADDRESS_CHEM_CFG)) & CHEM_WE_GND) == CHEM_WE_GND__Connect;

  /// Sets the bit controlling sensor connection.
  ///
  ///     [@param] connected: this parameter contains a [WE] and [GND] pin.
  ///
  /// This parameter can be one of the following values:
  ///
  ///         false : not connection.
  ///         true  : [WE] pins are connected to [GND].
  ///
  Future<void> setWeGndConnected({ bool connected = true }) async {
    await register.writeParams(
      ADDRESS_CHEM_CFG,
      CHEM_WE_GND,
      connected ? CHEM_WE_GND__Connect : CHEM_WE_GND__NoConnect);
  }

  /// Checks the 2 pins connection, `CE` and `RE` are internally
  /// connected or not?
  ///
  ///     [return]
  ///         false : not connection.
  ///         true  : [CE] and [RE] are internally connected.
  ///
  Future<bool> isReCeShortCircuit() async =>
      ((await register.readBuffer(
        ADDRESS_CHEM_CFG)) & CHEM_RE_CE_SHT) == CHEM_RE_CE_SHT__Connect;

  /// Sets the bit controlling sensor connection.
  ///
  ///     [@param] connected: this parameter contains a [CE] and [RE] pin.
  ///
  /// This parameter can be one of the following values:
  ///
  ///         false : not connection.
  ///         true  : [CE] and [RE] are internally connected.
  ///
  Future<void> setReCeShortCircuit({ bool connected = true }) async {
    await register.writeParams(
      ADDRESS_CHEM_CFG,
      CHEM_RE_CE_SHT,
      connected ? CHEM_RE_CE_SHT__Connect : CHEM_RE_CE_SHT__NoConnect);
  }

  /// Gets the input `current range`.
  ///
  ///     [return] input current range [+/- 2.5 uA] or [+/- 20.0 uA]
  ///
  Future<int> getCurrentRange() async =>
      (await register.readBuffer(
        ADDRESS_CHEM_CFG)) & CHEM_RANGE;

  /// Sets the input `current range`.
  ///
  ///     [@param] range: specifies the port bit to be set.
  ///
  /// This parameter can be one of the following values:
  ///
  ///         [CHEM_RANGE__2_5uA] : [+/- 2.5 uA]
  ///         [CHEM_RANGE__20uA]  : [+/- 20.0 uA]
  ///
  Future<void> setCurrentRange(int range) async {
    await register.writeParams(
      ADDRESS_CHEM_CFG,
      CHEM_RANGE,
      range);
  }

  /// Checks the `LDO 1.8 V` for `sensor biasing` circuit.
  ///
  ///     [return]
  ///         false : not connection.
  ///         true  : [CE] and [RE] are internally connected.
  ///
  Future<bool> isVddEnabled() async =>
      ((await register.readBuffer(
        ADDRESS_VDD_CFG)) & VDD_EN) == VDD_EN__Enable;

  /// Sets the bit enabling `LDO 1.8 V` for `sensor biasing` circuit.
  ///
  ///     [@param] enabled: this parameter contains a [VDD].
  ///
  /// This parameter can be one of the following values:
  ///
  ///         false : [Disable] the [LDO 1.8 V].
  ///         true  : [Enable] the [LDO 1.8 V].
  ///
  Future<void> setVddEnabled({ bool enabled = true }) async {
    await register.writeParams(
      ADDRESS_VDD_CFG,
      VDD_EN,
      enabled ? VDD_EN__Enable : VDD_EN__Disable);
  }

  /// Gets the bit controlling the `adc input mode`.
  ///
  ///     [return] adc input mode voltage mode or current mode.
  ///
  Future<int> getAdcIMode() async =>
    (await register.readBuffer(
      ADDRESS_TEMPSEN_CFG)) & ADC_I_MODE;

  /// Sets the bit controlling the `adc input mode`.
  ///
  ///     [@param] mode: specifies the port bit to be set.
  ///
  /// This parameter can be one of the following values:
  ///
  ///         [ADC_I_MODE__Voltage]: voltage mode.
  ///         [ADC_I_MODE__Current]: current mode (transfer to voltage by transimpedance circuit).
  ///
  Future<void> setAdcIMode(int mode) async {
    await register.writeParams(
      ADDRESS_TEMPSEN_CFG,
      ADC_I_MODE,
      mode);
  }

  /// Checks the bit enabling `temperature sensor`.
  ///
  ///     [return]
  ///         false : default mode.
  ///         true  : temperature sensor mode.
  ///
  Future<bool> isTempSenModeEnabled() async =>
      ((await register.readBuffer(
        ADDRESS_TEMPSEN_CFG)) & TEMPSEN_MODE) == TEMPSEN_MODE__Enable;

  /// Sets the bit enabling `temperature sensor`.
  /// All device can switch from its `default mode`
  /// to `temperature sensor` mode by change this.
  ///
  ///     [@param] enabled: this parameter contains a temperature senosr mode.
  ///
  /// This parameter can be one of the following values:
  ///
  ///         false : default mode.
  ///         true  : temperature sensor mode.
  ///
  Future<void> setTempSenModeEnabled({ bool enabled = true }) async {
    await register.writeParams(
      ADDRESS_TEMPSEN_CFG,
      TEMPSEN_MODE,
      enabled ? TEMPSEN_MODE__Enable : TEMPSEN_MODE__Disable);
  }

  /// Checks the bit enabling `chemical current sensing` circuit.
  ///
  ///     [return]
  ///         false : [Disable] the chemical current sensor.
  ///         true  : [Enable] the chemical current sensor.
  ///
  Future<bool> isChemicalSensorEnabled() async =>
      ((await register.readBuffer(
        ADDRESS_SENSOR_CFG)) & CHEM_SENS_EN) == CHEM_SENS_EN__Enable;

  /// Sets the bit enabling `chemical current sensing` circuit.
  ///
  ///     [@param] enabled: this parameter contains a chemical current sensing circuit.
  ///
  /// This parameter can be one of the following values:
  ///
  ///         false : [Disable] the chemical current sensor.
  ///         true  : [Enable] the chemical current sensor.
  ///
  Future<void> setChemicalSensorEnabled({ bool enabled = true }) async {
    await register.writeParams(
      ADDRESS_SENSOR_CFG,
      CHEM_SENS_EN,
      enabled ? CHEM_SENS_EN__Enable : CHEM_SENS_EN__Disable);
  }

  /// Checks the bit enabling `temperature sensor`.
  ///
  ///     [return]
  ///         false : [Disable] the temperature sensor.
  ///         true  : [Enable] the temperature sensor.
  ///
  Future<bool> isTempertureEnabled() async =>
      ((await register.readBuffer(
        ADDRESS_SENSOR_CFG)) & TEMP_EN) == TEMP_EN__Enable;

  /// Sets the bit enabling `temperature sensor`.
  ///
  ///     [@param] enabled: this parameter contains a chemical current sensing circuit.
  ///
  /// This parameter can be one of the following values:
  ///
  ///         false : [Disable] the temperature sensor.
  ///         true  : [Enable] the temperature sensor.
  ///
  Future<void> setTempertureEnabled({ bool enabled = true }) async {
    await register.writeParams(
      ADDRESS_SENSOR_CFG,
      TEMP_EN,
      enabled ? TEMP_EN__Enable : TEMP_EN__Disable);
  }

  /// Checks the bit enabling `isfet biasing` circuit.
  ///
  ///     [return]
  ///         false : [Disable] the isfet biasing circuit.
  ///         true  : [Enable] the isfet biasing circuit.
  ///
  Future<bool> isIsfetEnabled() async =>
      ((await register.readBuffer(
        ADDRESS_SENSOR_CFG)) & ISFET_EN) == ISFET_EN__Enable;

  /// Sets the bit enabling `isfet biasing` circuit.
  ///
  ///     [@param] enabled: this parameter contains a isfet biasing circuit.
  ///
  /// This parameter can be one of the following values:
  ///
  ///         false : [Disable] the isfet biasing circuit.
  ///         true  : [Enable] the isfet biasing circuit.
  ///
  Future<void> setIsfetEnabled({ bool enabled = true }) async {
    await register.writeParams(
      ADDRESS_SENSOR_CFG,
      ISFET_EN,
      enabled ? ISFET_EN__Enable : ISFET_EN__Disable);
  }

  /// Checks the bit enabling `chemical biasing` circuit.
  ///
  ///     [return]
  ///         false : [Disable] the chemical biasing circuit.
  ///         true  : [Enable] the chemical biasing circuit.
  ///
  Future<bool> isChemicalEnabled() async =>
      ((await register.readBuffer(
        ADDRESS_SENSOR_CFG)) & CHEM_EN) == CHEM_EN__Enable;

  /// Sets the bit enabling `chemical biasing` circuit.
  ///
  ///     [@param] enabled: this parameter contains a chemical biasing circuit.
  ///
  /// This parameter can be one of the following values:
  ///
  ///         false : [Disable] the chemical biasing circuit.
  ///         true  : [Enable] the chemical biasing circuit.
  ///
  Future<void> setChemicalEnabled({ bool enabled = true }) async {
    await register.writeParams(
      ADDRESS_SENSOR_CFG,
      CHEM_EN,
      enabled ? CHEM_EN__Enable : CHEM_EN__Disable);
  }

  /// Checks the bit enabling `current driving` circuit.
  ///
  ///     [return]
  ///         false : [Disable] the current driving circuit.
  ///         true  : [Enable] the current driving circuit.
  ///
  Future<bool> isIDRVEnabled() async =>
      ((await register.readBuffer(
        ADDRESS_SENSOR_CFG)) & IDRV_EN) == IDRV_EN__Enable;

  /// Sets the bit enabling `current driving` circuit.
  ///
  ///     [@param] enabled: this parameter contains a chemical biasing circuit.
  ///
  /// This parameter can be one of the following values:
  ///
  ///         false : [Disable] the current driving circuit.
  ///         true  : [Enable] the current driving circuit.
  ///
  Future<void> setIDRVEnabled({ bool enabled = true }) async {
    await register.writeParams(
      ADDRESS_SENSOR_CFG,
      IDRV_EN,
      enabled ? IDRV_EN__Enable : IDRV_EN__Disable);
  }

  /// Checks the bit enabling `dac`.
  ///
  ///     [return]
  ///         false : [Disable] the dac.
  ///         true  : [Enable] the dac.
  ///
  Future<bool> isDacEnabled() async =>
      ((await register.readBuffer(
        ADDRESS_SENSOR_CFG)) & DAC_EN) == DAC_EN__Enable;

  /// Sets the bit enabling `dac`.
  ///
  ///     [@param] enabled: this parameter contains a chemical biasing circuit.
  ///
  /// This parameter can be one of the following values:
  ///
  ///         false : [Disable] the dac.
  ///         true  : [Enable] the dac.
  ///
  Future<void> setDacEnabled({ bool enabled = true }) async {
    await register.writeParams(
      ADDRESS_SENSOR_CFG,
      DAC_EN,
      enabled ? DAC_EN__Enable : DAC_EN__Disable);
  }

  /// Checks the bit enabling `adc – analog` circuit.
  ///
  ///     [return]
  ///         false : [Disable] the adc – analog circuit.
  ///         true  : [Enable] the adc – analog circuit.
  ///
  Future<bool> isAdcAnalogEnabled() async =>
      ((await register.readBuffer(
        ADDRESS_SENSOR_CFG)) & ADC_ANA_EN) == ADC_ANA_EN__Enable;

  /// Sets the bit enabling `adc – analog` circuit.
  ///
  ///     [@param] enabled: this parameter contains a adc – analog circuit.
  ///
  /// This parameter can be one of the following values:
  ///
  ///         false : [Disable] the adc – analog circuit.
  ///         true  : [Enable] the adc – analog circuit.
  ///
  Future<void> setAdcAnalogEnabled({ bool enabled = true }) async {
    await register.writeParams(
      ADDRESS_SENSOR_CFG,
      ADC_ANA_EN,
      enabled ? ADC_ANA_EN__Enable : ADC_ANA_EN__Disable);
  }

  /// Checks the bit enabling timer compensation when `gap appear`
  /// in `ADC_TICK` mode.
  ///
  ///     [return]
  ///         false : [Disable] the timer compensation.
  ///         true  : [Enable] the timer compensation.
  ///
  Future<bool> isGapCompensationEnabled() async =>
      ((await register.readBuffer(
        ADDRESS_GAP_CMPEN_CFG)) & GAP_CMPEN_EN) == GAP_CMPEN_EN__Enable;

  /// Sets the bit enabling timer compensation when `gap appear`
  /// in `ADC_TICK` mode.
  ///
  ///     [@param] enabled: this parameter contains a timer compensation.
  ///
  /// This parameter can be one of the following values:
  ///
  ///         false : [Disable] the timer compensation.
  ///         true  : [Enable] the timer compensation.
  ///
  Future<void> setGapCompensationEnabled({ bool enabled = true }) async {
    await register.writeParams(
      ADDRESS_GAP_CMPEN_CFG,
      GAP_CMPEN_EN,
      enabled ? GAP_CMPEN_EN__Enable : GAP_CMPEN_EN__Disable);
  }

  /// Gets the value setting value of compensation,
  /// Default `gap width` from `ISO14443A` is 32 CLK.
  ///
  ///     [return] value of compensation.
  ///
  Future<int> getGapWidthCompensation() async =>
      (await register.readBuffer(
        ADDRESS_GAP_CMPEN_CFG)) & GAP_WID_CMPEN;

  /// Sets the value setting value of compensation,
  /// Default `gap width` from `ISO14443A` is 32 CLK.
  ///
  ///     [@param] width: Specifies the port bit to be set.
  ///
  /// This parameter can be one of the following values:
  ///
  ///         [GAP_WID_CMPEN__Clk16]: gap width is 16 CLK.
  ///         [GAP_WID_CMPEN__Clk20]: gap width is 20 CLK.
  ///         [GAP_WID_CMPEN__Clk24]: gap width is 24 CLK.
  ///         [GAP_WID_CMPEN__Clk28]: gap width is 28 CLK.
  ///         [GAP_WID_CMPEN__Clk32]: gap width is 32 CLK.
  ///         [GAP_WID_CMPEN__Clk36]: gap width is 36 CLK.
  ///         [GAP_WID_CMPEN__Clk40]: gap width is 40 CLK.
  ///         [GAP_WID_CMPEN__Clk44]: gap width is 44 CLK.
  ///
  Future<void> setGapWidthCompensation(int width) async {
    await register.writeParams(
      ADDRESS_GAP_CMPEN_CFG,
      GAP_WID_CMPEN,
      width);
  }
}