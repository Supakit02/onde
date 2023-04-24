part of nfc_sic.chip.sic4341;

class Idrv extends ChipProvider {
  Idrv._(Sic4341 sic4341): super(sic4341);

  /// Address IDRV Config
  ///
  /// Bit position of register:
  ///  * IDRV Channel [IDRV_CH]
  ///  * IDRV DC [IDRV_DC]
  ///  * IDRV Voltage Limiter [IDRV_VLM_EN]
  ///  * IDRV Range [IDRV_RNG]
  static const int ADDRESS_IDRV_CFG = Register.IDRV_CFG;

  /// IDRV Channel [default: 11]
  ///
  /// Value defining the current output channel
  ///  * [00] : Channel 0 [IDRV_CH__Channel0]
  ///  * [01] : Channel 1 [IDRV_CH__Channel1]
  ///  * [10] : Channel 2 [IDRV_CH__Channel2]
  ///  * [11] : Channel 3 [IDRV_CH__Channel3]
  static const int IDRV_CH = 0x20;
  static const int IDRV_CH__Channel0 = 0x00;
  static const int IDRV_CH__Channel1 = 0x10;
  static const int IDRV_CH__Channel2 = 0x20;
  static const int IDRV_CH__Channel3 = 0x30;

  /// IDRV DC [default: 0]
  ///
  /// Bit setting the current driving waveform
  ///  * [0] : Pulse driver [IDRV_DC__Pulse]
  ///  * [1] : DC driver [IDRV_DC__Dc]
  static const int IDRV_DC = 0x04;
  static const int IDRV_DC__Pulse = 0x00;
  static const int IDRV_DC__Dc = 0x04;

  /// IDRV Voltage Limiter [default: 1]
  ///
  /// Bit enabling the voltage limiter for current output to prevent sensor breakdown
  ///  * [0] : Disable, Output voltage can increase upto VDD [IDRV_VLM_EN__Disable]
  ///  * [1] : Enable, Output voltage is limited to VDAC1 voltage [IDRV_VLM_EN__Enable]
  static const int IDRV_VLM_EN = 0x02;
  static const int IDRV_VLM_EN__Disable = 0x00;
  static const int IDRV_VLM_EN__Enable = 0x02;

  /// IDRV Range [default: 0]
  ///
  /// Bit setting the current output resolution per step
  ///  * [0] : 1 uA / step [IDRV_RNG__1uA]
  ///  * [1] : 8 uA / step [IDRV_RNG__8uA]
  static const int IDRV_RNG = 0x01;
  static const int IDRV_RNG__1uA = 0x00;
  static const int IDRV_RNG__8uA = 0x01;

  /// Address IDRV Value
  ///
  /// Bit position of register:
  ///  * IDRV Value [IDRV_VALUE]
  static const int ADDRESS_IDRV_VALUE = Register.IDRV_VALUE;

  /// IDRV Value [default: 00_0000]
  ///
  /// Value defining the current output value
  /// (in multiple of current step controlled by [IDRV_RNG])
  static const int IDRV_VALUE = 0x3F;

  /// Gets the current `output channel`.
  ///
  ///     [return] output channel.
  ///
  Future<int> getOutputChannel() async =>
      (await register.readBuffer(
        ADDRESS_IDRV_CFG)) & IDRV_CH;

  /// Sets the current `output channel`.
  ///
  ///     [@param] channel: specifies the port bit to be set.
  ///
  /// This parameter can be one of the following values:
  ///
  ///         [IDRV_CH__Channel0]: channel 0
  ///         [IDRV_CH__Channel1]: channel 1
  ///         [IDRV_CH__Channel2]: channel 2
  ///         [IDRV_CH__Channel3]: channel 3
  ///
  Future<void> setOutputChannel(int channel) async {
    await register.writeParams(
      ADDRESS_IDRV_CFG,
      IDRV_CH,
      channel);
  }

  /// Gets the current `driving wave form`.
  ///
  ///     [return] driving wave form.
  ///
  Future<int> getDrivingWaveform() async =>
      (await register.readBuffer(
        ADDRESS_IDRV_CFG)) & IDRV_DC;

  /// Sets the current `driving wave form`.
  ///
  ///     [@param] driver: specifies the port bit to be set.
  ///
  /// This parameter can be one of the following values:
  ///
  ///         [IDRV_DC__Pulse]: pulse driver.
  ///         [IDRV_DC__Dc]: DC driver.
  ///
  Future<void> setDrivingWaveform(int driver) async {
    await register.writeParams(
      ADDRESS_IDRV_CFG,
      IDRV_DC,
      driver);
  }

  /// Checks the `voltage limiter` for current output to prevent sensor breakdown.
  ///
  ///     [return]
  ///         false : [Disable] output voltage can increase upto [VDD]
  ///         true  : [Enable] output voltage is limited to [VDAC1] voltage.
  ///
  Future<bool> isVoltageLimiterEnabled() async =>
      ((await register.readBuffer(
        ADDRESS_IDRV_CFG)) & IDRV_VLM_EN) == IDRV_VLM_EN__Enable;

  /// Sets the `voltage limiter` for current output to prevent sensor breakdown.
  ///
  ///     [@param] enabled: this parameter contains the voltage limiter.
  ///
  /// This parameter can be one of the following values:
  ///
  ///         false : [Disable] output voltage can increase upto [VDD]
  ///         true  : [Enable] output voltage is limited to [VDAC1] voltage.
  ///
  Future<void> setVoltageLimiterEnabled({ bool enabled = true }) async {
    await register.writeParams(
      ADDRESS_IDRV_CFG,
      IDRV_VLM_EN,
      enabled ? IDRV_VLM_EN__Enable : IDRV_VLM_EN__Disable);
  }

  /// Gets the `current output` resolution per step.
  ///
  ///     [return] range output.
  ///
  Future<int> getRangeOutput() async =>
      (await register.readBuffer(
        ADDRESS_IDRV_CFG)) & IDRV_RNG;

  /// Sets the `current output` resolution per step.
  ///
  ///     [@param] range: specifies the port bit to be set.
  ///
  /// This parameter can be one of the following values:
  ///
  ///         [IDRV_RNG__1uA]: 1 uA per step.
  ///         [IDRV_RNG__8uA]: 8 uA per step.
  ///
  Future<void> setRangeOutput(int range) async {
    await register.writeParams(
      ADDRESS_IDRV_CFG,
      IDRV_RNG,
      range);
  }

  /// Gets the `current output` value
  /// (in multiple of current step controlled by `IDRV_RNG`).
  ///
  ///     [return] raw output value.
  ///
  Future<int> getValue() async =>
      (await register.readBuffer(
        ADDRESS_IDRV_CFG)) & IDRV_VALUE;

  /// Sets the `current output` value
  /// (in multiple of current step controlled by `IDRV_RNG`).
  ///
  ///     [@param] value: raw output value.
  ///
  Future<void> setValue(int value) async {
    await register.writeParams(
      ADDRESS_IDRV_VALUE,
      IDRV_VALUE,
      value);
  }
}