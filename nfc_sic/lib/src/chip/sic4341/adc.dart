part of nfc_sic.chip.sic4341;

class Adc extends ChipProvider {
  Adc._(Sic4341 sic4341): super(sic4341);

  /// ADC Conversion result
  static const int ADDRESS_ADC_RESULT_0 = Register.ADC_RESULT_0;
  /// ADC Conversion result
  static const int ADDRESS_ADC_RESULT_1 = Register.ADC_RESULT_1;
  /// ADC Conversion result
  static const int ADDRESS_ADC_RESULT_2 = Register.ADC_RESULT_2;

  /// Address ADC Divider
  ///
  /// Bit position of register:
  ///  * ADC Divider [ADC_DIVIDER]
  static const int ADDRESS_ADC_DIVIDER = Register.ADC_DIVIDER;

  /// ADC Divider [default: 1101_0011]
  ///
  /// Define ADC sampling frequency
  ///
  /// Fs (Hz) = 13.56M / ((2^`P`) * (128 + `D`))
  static const int ADC_DIVIDER = 0xFF;

  /// Address ADC Prescaler
  ///
  /// Bit position of register:
  ///  * ADC Prescaler [ADC_PRESCALER]
  static const int ADDRESS_ADC_PRESCALER = Register.ADC_PRESCALER;

  /// ADC Prescaler [default: 0000_0010]
  ///
  /// Value that defines ADC sampling frequency
  ///
  /// Fs (Hz) = 13.56M / ((2^`P`) * (128 + `D`))
  static const int ADC_PRESCALER = 0x07;

  /// Address ADC Samp Delay
  ///
  /// Bit position of register:
  ///  * ADC Samp Delay Time [ADC_SAMP_DELAY_TIME]
  static const int ADDRESS_ADC_SAMP_DELAY = Register.ADC_SAMP_DLY;

  /// ADC Samp Delay Time [default: 0101_0100]
  ///
  /// Value that defines ADC sampling time for reach sampling period
  ///
  /// Tsamp (s) = ((2^`P`) * (`Ts` + 1)) / 13.56M
  static const int ADC_SAMP_DELAY_TIME = 0xFF;

  /// Address ADC NWait
  ///
  /// Bit position of register:
  ///  * Nwait Mul (M) [NWAIT_MUL]
  ///  * Nwait Prescaler (N) [NWAIT_PRESCALER]
  static const int ADDRESS_ADC_NWAIT = Register.ADC_NWAIT;

  /// Nwait Mul (M) [default: 0000]
  ///
  /// Value that defines number of sampling clock before ADC process the input data
  ///
  /// NWait_CLK = 8 + (`M` * (2^`N`))
  static const int NWAIT_MUL = 0xF0;

  /// Nwait Prescaler (N) [default: 0000]
  ///
  /// Value that defines number of sampling clock before ADC process the input data
  ///
  /// NWait_CLK = 8 + (`M` * (2^`N`))
  static const int NWAIT_PRESCALER = 0x0F;

  /// Address ADC NBit
  ///
  /// Bit position of register:
  ///  * ADC Average [ADC_AVG]
  ///  * ADC Signed [ADC_SIGNED]
  ///  * ADC Oversampling Ratio [ADC_OSR]
  static const int ADDRESS_ADC_NBIT = Register.ADC_NBIT;

  /// ADC Average [default: 010]
  ///
  /// Value that defines number of average time for ADC Result
  ///  * [000] : 1 times [ADC_AVG__Time_1]
  ///  * [001] : 2 times [ADC_AVG__Time_2]
  ///  * [010] : 4 times [ADC_AVG__Time_4]
  ///  * [011] : 8 times [ADC_AVG__Time_8]
  ///  * [100] : 16 times [ADC_AVG__Time_16]
  ///  * [101] : 32 times [ADC_AVG__Time_32]
  ///  * [110] : 64 times [ADC_AVG__Time_64]
  ///  * [111] : 128 times [ADC_AVG__Time_128]
  static const int ADC_AVG = 0x70;
  static const int ADC_AVG__Time_1 = 0x00;
  static const int ADC_AVG__Time_2 = 0x10;
  static const int ADC_AVG__Time_4 = 0x20;
  static const int ADC_AVG__Time_8 = 0x30;
  static const int ADC_AVG__Time_16 = 0x40;
  static const int ADC_AVG__Time_32 = 0x50;
  static const int ADC_AVG__Time_64 = 0x60;
  static const int ADC_AVG__Time_128 = 0x70;

