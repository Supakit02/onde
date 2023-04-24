part of nfc_sic.chip.sic4341;

class Dac extends ChipProvider {
  Dac._(Sic4341 sic4341): super(sic4341);

  /// Address DAC Config
  ///
  /// Bit position of register:
  ///  * DAC2 Buffer [DAC2_BUF_EN]
  ///  * DAC1 Buffer [DAC1_BUF_EN]
  ///  * RE VG Channel [RE_VG_CH]
  ///  * DAC2 WE VD Channel [DAC2_WE_VD_CH]
  ///  * DAC1 CE Channel [DAC1_CE_CH]
  static const int ADDRESS_DAC_CONFIG = Register.DAC_CFG;

  /// DAC2 Buffer [default: 0]
  ///
  /// Bit enabling DAC2 BUFFER output
  ///  * [0] : Disable [DAC2_BUF_EN__Disable]
  ///  * [1] : Enable [DAC2_BUF_EN__Enable]
  static const int DAC2_BUF_EN = 0x80;
  static const int DAC2_BUF_EN__Disable = 0x00;
  static const int DAC2_BUF_EN__Enable = 0x80;

  /// DAC1 Buffer [default: 0]
  ///
  /// Bit enabling DAC1 BUFFER output
  ///  * [0] : Disable [DAC1_BUF_EN__Disable]
  ///  * [1] : Enable [DAC1_BUF_EN__Enable]
  static const int DAC1_BUF_EN = 0x40;
  static const int DAC1_BUF_EN__Disable = 0x00;
  static const int DAC1_BUF_EN__Enable = 0x40;

  /// RE VG Channel [default: 11]
  ///
  /// ChemSen – RE pin and ISFET – VG pin channel selection
  ///  * [00] : Channel 0 [RE_VG_CH__Channel0]
  ///  * [01] : Channel 1 [RE_VG_CH__Channel1]
  ///  * [10] : Channel 2 [RE_VG_CH__Channel2]
  ///  * [11] : Channel 3 [RE_VG_CH__Channel3]
  static const int RE_VG_CH = 0x30;
  static const int RE_VG_CH__Channel0 = 0x00;
  static const int RE_VG_CH__Channel1 = 0x10;
  static const int RE_VG_CH__Channel2 = 0x20;
  static const int RE_VG_CH__Channel3 = 0x30;

  /// DAC2 WE VD Channel [default: 11]
  ///
  /// ChemSen – WE pin, ISFET – VD pin, and DAC2 pin channel selection
  ///  * [00] : Channel 0 [DAC2_WE_VD_CH__Channel0]
  ///  * [01] : Channel 1 [DAC2_WE_VD_CH__Channel1]
  ///  * [10] : Channel 2 [DAC2_WE_VD_CH__Channel2]
  ///  * [11] : Channel 3 [DAC2_WE_VD_CH__Channel3]
  static const int DAC2_WE_VD_CH = 0x0C;
  static const int DAC2_WE_VD_CH__Channel0 = 0x00;
  static const int DAC2_WE_VD_CH__Channel1 = 0x04;
  static const int DAC2_WE_VD_CH__Channel2 = 0x08;
  static const int DAC2_WE_VD_CH__Channel3 = 0x0C;

  /// DAC1 CE Channel [default: 11]
  ///
  /// ChemSen – CE pin and DAC1 pin channel selection
  ///  * [00] : Channel 0 [DAC1_CE_CH__Channel0]
  ///  * [01] : Channel 1 [DAC1_CE_CH__Channel1]
  ///  * [10] : Channel 2 [DAC1_CE_CH__Channel2]
  ///  * [11] : Channel 3 [DAC1_CE_CH__Channel3]
  static const int DAC1_CE_CH = 0x03;
  static const int DAC1_CE_CH__Channel0 = 0x00;
  static const int DAC1_CE_CH__Channel1 = 0x01;
  static const int DAC1_CE_CH__Channel2 = 0x02;
  static const int DAC1_CE_CH__Channel3 = 0x03;

