part of nfc_sic.chip.sic4341;

class Gpio extends GpioProvider {
  Gpio._(Sic4341 sic4341): super(sic4341);

  @override
  Future<int> getOutput() async =>
      ((await register.readBuffer(
        GpioProvider.ADDRESS_GPIO_OUT)) >> 4) & 0x0F;

  @override
  Future<void> setOutput(int gpioPortVal) async {
    await register.write(
      GpioProvider.ADDRESS_GPIO_OUT,
      (gpioPortVal << 4) & 0xF0);
  }

  @override
  Future<void> setOutputPin(int gpioPin, int gpioBitVal) async {
    final _pin = (gpioPin << 4) & 0xF0;
    var _output = (await register.readBuffer(
      GpioProvider.ADDRESS_GPIO_OUT)) & 0xF0;

    if ( gpioBitVal == GpioProvider.LOW_LEVEL ) {
      _output &= ~_pin;
    } else {
      _output |= _pin;
    }

    await register.write(
      GpioProvider.ADDRESS_GPIO_OUT,
      _output & 0xF0);
  }

  @override
  Future<int> getInput() async {
    final _recv = await register.read(
      GpioProvider.ADDRESS_GPIO_IN);

    if ( _recv == null ) {
      throw OthersException(
        code: "getInput(GpioProvider)",
        message: "Can not get Gpio input.",
        stackTrace: StackTrace.current);
    }

    return _recv & 0x0F;
  }

  @override
  Future<int> getInputPin(int gpioPin) async {
    final _recv = await register.read(
      GpioProvider.ADDRESS_GPIO_IN);

    if ( _recv == null ) {
      throw OthersException(
        code: "getInputPin(GpioProvider)",
        message: "Can not get Gpio input.",
        stackTrace: StackTrace.current);
    }

    final _input = _recv & 0x0F;
    final _pin = gpioPin & 0x0F;

    if ( (_input & _pin) == _pin ) {
      return GpioProvider.HIGH_LEVEL;
    }

    return GpioProvider.LOW_LEVEL;
  }

  @override
  Future<void> setHighOutput(int gpioPin) async {
    await setOutputPin(
      gpioPin & 0x0F,
      GpioProvider.HIGH_LEVEL);
  }

  @override
  Future<void> setLowOutput(int gpioPin) async {
    await setOutputPin(
      gpioPin & 0x0F,
      GpioProvider.LOW_LEVEL);
  }

  @override
  Future<void> setToggleOutput(int gpioPin) async {
    final _pin = gpioPin & 0x0F;

    final _output = await getOutput();

    final _sel = _pin & ~_output;
    final _uns = ~_pin & _output;

    await setOutput(
      (_sel | _uns) << 4);
  }

  /// Get the gpio mode register directly.
  ///
  ///     [return] byte gpio mode data port value.
  ///
  @override
  Future<int> getMode([ int number ]) =>
      super.getMode(
        GpioProvider.ADDRESS_MODE_0);

  /// Sets the gpio mode register directly.
  ///
  ///     [@param] GPIO_Mode: specifies the value to be set to the gpio mode register.
  ///
  /// This parameter can be any combination of the following values:
  ///
  ///         At [GPIO_MODE_1] bit (7:4)
  ///            [0]: gpio [3:0] pin is digital.
  ///            [1]: gpio [3:0] pin is analog.
  ///         At [GPIO_MODE_0] bit (3:0) when [GPIO_MODE_1] is [Mode_DigitalFunction]
  ///            [0]: gpio [3:0] pin is digital input.
  ///            [1]: gpio [3:0] pin is digital output.
  ///
  @override
  Future<void> setMode(int gpioMode, [ int number ]) =>
      super.setMode(
        GpioProvider.ADDRESS_MODE_0,
        gpioMode);

  /// Sets the Gpio mode according to the specified parameters.
  ///
  ///     [@param] GPIO_Pin: specifies the port bit to be set.
  ///
  /// This parameter can be any combination of the following values:
  ///
  ///         [Pin_0]: pin 0
  ///         [Pin_1]: pin 1
  ///         [Pin_2]: pin 2
  ///         [Pin_3]: pin 3
  ///         [Pin_All]: all pins
  ///
  ///     [@param] GPIO_Mode: Specifies the value to be set to the gpio mode register.
  ///
  /// Each bit can be one of the following values:
  ///
  ///         At [GPIO_MODE_1] bit (7:4)
  ///            [0]: gpio [3:0] pin is digital.
  ///            [1]: gpio [3:0] pin is analog.
  ///         At [GPIO_MODE_0] bit (3:0) when [GPIO_MODE_1] is [Mode_DigitalFunction]
  ///            [0]: gpio [3:0] pin is digital input.
  ///            [1]: gpio [3:0] pin is digital output.
  ///
  @override
  Future<void> setModePin(int gpioPin, int gpioMode, [ int number ]) =>
      super.setModePin(
        GpioProvider.ADDRESS_MODE_0,
        (gpioPin << 4) | gpioPin,
        gpioMode);

  /// Sets the Gpio according to the Gpio digital input mode.
  ///
  ///     [@param] GPIO_Pin: specifies the port bit to be set.
  ///
  /// This parameter can be any combination of the following values:
  ///
  ///         [Pin_0]: pin 0
  ///         [Pin_1]: pin 1
  ///         [Pin_2]: pin 2
  ///         [Pin_3]: pin 3
  ///         [Pin_All]: all pins
  ///
  Future<void> setGpioDigitalInput(int gpioPin) async {
    final _pin = gpioPin & 0x0F;

    final _modeX = (_pin << 4) | _pin;
    final _mode = (await register.readBuffer(
      GpioProvider.ADDRESS_GPIO_MODE_0)) & ~_modeX;

    await register.write(
      GpioProvider.ADDRESS_GPIO_MODE_0,
      _mode);
  }

  /// Sets the Gpio according to the Gpio digital output mode.
  ///
  ///     [@param] GPIO_Pin: specifies the port bit to be set.
  ///
  /// This parameter can be any combination of the following values:
  ///
  ///         [Pin_0]: pin 0
  ///         [Pin_1]: pin 1
  ///         [Pin_2]: pin 2
  ///         [Pin_3]: pin 3
  ///         [Pin_All]: all pins
  ///
  Future<void> setGpioDigitalOutput(int gpioPin) async {
    final _pin = gpioPin & 0x0F;

    final _mode0 = _pin & 0x0F;
    final _mode1 = (_pin << 4) & 0xF0;

    final _mode = (await register.readBuffer(
      GpioProvider.ADDRESS_GPIO_MODE_0)) | _mode0 & ~_mode1;

    await register.write(
      GpioProvider.ADDRESS_GPIO_MODE_0,
      _mode);
  }

  /// Sets the Gpio according to the Analog function output mode.
  ///
  ///     [@param] GPIO_Pin: specifies the port bit to be set.
  ///
  /// This parameter can be any combination of the following values:
  ///
  ///         [Pin_0]: pin 0
  ///         [Pin_1]: pin 1
  ///         [Pin_2]: pin 2
  ///         [Pin_3]: pin 3
  ///         [Pin_All]: all pins
  ///
  Future<void> setAnalogFunctionMode(int gpioPin) async {
    final _mode1 = ((gpioPin & 0x0F) << 4) & 0xF0;
    final _mode = (await register.readBuffer(
      GpioProvider.ADDRESS_GPIO_MODE_0)) | _mode1;

    await register.write(
      GpioProvider.ADDRESS_GPIO_MODE_0,
      _mode);
  }
}