  /// ADC Signed [default: 1]
  ///
  /// Bit that defines the pattern of ADC_Result
  ///  * [0] : unsigned bit [ADC_SIGNED__Unsigned]
  ///  * [1] : signed bit [ADC_SIGNED__Signed]
  static const int ADC_SIGNED = 0x08;
  static const int ADC_SIGNED__Unsigned = 0x00;
  static const int ADC_SIGNED__Signed = 0x08;

  /// ADC Oversampling Ratio [default: 011]
  ///
  /// Value that defines number of Oversampling Ratio (OSR) of ADC, Number of valid bit for `ADC_Result <23:0>`
  ///  * [000] : OSR = 32, valid result = 6 bit [ADC_OSR__32_6b]
  ///  * [001] : OSR = 64, valid result = 8 bit [ADC_OSR__64_8b]
  ///  * [010] : OSR = 128, valid result = 10 bit [ADC_OSR__128_10b]
  ///  * [011] : OSR = 256, valid result = 12 bit [ADC_OSR__256_12b]
  ///  * [100] : OSR = 512, valid result = 14 bit [ADC_OSR__512_14b]
  ///  * [101] : OSR = 1024, valid result = 14 bit [ADC_OSR__1024_14b]
  ///  * [110] : OSR = 2048, valid result = 14 bit [ADC_OSR__2048_14b]
  ///  * [111] : OSR = 4096, valid result = 14 bit [ADC_OSR__4096_14b]
  static const int ADC_OSR = 0x07;
  static const int ADC_OSR__32_6b = 0x00;
  static const int ADC_OSR__64_8b = 0x01;
  static const int ADC_OSR__128_10b = 0x02;
  static const int ADC_OSR__256_12b = 0x03;
  static const int ADC_OSR__512_14b = 0x04;
  static const int ADC_OSR__1024_14b = 0x05;
  static const int ADC_OSR__2048_14b = 0x06;
  static const int ADC_OSR__4096_14b = 0x07;

  /// Address ADC Conversion Config
  ///
  /// Bit position of register:
  ///  * ADC Tick Period [ADC_TICK_TIME_PERIOD]
  ///  * ADC Tick Response [ADC_TICK_RSP]
  ///  * ADC Conversion Mode [ADC_CONV_MODE]
  static const int ADDRESS_ADC_CONV_CFG = Register.ADC_CONV_CFG;

  /// ADC Tick Period [default: 000]
  ///
  /// Values define the period of ADC sampling when ADC_CONV_Mode is configured to TICK Mode
  ///  * [000] : 50 ms [ADC_TICK_TIME_PERIOD__50ms]
  ///  * [001] : 100 ms [ADC_TICK_TIME_PERIOD__100ms]
  ///  * [010] : 200 ms [ADC_TICK_TIME_PERIOD__200ms]
  ///  * [011] : 500 ms [ADC_TICK_TIME_PERIOD__500ms]
  ///  * [100] : 1000 ms [ADC_TICK_TIME_PERIOD__1000ms]
  ///  * [101] : 2000 ms [ADC_TICK_TIME_PERIOD__2000ms]
  ///  * [110] : 5000 ms [ADC_TICK_TIME_PERIOD__5000ms]
  ///  * [111] : 10000 ms [ADC_TICK_TIME_PERIOD__10000ms]
  static const int ADC_TICK_TIME_PERIOD = 0x70;
  static const int ADC_TICK_TIME_PERIOD__50ms = 0x00;
  static const int ADC_TICK_TIME_PERIOD__100ms = 0x10;
  static const int ADC_TICK_TIME_PERIOD__200ms = 0x20;
  static const int ADC_TICK_TIME_PERIOD__500ms = 0x30;
  static const int ADC_TICK_TIME_PERIOD__1000ms = 0x40;
  static const int ADC_TICK_TIME_PERIOD__2000ms = 0x50;
  static const int ADC_TICK_TIME_PERIOD__5000ms = 0x60;
  static const int ADC_TICK_TIME_PERIOD__10000ms = 0x70;

