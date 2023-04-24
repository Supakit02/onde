part of nfc_sic.chip.sic4341;

class Register extends RegisterProvider {
  Register._(Sic4341 sic4341) : super(sic4341);

  static const int REGISTER_PAGE = 0x1B;

  /// `VDD_RDY_H` and `VDD_RDY_L` is related to flag in
  /// `B_NAK` response describe in RF command section.
  static const int STATUS = 0x00;
  static const int ADC_RESULT_0 = 0x01;
  static const int ADC_RESULT_1 = 0x02;
  static const int ADC_RESULT_2 = 0x03;

  static const int ADC_DIVIDER = 0x04;
  static const int ADC_PRESCALER = 0x05;
  static const int ADC_SAMP_DLY = 0x06;
  static const int ADC_NWAIT = 0x07;

  /// For conversion time calculation.
  ///
  /// Tconv (approx.) = ((`NWait_CLK` + (`OSR` x (`AVG` + 1))) / `Fs`)
  static const int ADC_NBIT = 0x08;
  static const int ADC_CONV_CFG = 0x09;

  /// `ADC_BUFN_EN` and `ADC_BUFP_En` are register page
  /// setting only, the actual control signals are
  /// controlled by digital state machine and device mode.
  ///
  /// The actual controls signal can be set to `1` only when
  /// `VDD_L_Flag` is `0`.
  static const int ADC_BUF_CFG = 0x0A;

  /// All data are register page setting only, the actual
  /// control signals are controlled by state machine.
  ///
  /// If `ADC_CHP` or `ADC_CHN` is set to `11`, that means
  /// the input is not connected to any `GPIO`.
  static const int ADC_CH_CFG = 0x0B;

  /// All data are register page setting only, the actual
  /// control signals are controlled by state machine and
  /// device mode.
  static const int IDRV_CFG = 0x0C;

  /// `IDRV_VALUE` is register page setting only. The actual
  /// control signals are controlled by state machine and
  /// device mode.
  static const int IDRV_VALUE = 0x0D;

  /// `DAC1_Value` is register page setting only. The actual
  /// control signals are controlled by state machine and
  /// device mode.
  ///
  /// When `ADC` is set to `TICK_Mode`, `DAC1` that sent to
  /// analog is updated every tick period. It is not immediately
  /// when `WrReg` is executed.
  static const int DAC1_VALUE = 0x0E;

  /// `DAC2_Value` is register page setting only. The actual
  /// control signals are controlled by state machine and
  /// device mode.
  ///
  /// When `ADC` is set to `TICK_Mode`, `DAC1` that sent to
  /// analog is updated every tick period. It is not immediately
  /// when `WrReg` is executed.
  static const int DAC2_VALUE = 0x0F;

  /// All data are register page setting only. The actual
  /// control signals are controlled by state machine and
  /// device mode.
  ///
  /// `DAC2_BUF_EN` and `DAC1_BUF_EN` actual signal can be
  /// set to `1` only when `VDD_L_Flag` is `0`.
  ///
  /// If `Channel` selection is set to `11`. That means the
  /// input is not connected to any `GPIO`.
  static const int DAC_CFG = 0x10;

  /// All data are register page setting only. The actual
  /// control signals are controlled by state machine and
  /// device mode.
  static const int CHEM_CFG = 0x11;

  static const int VDD_CFG = 0x13;

  /// All data are register page setting only, the actual
  /// control signals are controlled by state machine and
  /// device mode.
  static const int TEMPSEN_CFG = 0x14;

  /// All data are register page setting only. The actual
  /// control signals are controlled by state machine and
  /// device mode.
  static const int GPIO_MODE = 0x16;

  /// When `GPIO` Mode is not configured to `INPUT` mode,
  /// `GPIO_IN` will return `0000`.
  static const int GPIO_INOUT = 0x17;

  /// All data are register page setting only, the actual
  /// control signals are controlled by state machine and
  /// device mode.
  static const int SENSOR_CFG = 0x18;
  static const int GAP_WID_CFG = 0x19;

  static const int TEST = 0x1B;

  @override
  int getRegisterPage() => REGISTER_PAGE;

  static String getName(int address) {
    switch (address) {
      case STATUS:
        return "Status";

      case ADC_RESULT_2:
        return "ADC Result 2[23:16]";

      case ADC_RESULT_1:
        return "ADC Result 1[15:8]";

      case ADC_RESULT_0:
        return "ADC Result 0[7:0]";

      case ADC_DIVIDER:
        return "ADC Divider (M)";

      case ADC_PRESCALER:
        return "ADC Prescaler (N)";

      case ADC_SAMP_DLY:
        return "ADC Sampling Delay Time";

      case ADC_NWAIT:
        return "ADC Nwait Time";

      case ADC_NBIT:
        return "ADC NBit";

      case ADC_CONV_CFG:
        return "ADC Convert Configuration";

      case ADC_BUF_CFG:
        return "ADC Buffer Configuration";

      case ADC_CH_CFG:
        return "ADC Channel Configuration";

      case IDRV_CFG:
        return "IDRV Configuration";

      case IDRV_VALUE:
        return "IDRV Value";

      case DAC1_VALUE:
        return "DAC Value 1 [7:0]";

      case DAC2_VALUE:
        return "DAC Value 2 [7:0]";

      case DAC_CFG:
        return "DAC Configuration";

      case CHEM_CFG:
        return "Chemical Configuration";

      case VDD_CFG:
        return "Voltage Configuration";

      case TEMPSEN_CFG:
        return "Temperature Sensor Configuration";

      case GPIO_MODE:
        return "GPIO Mode";

      case GPIO_INOUT:
        return "GPIO Input/Output";

      case SENSOR_CFG:
        return "Sensor Configuration";

      case GAP_WID_CFG:
        return "Gap Width Configuration";

      case TEST:
        return "Test";

      default:
        return "RFU";
    }
  }

  static RegisterType getRegisterType(int address) {
    switch (address) {
      case STATUS:
        return RegisterType.READ_ONLY_STATUS;

      case ADC_RESULT_0:
      case ADC_RESULT_1:
      case ADC_RESULT_2:
        return RegisterType.READ_ONLY;

      case ADC_DIVIDER:
      case ADC_PRESCALER:
      case ADC_SAMP_DLY:
      case ADC_NWAIT:
      case ADC_NBIT:
      case IDRV_VALUE:
      case DAC1_VALUE:
      case DAC2_VALUE:
      case GPIO_MODE:
      case GPIO_INOUT:
      case TEST:
        return RegisterType.READ_WRITE;

      case ADC_CONV_CFG:
      case ADC_BUF_CFG:
      case ADC_CH_CFG:
      case IDRV_CFG:
      case DAC_CFG:
      case CHEM_CFG:
      case VDD_CFG:
      case TEMPSEN_CFG:
      case SENSOR_CFG:
      case GAP_WID_CFG:
        return RegisterType.READ_WRITE_CONFIG;

      default:
        return RegisterType.RFU;
    }
  }
}