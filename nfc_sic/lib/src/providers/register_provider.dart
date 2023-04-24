part of nfc_sic.providers;

enum RegisterType {
  RFU,
  READ_ONLY,
  READ_ONLY_STATUS,
  READ_WRITE,
  READ_WRITE_CONFIG,
}

abstract class RegisterProvider {
  RegisterProvider(this._chip) {
    _regBuffer = _Buffer.newInstance(
      getRegisterPage());
  }

  /// Gets the clear flags protocol.
  ///
  ///     [return] byte array, data with clear flags command.
  ///
  static Uint8List getPackageClearFlags() =>
      Uint8List.fromList([ 0xB4, 0xFF ]);

  /// Gets the read `RegisterProvider` protocol.
  ///
  ///     [@param] address register address.
  ///     [return] byte array, read [RegisterProvider] command.
  ///
  static Uint8List getPackageRead(int address) =>
      Uint8List.fromList([ 0xB5, address ]);

  /// Gets the write `RegisterProvider` protocol.
  ///
  ///     [@param] address register address.
  ///     [@param] data    register data.
  ///     [return] byte array, write [RegisterProvider] command.
  ///
  static Uint8List getPackageWrite(int address, int data) =>
      Uint8List.fromList([ 0xB6, address, data ]);

  /// Gets the write `RegisterProvider` protocol.
  ///
  ///     [@param] data register address and data (2 bytes).
  ///     [return] byte array, write [RegisterProvider] command.
  ///
  static Uint8List getPackageWriteList(Uint8List data) {
    if ( ReactFunc.checkArraySize(data, 2) ) {
      return Uint8List.fromList([
        0xB6,
        data[0],
        data[1],
      ]);
    }

    return Uint8List(0);
  }

  final SicChip _chip;

  _Buffer _regBuffer;

  int getRegisterPage();

  int getDirectlyBuffer(int index) =>
      _regBuffer.getData(index);

  Future<void> setDirectlyBuffer(int index, int data) async {
    await _regBuffer.setData(index, data);
  }

  /// Reads a register buffer at a specific address.
  /// If buffer is empty, it will read this register directly.
  ///
  ///     [@param] address register address.
  ///     [return] register data.
  ///
  Future<int> readBuffer(int address) async {
    if ( _regBuffer.isSyncAt(address) ) {
      return _regBuffer.getData(address);
    } else {
      final _recv = await read(address);

      if ( _recv == null ) {
        return 0x00;
      }

      return _recv;
    }
  }

  /// Reads a register of a [SIC's] chip at a specific address directly.
  ///
  ///     [@param] address register address.
  ///     [return] register data.
  ///
  Future<int> read(int address) async {
    final _recv = await _chip.autoTransceive(
      getPackageRead(address));

    if ( _chip.isSendCompleted() ) {
      await _regBuffer.setData(
        address, _recv[1]);
      return _recv[1];
    }

    return null;
  }

  /// Reads registers of a [SIC's] chip directly.
  ///
  ///     [@param] addressBytes array of register address.
  ///     [return] register data.
  ///
  Future<List<int>> readList(List<int> addressBytes) async {
    final _length = addressBytes.length;
    final _send = List<Uint8List>(_length);

    for ( var i = 0 ; i < _length ; i++ ) {
      _send[i] = getPackageRead(
        addressBytes[i] & 0xFF);
    }

    final _recv = await _chip.autoTransceives(_send);

    if ( _chip.isSendCompleted() ) {
      await _regBuffer.setList(
        addressBytes, _recv);
      return _recv;
    }

    return null;
  }

  /// Configures a register of a [SIC's] chip.
  ///
  ///     [@param] address register address.
  ///     [@param] data    register data to be configured.
  ///
  Future<List<int>> write(int address, int data) async {
    final _recv = await _chip.autoTransceive(
      getPackageWrite(address, data));

    if ( _chip.isSendCompleted() ) {
      await _regBuffer.setData(
        address, data);
    }

    return _recv;
  }

  /// Configures registers of a SIC's chip.
  ///
  ///     [@param] data  array of register address and data. each array must have 2 bytes for [address(0)] and [data(1)].
  ///
  Future<List<int>> writeList(List<Uint8List> data) async {
    final _length = data.length;
    final _send = List<Uint8List>(_length);

    for ( var i = 0 ; i < _length ; i++ ) {
      _send[i] = getPackageWriteList(data[i]);
    }

    final _recv = await _chip.autoTransceives(_send);

    if ( _chip.isSendCompleted() ) {
      await _regBuffer.setListByte(data);
    }

    return _recv;
  }

  /// Clear the error flags presenting in the last `B_NAK`
  /// to make the communication process going on.
  Future<List<int>> clearFlags() =>
      _chip.autoTransceive(getPackageClearFlags());

  /// Configures a specific parameter of any register in chip.
  ///
  ///     [@param] address register address.
  ///     [@param] pos     bit position of register.
  ///     [@param] valPos  a specific value in a bit position. (another bit out of bit position will be ignored)
  ///
  Future<List<int>> writeParams(int address, int pos, int value) async {
    final _auto = _chip.autoDisconnect;

    _chip.autoDisconnect = false;

    final _data = await readBuffer(address);
    final _bConfig = _data & (~pos & 0xFF);

    _chip.autoDisconnect = _auto;

    final _recv = await write(
      address,
      _bConfig | (value & pos));

    return _recv;
  }
}