  /// ADC Tick Response [default: 0]
  ///
  /// Bit that set the response pattern for `Get_ADC` command when configured to TICK Mode
  ///  * [0] : Response immediately after `Get_ADC` command [ADC_TICK_RSP__Immediately]
  ///  * [1] : Response at tick period [ADC_TICK_RSP__AtTickPeriod]
  static const int ADC_TICK_RSP = 0x04;
  static const int ADC_TICK_RSP__Immediately = 0x00;
  static const int ADC_TICK_RSP__AtTickPeriod = 0x04;

  /// ADC Conversion Mode [default: 00]
  ///
  /// Bits that configures the ADC conversion method
  ///  * [0X] : `Normal` Mode | ADC is converted when Get_ADC is executed [ADC_CONV_MODE__Normal]
  ///  * [10] : `Continuous` Mode | ADC is continuously converted [ADC_CONV_MODE__Continuous]
  ///  * [11] : `Tick` Mode | ADC is automatically converted every tick period [ADC_CONV_MODE__Tick]
  static const int ADC_CONV_MODE = 0x03;
  static const int ADC_CONV_MODE__Normal = 0x00;
  static const int ADC_CONV_MODE__Continuous = 0x02;
  static const int ADC_CONV_MODE__Tick = 0x03;

  /// Address ADC Buffer Config
  ///
  /// Bit position of register:
  ///  * ADC Buffer - N side [ADC_BUFN_EN]
  ///  * ADC Buffer - P side [ADC_BUFP_EN]
  ///  * ADC Low Pass Filter [ADC_LPF]
  static const int ADDRESS_ADC_BUFF_CFG = Register.ADC_BUF_CFG;

  /// ADC Buffer - N side [default: 0]
  ///
  /// Bit enabling ADC input BUFFER – N side
  ///  * [0] : Disable [ADC_BUFN_EN__Disable]
  ///  * [1] : Enable [ADC_BUFN_EN__Enable]
  static const int ADC_BUFN_EN = 0x20;
  static const int ADC_BUFN_EN__Disable = 0x00;
  static const int ADC_BUFN_EN__Enable = 0x20;

  /// ADC Buffer - P side [default: 0]
  ///
  /// Bit enabling ADC input BUFFER – P side
  ///  * [0] : Disable [ADC_BUFP_EN__Disable]
  ///  * [1] : Enable [ADC_BUFP_EN__Enable]
  static const int ADC_BUFP_EN = 0x10;
  static const int ADC_BUFP_EN__Disable = 0x00;
  static const int ADC_BUFP_EN__Enable = 0x10;

  /// ADC Low Pass Filter [default: 01]
  ///
  /// Value setting input low pass filter for ADC
  ///  * [00] : Single Ended = No LPF, Diff Mode = No LPF [ADC_LPF__None]
  ///  * [01] : Single Ended = 1260 kHz, Diff Mode = 1060 kHz [ADC_LPF__S1260_D1060]
  ///  * [10] : Single Ended = 623 kHz, Diff Mode = 530 kHz [ADC_LPF__S623_D530]
  ///  * [11] : Single Ended = 325 kHz, Diff Mode = 280 kHz [ADC_LPF__S325_D280]
  static const int ADC_LPF = 0x03;
  static const int ADC_LPF__None = 0x00;
  static const int ADC_LPF__S1260_D1060 = 0x01;
  static const int ADC_LPF__S623_D530 = 0x02;
  static const int ADC_LPF__S325_D280 = 0x03;

