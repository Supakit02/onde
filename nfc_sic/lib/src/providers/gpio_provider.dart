part of nfc_sic.providers;

abstract class GpioProvider {
  @protected
  GpioProvider(SicChip chip)
    : _register = chip.getRegister(),
      _addressGpioMode = <int>[
        ADDRESS_GPIO_MODE_0,
        ADDRESS_GPIO_MODE_1,
        ADDRESS_GPIO_MODE_2,
      ];

  static const int ADDRESS_MODE_0 = 0;
  static const int ADDRESS_MODE_1 = 1;
  static const int ADDRESS_MODE_2 = 2;

  static const int ADDRESS_GPIO_MODE_0 = 0x16;
  static const int ADDRESS_GPIO_MODE_1 = 0x16;
  static const int ADDRESS_GPIO_MODE_2 = 0x16;

  static const int ADDRESS_GPIO_IN = 0x17;
  static const int ADDRESS_GPIO_OUT = 0x17;

  static const int LOW_LEVEL = 0;
  static const int HIGH_LEVEL = 1;

  static const int PIN_0 = 0x01;
  static const int PIN_1 = 0x02;
  static const int PIN_2 = 0x04;
  static const int PIN_3 = 0x08;
  static const int PIN_4 = 0x10;
  static const int PIN_5 = 0x20;
  static const int PIN_6 = 0x40;
  static const int PIN_7 = 0x80;

  static const int PIN_LNib = 0x0F;
  static const int PIN_HNib = 0xF0;
  static const int PIN_ALL = 0xFF;

  static int pinPowerReady;
  static int pinRFBusy;
  static int pinRFDetected;

  final RegisterProvider _register;
  final List<int> _addressGpioMode;

  RegisterProvider get register => _register;

  /// Gets the `GpioProvider` mode according to the specified parameters.
  ///
  ///     [@param] GPIO_Address_Mode: select the address mode.
  ///
  /// This parameter can be one of the following values:
  ///
  ///         [Address_Mode_0]: address mode 0
  ///         [Address_Mode_1]: address mode 1
  ///         [Address_Mode_2]: address mode 2
  ///
  ///     [return] byte [GpioProvider] mode data port value.
  ///
  Future<int> getMode(int gpioAddressMode) =>
      register.readBuffer(
        _addressGpioMode[gpioAddressMode]);

  /// Sets the `GpioProvider` mode according to the specified parameters.
  ///
  ///     [@param] GPIO_Address_Mode: select the address mode.
  ///
  /// This parameter can be one of the following values:
  ///
  ///         [Address_Mode_0]: address mode 0
  ///         [Address_Mode_1]: address mode 1
  ///         [Address_Mode_2]: address mode 2
  ///
  ///     [@param] GPIO_Pin_Mode: specifies the value to be set to the gpio mode register.
  ///
  Future<void> setMode(int gpioAddressMode, int gpioPinMode) async {
    await register.write(
      _addressGpioMode[gpioAddressMode],
      gpioPinMode);
  }

  /// Sets the `GpioProvider` mode bit according to the specified parameters.
  ///
  ///     [@param] GPIO_Address_Mode: select the address mode.
  ///
  /// This parameter can be one of the following values:
  ///
  ///         [Address_Mode_0]: address mode 0
  ///         [Address_Mode_1]: address mode 1
  ///         [Address_Mode_2]: address mode 2
  ///
  ///     [@param] GPIO_Pin: specifies the port bit to be set.
  ///
  /// This parameter can be any combination of the following values:
  ///
  ///         [Pin_0]: pin 0
  ///         [Pin_1]: pin 1
  ///         [Pin_2]: pin 2
  ///         [Pin_3]: pin 3
  ///         [Pin_4]: pin 4
  ///         [Pin_5]: pin 5
  ///         [Pin_6]: pin 6
  ///         [Pin_7]: pin 7
  ///         [Pin_LNib]: low nibble pins
  ///         [Pin_HNib]: high nibble pins
  ///         [Pin_All]: all pins
  ///
  ///     [@param] GPIO_Pin_Mode: specifies the value to be set to the gpio mode register.
  ///
  /// This parameter can be `High_Level` or `Low_Level`
  ///
  Future<void> setModePin(int gpioAddressMode, int gpioPin, int gpioPinMode) async {
    var _mode = await register.readBuffer(
      _addressGpioMode[gpioAddressMode]);

    if ( gpioPinMode == LOW_LEVEL ) {
      _mode &= ~gpioPin;
    } else {
      _mode |= gpioPin;
    }

    await register.write(
      _addressGpioMode[gpioAddressMode],
      _mode);
  }

  /// Gets the specified `GpioProvider` output data port.
  /// The port must be configured in output mode.
  ///
  ///     [return] byte [GpioProvider] output data port value.
  ///
  Future<int> getOutput() =>
      register.readBuffer(
        ADDRESS_GPIO_OUT);

  /// Sets data to the specified `GpioProvider` data port.
  /// The port must be configured in output mode.
  ///
  ///     [@param] GPIO_PortVal: specifies the value to be set to the port output data register.
  ///
  Future<void> setOutput(int gpioPortVal) async {
    await register.write(
      ADDRESS_GPIO_OUT,
      gpioPortVal);
  }

