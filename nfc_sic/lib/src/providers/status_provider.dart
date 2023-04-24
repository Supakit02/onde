part of nfc_sic.providers;

abstract class StatusProvider {
  @protected
  StatusProvider(SicChip chip)
    : _register = chip.getRegister(),
      _latestTime = DateTime.now();

  static const int TIMEOUT_OF_STATUS = 500;

  static int scapRdy;
  static int xvddRdy;
  static int rspwRdy;
  static int ldoOn;

  @protected
  static int addressPowerStatus;

  final RegisterProvider _register;

  DateTime _latestTime;

  RegisterProvider get register => _register;

  Future<void> clearStatus() async {
    _latestTime = DateTime.now();
  }

  @mustCallSuper
  Future<int> getStatus([ int address ]) async {
    final _time = DateTime.now();
    int _status;

    if ( _time.difference(_latestTime).inMilliseconds < TIMEOUT_OF_STATUS ) {
      _status = await register.readBuffer(address);
    } else {
      _status = await register.read(address);
    }

    _latestTime = _time;

    return _status;
  }

  /// Gets the power status on register.
  ///
  ///     [return] byte power status data value.
  ///
  Future<int> getPowerStatus() =>
      getStatus(addressPowerStatus);

  /// Checks the power of external super capacitor.
  ///
  ///     [return] true, if the voltage on pin [SCAP] is higher than 4.5V.
  ///
  Future<bool> isPowerSuperCapReady() async {
    final _flag = await getPowerStatus();

    return (_flag != null) &&
      ((_flag & scapRdy) == scapRdy);
  }

  /// Checks the external power.
  ///
  ///     [return] true, if the voltage on pin [XVDD] is higher than [XVDD] drop level.
  ///
  Future<bool> isPowerXVDDReady() async {
    final _flag = await getPowerStatus();

    return (_flag != null) &&
      ((_flag & xvddRdy) == xvddRdy);
  }

  /// Checks the power of `NFC` device.
  ///
  ///     [return] true, if the reserve power from [RF] is higher than a defined supplying level.
  ///
  Future<bool> isReservePowerReady() async {
    final _flag = await getPowerStatus();

    return (_flag != null) &&
      ((_flag & rspwRdy) == rspwRdy);
  }

  /// Checks the `LDO` regulator.
  ///
  ///     [return] true, if the [LDO] regulator is successfully turned on.
  ///
  Future<bool> isLDORegulatorOn() async {
    final _flag = await getPowerStatus();

    return (_flag != null) &&
      ((_flag & ldoOn) == ldoOn);
  }
}