  /// Address ADC Channel Config
  ///
  /// Bit position of register:
  ///  * [ADC_CHN_GND]
  ///  * [ADC_CHN]
  ///  * [ADC_CHP]
  static const int ADDRESS_ADC_CH_CFG = Register.ADC_CH_CFG;

  /// ADC Low Pass Filter [default: 0]
  ///
  /// Bit controlling the ADC input
  ///  * [0] : Differential mode [ADC_CHN_GND__DifferentialMode]
  ///  * [1] : Single ended mode (Channel N is internal connected to GND) [ADC_CHN_GND__SingleEndedMode]
  static const int ADC_CHN_GND = 0x10;
  static const int ADC_CHN_GND__DifferentialMode = 0x00;
  static const int ADC_CHN_GND__SingleEndedMode = 0x10;

  /// ADC Input - N channel [default: 11]
  ///
  /// Value that define the ADC input - N channel
  ///  * [00] : Channel 0 [ADC_CHN__Channel0]
  ///  * [01] : Channel 1 [ADC_CHN__Channel1]
  ///  * [10] : Channel 2 [ADC_CHN__Channel2]
  ///  * [11] : Channel 3 [ADC_CHN__Channel3]
  static const int ADC_CHN = 0x0C;
  static const int ADC_CHN__Channel0 = 0x00;
  static const int ADC_CHN__Channel1 = 0x04;
  static const int ADC_CHN__Channel2 = 0x08;
  static const int ADC_CHN__Channel3 = 0x0C;

  /// ADC Input - P channel [default: 11]
  ///
  /// Value that define the ADC input - P channel
  ///  * [00] : Channel 0 [ADC_CHP__Channel0]
  ///  * [01] : Channel 1 [ADC_CHP__Channel1]
  ///  * [10] : Channel 2 [ADC_CHP__Channel2]
  ///  * [11] : Channel 3 [ADC_CHP__Channel3]
  static const int ADC_CHP = 0x03;
  static const int ADC_CHP__Channel0 = 0x00;
  static const int ADC_CHP__Channel1 = 0x01;
  static const int ADC_CHP__Channel2 = 0x02;
  static const int ADC_CHP__Channel3 = 0x03;

  /// Gets the convert adc protocol.
  ///
  ///     [return] byte array [Uint8List], [ConvADC] command.
  ///
  static Uint8List getPackageConvAdc() =>
      Uint8List.fromList([ 0xB8, 0x00 ]);

  /// Returns the data conversion of `SIC's` chip.
  ///
  ///     [return] byte array [List<int>], response flag and adc data from [NFC] tag.
  ///
  Future<List<int>> convADC() =>
      chip.autoTransceive(getPackageConvAdc());

  /// Gets the adc sampling frequency.
  ///
  ///     [return] adc sampling frequency.
  ///
  Future<int> getSamplingFrequency() async {
    final d = await register.readBuffer(
      ADDRESS_ADC_DIVIDER);
    final p = (await register.readBuffer(
      ADDRESS_ADC_PRESCALER)) & 0x07;

    return (13560000.0 / (math.pow(2, p) * (128.0 + d))).round();
  }

