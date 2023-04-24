part of nfc_sic.providers;

class _Buffer {
  _Buffer(int length)
    : _length = length,
      _data = List<int>(length),
      _sync = List<bool>(length);

  factory _Buffer.newInstance(int length) =>
      _Buffer(length);

  int _length;
  List<int> _data;
  List<bool> _sync;

  Future<void> setData(int index, int data) async {
    if ( index >= _length ) {
      return;
    }

    _data[index] = data;
    _sync[index] = true;
  }

  Future<void> setList(List<int> index, List<int> data) async {
    if ( index.length != data.length ) {
      return;
    }

    final _length = index.length;

    for ( var i = 0 ; i < _length ; i++ ) {
      _data[index[i]] = data[i];
      _sync[index[i]] = true;
    }
  }

  Future<void> setListByte(List<Uint8List> dataBytes) async {
    int _index;
    int data;

    for ( final _dataArrays in dataBytes ) {
      if ( _dataArrays.length != 2 ) {
        return;
      }

      _index = _dataArrays[0] & 0xFF;
      data = _dataArrays[1];

      _data[_index] = data;
      _sync[_index] = true;
    }
  }

  int getData(int index) {
    if ( index >= _length ) {
      // ignore: avoid_returning_null
      return null;
    }
    if ( !_sync[index] ) {
      // ignore: avoid_returning_null
      return null;
    }
    return _data[index];
  }

  Future<void> unsync(int index) async {
    _sync[index] = false;
    _data[index] = 0x00;
  }

  bool isSync() {
    for ( final s in _sync ) {
      if ( !s ) {
        return false;
      }
    }
    return true;
  }

  bool isSyncAt(int index) =>
      _sync[index] ?? false;
}