  /// Address DAC1 Value
  ///
  /// Bit position of register:
  ///  * DAC1 Value [DAC1_VALUE]
  static const int ADDRESS_DAC1_VALUE = Register.DAC1_VALUE;

  /// DAC1 Value [default: 0000_0000]
  ///
  /// Value defining the output voltage of DAC1 with resolution 5 mV / step
  static const int DAC1_VALUE = 0xFF;

  /// Address DAC2 Value
  ///
  /// Bit position of register:
  ///  * DAC2 Value[DAC2_VALUE]
  static const int ADDRESS_DAC2_VALUE = Register.DAC2_VALUE;

  /// DAC2 Value [default: 0000_0000]
  ///
  /// Value defining the output voltage of DAC2 with resolution 5 mV / step
  static const int DAC2_VALUE = 0xFF;

  /// Gets the output voltage of `DAC_1`
  ///
  ///     [return] the output voltage of [DAC_1]
  ///
  Future<int> getDac1Output() async =>
      (await register.readBuffer(
        ADDRESS_DAC1_VALUE)) * 5;

  /// Sets the output voltage of `DAC_1`
  ///
  ///     [@param] mV: specifies the output voltage of [DAC_1] to be set the [DAC1_Value] register (mV).
  ///
  Future<void> setDac1Output(int mV) async {
    await register.write(
      ADDRESS_DAC1_VALUE,
      mV ~/ 5.0);
  }

  /// Gets the output voltage of `DAC_2`
  ///
  ///     [return] the output voltage of [DAC_2]
  ///
  Future<int> getDac2Output() async =>
      (await register.readBuffer(
        ADDRESS_DAC2_VALUE)) * 5;

  /// Sets the output voltage of `DAC_2`
  ///
  ///     [@param] mV: specifies the output voltage of [DAC_2] to be set the [DAC2_Value] register (mV).
  ///
  Future<void> setDac2Output(int mV) async {
    await register.write(
      ADDRESS_DAC2_VALUE,
      mV ~/ 5.0);
  }

  /// Checks the bit enabling `DAC2 BUFFER` output.
  ///
  ///     [return]
  ///         false : [Disable] the [DAC2 BUFFER] output.
  ///         true  : [Enable] the [DAC2 BUFFER] output.
  ///
  Future<bool> isDac2BufferEnabled() async =>
      ((await register.readBuffer(
        ADDRESS_DAC_CONFIG)) & DAC2_BUF_EN) == DAC2_BUF_EN__Enable;

  /// Sets the bit enabling `DAC2 BUFFER` output.
  ///
  ///     [@param] enabled: this parameter contains a [DAC2 BUFFER] output.
  ///
  /// This parameter can be one of the following values:
  ///
  ///         false : [Disable] the [DAC2 BUFFER] output.
  ///         true  : [Enable] the [DAC2 BUFFER] output.
  ///
  Future<void> setDac2BufferEnabled({ bool enabled = true }) async {
    await register.writeParams(
      ADDRESS_DAC_CONFIG,
      DAC2_BUF_EN,
      enabled ? DAC2_BUF_EN__Enable : DAC2_BUF_EN__Disable);
  }

  /// Checks the bit enabling `DAC1 BUFFER` output.
  ///
  ///     [return]
  ///         false : [Disable] the [DAC1 BUFFER] output.
  ///         true  : [Enable] the [DAC1 BUFFER] output.
  ///
  Future<bool> isDac1BufferEnabled() async =>
      ((await register.readBuffer(
        ADDRESS_DAC_CONFIG)) & DAC1_BUF_EN) == DAC1_BUF_EN__Enable;