  /// Sets the adc sampling frequency.
  ///
  ///     [@param] frequency: specifies the adc sampling frequency to be set the [ADC_Divider] (M) and [ADC_Prescaler] (N) [Register] (Hz).
  ///
  Future<void> setSamplingFrequency(int frequency) async {
    var adcDivider = 0;
    var adcPrescaler = 0;

    var value = 1000.0;
    final equationConstant = 13560000.0 / frequency;

    for ( var p = 0 ; p < 7 ; p++ ) {
      var start = -1;
      var end = 256;
      var mid = (start + end) >> 1;

      double equationVariable = (math.pow(2, p) * (128 + end)).toDouble();
      double equation;

      if ( equationVariable < equationConstant ) {
        continue;
      }

      while ( (mid != start) && (mid != end) && (value > 0.0000001) ) {
        equationVariable = (math.pow(2, p) * (128 + end)).toDouble();
        equation = (equationVariable - equationConstant).abs();

        if ( equationVariable < equationConstant ) {
          start = mid;
        } else if ( equationVariable > equationConstant ) {
          end = mid;
        }

        if ( equation < value ) {
          adcDivider = mid;
          adcPrescaler = p;
          value = equation;
        }

        mid = (start + end) >> 1;
      }
    }

    await register.write(
      ADDRESS_ADC_DIVIDER,
      adcDivider);
    await register.write(
      ADDRESS_ADC_PRESCALER,
      adcPrescaler);
  }

  /// Gets the number of sampling clock before adc process the input data.
  ///
  ///     [return] the number of sampling clock.
  ///
  Future<int> getNwaitClk() async {
    final nwait = await register.readBuffer(
      ADDRESS_ADC_NWAIT);

    final m = (nwait & 0xF0) >> 4;
    final n = nwait & 0x0F;

    return (8 + (m * math.pow(2, n))).toInt();
  }

  /// Sets the number of sampling clock before adc process the input data.
  ///
  ///     [@param] clock: specifies the sampling clock to be set the [ADC_NWait] register (clock).
  ///
  Future<void> setNwaitClk(int clock) async {
    var nWaitMul = 0;
    var nWaitPrescaler = 0;

    var value = 1000.0;
    final equationConstant = clock - 8.0;

    for ( var n = 0 ; n < 15 ; n++ ) {
      var start = -1;
      var end = 16;
      var mid = (start + end) >> 1;

      var equationVariable = (end * math.pow(2, n)).toDouble();
      double equation;

      if ( equationVariable < equationConstant ) {
        continue;
      }

      while ( (mid != start) && (mid != end) && (value > 0.0000001) ) {
        equationVariable = (end * math.pow(2, n)).toDouble();
        equation = (equationVariable - equationConstant).abs();

        if ( equationVariable < equationConstant ) {
          start = mid;
        } else if ( equationVariable > equationConstant ) {
          end = mid;
        }

        if ( equation < value ) {
          nWaitMul = mid;
          nWaitPrescaler = n;
          value = equation;
        }

        mid = (start + end) >> 1;
      }
    }

    await register.write(
      ADDRESS_ADC_NWAIT,
      (nWaitMul << 4) | nWaitPrescaler);
  }

  /// Gets the number of sampling clock before adc process the input data.
  ///
  ///     [return] the number of sampling clock.
  ///
  Future<int> getSampDelayTime() async {
    final p = (await register.readBuffer(
      ADDRESS_ADC_PRESCALER)) & 0x07;
    final ts = await register.readBuffer(
      ADDRESS_ADC_SAMP_DELAY);

    return (math.pow(2, p) * (ts + 1.0) / 13560000.0).round();
  }

  /// Sets the adc sampling time_s for reach sampling period.
  ///
  ///     [@param] tsamp: adc sampling time_s [second].
  ///
  Future<void> setTSamp(int tsamp) async {
    final p = (await register.readBuffer(
      ADDRESS_ADC_PRESCALER)) & 0x07;

    await register.write(
      ADDRESS_ADC_SAMP_DELAY,
      ((tsamp * 13560000.0 / math.pow(2, p)) - 1.0).round());
  }

  /// Gets the number of average time_s for `ADC_Result`.
  ///
  ///     [return] the number of sampling clock.
  ///
  Future<int> getAverageTime() async =>
      (await register.readBuffer(
        ADDRESS_ADC_NBIT)) & ADC_AVG;