  /// Sets or clears the selected data port bit.
  ///
  ///     [@param] GPIO_Pin: specifies the port bit to be set.
  ///
  /// This parameter can be any combination of the following values:
  ///
  ///         [Pin_0]: pin 0
  ///         [Pin_1]: pin 1
  ///         [Pin_2]: pin 2
  ///         [Pin_3]: pin 3
  ///         [Pin_4]: pin 4
  ///         [Pin_5]: pin 5
  ///         [Pin_6]: pin 6
  ///         [Pin_7]: pin 7
  ///         [Pin_LNib]: low nibble pins
  ///         [Pin_HNib]: high nibble pins
  ///         [Pin_All]: all pins
  ///
  ///     [@param] GPIO_BitVal: specifies the desired status to be set.
  ///
  /// This parameter can be `High_Level` or `Low_Level`
  ///
  Future<void> setOutputPin(int gpioPin, int gpioBitVal) async {
    var _output = await register.readBuffer(
      ADDRESS_GPIO_OUT);

    if ( gpioBitVal == LOW_LEVEL ) {
      _output &= ~gpioPin;
    } else {
      _output |= gpioPin;
    }

    await register.write(
      ADDRESS_GPIO_OUT,
      _output);
  }

  /// Sets the specified `GpioProvider` input data port.
  /// The port must be configured in input mode.
  ///
  ///     [return] byte [GpioProvider] input data port value.
  ///
  Future<int> getInput() async {
    final _recv = await register.read(
      ADDRESS_GPIO_IN);

    if ( _recv == null ) {
      throw OthersException(
        code: "getInput(GpioProvider)",
        message: "Can not get GpioProvider input.",
        stackTrace: StackTrace.current);
    }

    return _recv;
  }

  /// Gets the specified `GpioProvider` input data pin.
  /// The pin must be configured in input mode.
  ///
  ///     [@param] GPIO_Pin: this parameter contains the pin number.
  ///
  /// This parameter can be any combination of the following values:
  ///
  ///         [Pin_0]: pin 0
  ///         [Pin_1]: pin 1
  ///         [Pin_2]: pin 2
  ///         [Pin_3]: pin 3
  ///         [Pin_4]: pin 4
  ///         [Pin_5]: pin 5
  ///         [Pin_6]: pin 6
  ///         [Pin_7]: pin 7
  ///         [Pin_LNib]: low nibble pins
  ///         [Pin_HNib]: high nibble pins
  ///         [Pin_All]: all pins
  ///
  ///     [return] [BitStatus] [GpioProvider] input pin status.
  ///
  Future<int> getInputPin(int gpioPin) async {
    final _recv = await register.read(
      ADDRESS_GPIO_IN);

    if ( _recv == null ) {
      throw OthersException(
        code: "getInputPin(GpioProvider)",
        message: "Can not get GpioProvider input.",
        stackTrace: StackTrace.current);
    }

    if ( (_recv & gpioPin) == gpioPin ) {
      return HIGH_LEVEL;
    }

    return LOW_LEVEL;
  }

  /// Set high level to the specified `GpioProvider` pins.
  /// The pin must be configured in output mode.
  ///
  ///     [@param] GPIO_Pin: specifies the pins to be turned high.
  ///
  /// This parameter can be any combination of the following values:
  ///
  ///         [Pin_0]: pin 0
  ///         [Pin_1]: pin 1
  ///         [Pin_2]: pin 2
  ///         [Pin_3]: pin 3
  ///         [Pin_4]: pin 4
  ///         [Pin_5]: pin 5
  ///         [Pin_6]: pin 6
  ///         [Pin_7]: pin 7
  ///         [Pin_LNib]: low nibble pins
  ///         [Pin_HNib]: high nibble pins
  ///         [Pin_All]: all pins
  ///
  Future<void> setHighOutput(int gpioPin) async {
    await setOutputPin(
      gpioPin,
      HIGH_LEVEL);
  }

  /// Set low level to the specified `GpioProvider` pins.
  /// The pin must be configured in output mode.
  ///
  ///     [@param] GPIO_Pin: specifies the pins to be turned low.
  ///
  /// This parameter can be any combination of the following values:
  ///
  ///         [Pin_0]: pin 0
  ///         [Pin_1]: pin 1
  ///         [Pin_2]: pin 2
  ///         [Pin_3]: pin 3
  ///         [Pin_4]: pin 4
  ///         [Pin_5]: pin 5
  ///         [Pin_6]: pin 6
  ///         [Pin_7]: pin 7
  ///         [Pin_LNib]: low nibble pins
  ///         [Pin_HNib]: high nibble pins
  ///         [Pin_All]: all pins
  ///
  Future<void> setLowOutput(int gpioPin) async {
    await setOutputPin(
      gpioPin,
      LOW_LEVEL);
  }

  /// Toggles the specified `GpioProvider` pins.
  /// The pin must be configured in output mode.
  ///
  ///     [@param] GPIO_Pin: specifies the pins to be toggled data register.
  ///
  /// This parameter can be any combination of the following values:
  ///
  ///         [Pin_0]: pin 0
  ///         [Pin_1]: pin 1
  ///         [Pin_2]: pin 2
  ///         [Pin_3]: pin 3
  ///         [Pin_4]: pin 4
  ///         [Pin_5]: pin 5
  ///         [Pin_6]: pin 6
  ///         [Pin_7]: pin 7
  ///         [Pin_LNib]: low nibble pins
  ///         [Pin_HNib]: high nibble pins
  ///         [Pin_All]: all pins
  ///
  Future<void> setToggleOutput(int gpioPin) async {
    final _output = await getOutput();

    final _sel = gpioPin & ~_output;
    final _uns = ~gpioPin & _output;

    await setOutput(_sel | _uns);
  }
}