  /// Sets the bit enabling `DAC1 BUFFER` output.
  ///
  ///     [@param] enabled: this parameter contains a [DAC1 BUFFER] output.
  ///
  /// This parameter can be one of the following values:
  ///
  ///         false : [Disable] the [DAC1 BUFFER] output.
  ///         true  : [Enable] the [DAC1 BUFFER] output.
  ///
  Future<void> setDac1BufferEnabled({ bool enabled = true }) async {
    await register.writeParams(
      ADDRESS_DAC_CONFIG,
      DAC1_BUF_EN,
      enabled ? DAC1_BUF_EN__Enable : DAC1_BUF_EN__Disable);
  }

  /// Sets the bit enabling `DAC1 BUFFER` output.
  ///
  ///     [@param] enabled: this parameter contains a [DAC1 BUFFER] output.
  ///
  /// This parameter can be one of the following values:
  ///
  ///         false : [Disable] the [DAC1 BUFFER] output.
  ///         true  : [Enable] the [DAC1 BUFFER] output.
  ///
  Future<int> getReVgChannel() async =>
      (await register.readBuffer(
        ADDRESS_DAC_CONFIG)) & RE_VG_CH;

  /// Sets the `RE` (in `ChemSen` mode) pin and `VG` (in `ISFET` mode) pin channel selection.
  ///
  ///     [@param] channel: specifies the port bit to be set.
  ///
  /// This parameter can be one of the following values:
  ///
  ///         [RE_VG_CH__Channel0]: pin channel 0 is selected.
  ///         [RE_VG_CH__Channel1]: pin channel 1 is selected.
  ///         [RE_VG_CH__Channel2]: pin channel 2 is selected.
  ///         [RE_VG_CH__Channel3]: pin channel 3 is selected.
  ///
  Future<void> setReVgChannel(int channel) async {
    await register.writeParams(
      ADDRESS_DAC_CONFIG,
      RE_VG_CH,
      channel);
  }

  /// Gets the `WE` (in `ChemSen` mode) pin, `VD` (in `ISFET` mode) pin and `DAC2` pin channel selection.
  ///
  ///     [return] bit controlling pin channel selection.
  ///
  Future<int> getDac2WeVdChannel() async =>
      (await register.readBuffer(
        ADDRESS_DAC_CONFIG)) & DAC2_WE_VD_CH;

  /// Sets the `WE` (in `ChemSen` mode) pin, `VD` (in `ISFET` mode) pin and `DAC2` pin channel selection.
  ///
  ///     [@param] channel: specifies the port bit to be set.
  ///
  /// This parameter can be one of the following values:
  ///
  ///         [DAC2_WE_VD_CH__Channel0]: pin channel 0 is selected.
  ///         [DAC2_WE_VD_CH__Channel1]: pin channel 1 is selected.
  ///         [DAC2_WE_VD_CH__Channel2]: pin channel 2 is selected.
  ///         [DAC2_WE_VD_CH__Channel3]: pin channel 3 is selected.
  ///
  Future<void> setDac2WeVdChannel(int channel) async {
    await register.writeParams(
      ADDRESS_DAC_CONFIG,
      DAC2_WE_VD_CH,
      channel);
  }

  /// Gets the `CE` (in `ChemSen` mode) pin and `DAC1` pin channel selection.
  ///
  /// [return] bit controlling pin channel selection.
  ///
  Future<int> getDac1CeChannel() async =>
      (await register.readBuffer(
        ADDRESS_DAC_CONFIG)) & DAC1_CE_CH;

  /// Sets the `CE` (in `ChemSen` mode) pin and `DAC1` pin channel selection.
  ///
  ///     [@param] channel: specifies the port bit to be set.
  ///
  /// This parameter can be one of the following values:
  ///
  ///         [DAC1_CE_CH__Channel0]: pin channel 0 is selected.
  ///         [DAC1_CE_CH__Channel1]: pin channel 1 is selected.
  ///         [DAC1_CE_CH__Channel2]: pin channel 2 is selected.
  ///         [DAC1_CE_CH__Channel3]: pin channel 3 is selected.
  ///
  Future<void> setDac1CeChannel(int channel) async {
    await register.writeParams(
      ADDRESS_DAC_CONFIG,
      DAC1_CE_CH,
      channel);
  }
}