  /// Sets the number of average time_s for `ADC_Result`.
  ///
  ///     [@param] adcAvg: specifies the port bit to be set.
  ///
  /// This parameter can be one of the following values:
  ///
  ///         [ADC_AVG__Time_1]: 1 time
  ///         [ADC_AVG__Time_2]: 2 times
  ///         [ADC_AVG__Time_4]: 4 times
  ///         [ADC_AVG__Time_8]: 8 times
  ///         [ADC_AVG__Time_16]: 16 times
  ///         [ADC_AVG__Time_32]: 32 times
  ///         [ADC_AVG__Time_64]: 64 times
  ///         [ADC_AVG__Time_128]: 128 times
  ///
  Future<void> setAverageTime(int adcAvg) async {
    await register.writeParams(
      ADDRESS_ADC_NBIT,
      ADC_AVG,
      adcAvg);
  }

  /// Gets the pattern of `ADC_Result`.
  ///
  ///     [return] the number of sampling clock.
  ///
  Future<int> getAdcResultPattern() async =>
      (await register.readBuffer(
        ADDRESS_ADC_NBIT)) & ADC_SIGNED;

  /// Sets the pattern of `ADC_Result`.
  ///
  ///     [@param] adcSigned: specifies the port bit to be set.
  ///
  /// This parameter can be one of the following values:
  ///
  ///         [ADC_SIGNED__Signed]: signed bit
  ///         [ADC_SIGNED__Unsigned]: unsigned bit
  ///
  Future<void> setAdcResultPattern(int adcSigned) async {
    await register.writeParams(
      ADDRESS_ADC_NBIT,
      ADC_SIGNED,
      adcSigned);
  }

  /// Gets the number of oversampling ratio (`OSR`) of adc,
  /// number of valid bit for `ADC_Result`.
  ///
  ///     [return] the number of sampling clock.
  ///
  Future<int> getOsr() async =>
      (await register.readBuffer(
        ADDRESS_ADC_NBIT)) & ADC_OSR;

  /// Sets the number of oversampling ratio (`OSR`) of adc,
  /// number of valid bit for `ADC_Result`.
  ///
  ///     [@param] adcOsr: specifies the port bit to be set.
  ///
  /// This parameter can be one of the following values:
  ///
  ///         [ADC_OSR__32_6b]: 1 time
  ///         [ADC_OSR__64_8b]: 2 times
  ///         [ADC_OSR__128_10b]: 4 times
  ///         [ADC_OSR__256_12b]: 8 times
  ///         [ADC_OSR__512_14b]: 16 times
  ///         [ADC_OSR__1024_14b]: 32 times
  ///         [ADC_OSR__2048_14b]: 64 times
  ///         [ADC_OSR__4096_14b]: 128 times
  ///
  Future<void> setOsr(int adcOsr) async {
    await register.writeParams(
      ADDRESS_ADC_NBIT,
      ADC_OSR,
      adcOsr);
  }

  /// Gets the pattern of `ADC_Result`.
  ///
  ///     [return] the number of sampling clock.
  ///
  Future<int> getTickPeriod() async =>
      (await register.readBuffer(
        ADDRESS_ADC_CONV_CFG)) & ADC_TICK_TIME_PERIOD;

  /// Sets the period of adc sampling, when `ADC_CONV_Mode`
  /// is configured to `TICK` mode.
  ///
  ///     [@param] adcTickPeriod: specifies the port bit to be set.
  ///
  /// This parameter can be one of the following values:
  ///
  ///         [ADC_TICK_TIME_PERIOD__50ms]: 50 ms
  ///         [ADC_TICK_TIME_PERIOD__100ms]: 100 ms
  ///         [ADC_TICK_TIME_PERIOD__200ms]: 200 ms
  ///         [ADC_TICK_TIME_PERIOD__500ms]: 500 ms
  ///         [ADC_TICK_TIME_PERIOD__1000ms]: 1 s
  ///         [ADC_TICK_TIME_PERIOD__2000ms]: 2 s
  ///         [ADC_TICK_TIME_PERIOD__5000ms]: 5 s
  ///         [ADC_TICK_TIME_PERIOD__10000ms]: 10 s
  ///
  Future<void> setTickPeriod(int adcTickPeriod) async {
    await register.writeParams(
      ADDRESS_ADC_CONV_CFG,
      ADC_TICK_TIME_PERIOD,
      adcTickPeriod);
  }

  /// Gets the response pattern for `Get_ADC` command,
  /// when configured to `TICK` mode.
  ///
  ///     [return] the response pattern.
  ///
  Future<int> getTickResponse() async =>
      (await register.readBuffer(
        ADDRESS_ADC_CONV_CFG)) & ADC_TICK_RSP;

  /// Sets the response pattern for `Get_ADC` command,
  /// when configured to `TICK` mode.
  ///
  ///     [@param] adcTickRsp: specifies the port bit to be set.
  ///
  /// This parameter can be one of the following values:
  ///
  ///         [ADC_TICK_RSP__Immediately]: response immediately after [Get_ADC] command.
  ///         [ADC_TICK_RSP__AtTickPeriod]: response at tick period.
  ///
  Future<void> setTickResponse(int adcTickRsp) async {
    await register.writeParams(
      ADDRESS_ADC_CONV_CFG,
      ADC_TICK_RSP,
      adcTickRsp);
  }

  /// Gets the adc conversion method.
  ///
  ///     [return] the method.
  ///
  Future<int> getConvertMode() async =>
      (await register.readBuffer(
        ADDRESS_ADC_CONV_CFG)) & ADC_CONV_MODE;

  /// Sets the adc conversion method.
  ///
  ///     [@param] adcConvMode: specifies the port bit to be set.
  ///
  /// This parameter can be one of the following values:
  ///
  ///         [ADC_CONV_MODE__Normal]: adc is converted when [Get_ADC] is executed.
  ///         [ADC_CONV_MODE__Continuous]: adc is continuously converted.
  ///         [ADC_CONV_MODE__Tick]: adc is automatically converted every tick period.
  ///
  Future<void> setConvertMode(int adcConvMode) async {
    await register.writeParams(
      ADDRESS_ADC_CONV_CFG,
      ADC_CONV_MODE,
      adcConvMode);
  }

  /// Checks the bit enabling adc input `BUFFER – N` side.
  ///
  ///     [return]
  ///         false : [Disable] the adc input buffer.
  ///         true  : [Enable] the adc input buffer.
  ///
  Future<bool> isBufferNEnabled() async =>
      ((await register.readBuffer(
        ADDRESS_ADC_BUFF_CFG)) & ADC_BUFN_EN) == ADC_BUFN_EN__Enable;

  /// Sets the bit enabling adc input `BUFFER – N` side.
  ///
  ///     [@param] enabled: this parameter contains a adc input buffer.
  ///
  /// This parameter can be one of the following values:
  ///
  ///         false : [Disable] the adc input buffer.
  ///         true  : [Enable] the adc input buffer.
  ///
  Future<void> setBufferNEnabled({ bool enabled = true }) async {
    await register.writeParams(
      ADDRESS_ADC_BUFF_CFG,
      ADC_BUFN_EN,
      enabled ? ADC_BUFN_EN__Enable : ADC_BUFN_EN__Disable);
  }

  /// Checks the bit enabling adc input `BUFFER – P` side.
  ///
  ///     [return]
  ///         false : [Disable] the adc input buffer.
  ///         true  : [Enable] the adc input buffer.
  ///
  Future<bool> isBufferPEnabled() async =>
      ((await register.readBuffer(
        ADDRESS_ADC_BUFF_CFG)) & ADC_BUFP_EN) == ADC_BUFP_EN__Enable;

  /// Sets the bit enabling adc input `BUFFER – P` side.
  ///
  ///     [@param] enabled: this parameter contains a adc input buffer.
  ///
  /// This parameter can be one of the following values:
  ///
  ///         false : [Disable] the adc input buffer.
  ///         true  : [Enable] the adc input buffer.
  ///
  Future<void> setBufferPEnabled({ bool enabled = true }) async {
    await register.writeParams(
      ADDRESS_ADC_BUFF_CFG,
      ADC_BUFP_EN,
      enabled ? ADC_BUFP_EN__Enable : ADC_BUFP_EN__Disable);
  }

  /// Gets the input low pass filter for adc.
  ///
  ///     [return] low pass filter bit.
  ///
  Future<int> getLowPassFilter() async =>
      (await register.readBuffer(
        ADDRESS_ADC_BUFF_CFG)) & ADC_LPF;

  /// Sets the input low pass filter for adc.
  ///
  ///     [@param] adcLpf: specifies the port bit to be set.
  ///
  /// This parameter can be one of the following values:
  ///
  ///         [ADC_LPF__None]: no low pass filter.
  ///         [ADC_LPF__S1260_D1060]: low pass filter [1260 kHz] or [1060 kHz].
  ///         [ADC_LPF__S623_D530]: low pass filter [623 kHz] or [530 kHz].
  ///         [ADC_LPF__S325_D280]: low pass filter [325 kHz] or [280 kHz].
  ///
  Future<void> setLowPassFilter(int adcLpf) async {
    await register.writeParams(
      ADDRESS_ADC_BUFF_CFG,
      ADC_LPF,
      adcLpf);
  }

  /// Gets the bit controlling the adc input.
  ///
  ///     [return] bit controlling mode.
  ///
  Future<int> getChannelNGround() async =>
      (await register.readBuffer(
        ADDRESS_ADC_CH_CFG)) & ADC_CHN_GND;

  /// Sets the bit controlling the adc input.
  ///
  ///     [@param] adcChnGnd: specifies the port bit to be set.
  ///
  /// This parameter can be one of the following values:
  ///
  ///         [ADC_CHN_GND__DifferentialMode]: differential mode.
  ///         [ADC_CHN_GND__SingleEndedMode]: single ended mode ([Channel N] is internal connected to [GND]).
  ///
  Future<void> setChannelNGround(int adcChnGnd) async {
    await register.writeParams(
      ADDRESS_ADC_CH_CFG,
      ADC_CHN_GND,
      adcChnGnd);
  }

  /// Gets the adc input `Channel-N`.
  ///
  ///     [return] input channel.
  ///
  Future<int> getChannelN() async =>
      (await register.readBuffer(
        ADDRESS_ADC_CH_CFG)) & ADC_CHN;

  /// Sets the adc input `Channel-N`.
  ///
  ///     [@param] adcChn: specifies the port bit to be set.
  ///
  /// This parameter can be one of the following values:
  ///
  ///         [ADC_CHN__Channel0]: [Channel N] at gpio 0
  ///         [ADC_CHN__Channel1]: [Channel N] at gpio 1
  ///         [ADC_CHN__Channel2]: [Channel N] at gpio 2
  ///         [ADC_CHN__Channel3]: [Channel N] at gpio 3
  ///
  Future<void> setChannelN(int adcChn) async {
    await register.writeParams(
      ADDRESS_ADC_CH_CFG,
      ADC_CHN,
      adcChn);
  }

  /// Gets the adc input `Channel-P`.
  ///
  ///     [return] input channel.
  ///
  Future<int> getChannelP() async =>
      (await register.readBuffer(
        ADDRESS_ADC_CH_CFG)) & ADC_CHP;

  /// Sets the adc input `Channel-P`.
  ///
  ///     [@param] adcChp: specifies the port bit to be set.
  ///
  /// This parameter can be one of the following values:
  ///
  ///         [ADC_CHP__Channel0]: [Channel P] at gpio 0
  ///         [ADC_CHP__Channel1]: [Channel P] at gpio 1
  ///         [ADC_CHP__Channel2]: [Channel P] at gpio 2
  ///         [ADC_CHP__Channel3]: [Channel P] at gpio 3
  ///
  Future<void> setChannelP(int adcChp) async {
    await register.writeParams(
      ADDRESS_ADC_CH_CFG,
      ADC_CHP,
      adcChp);
  }
}