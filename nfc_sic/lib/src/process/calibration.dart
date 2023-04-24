part of nfc_sic.process;

class Calibration {
  Calibration({
    @required _IoDataCallback onNextCallback,
    @required Function onErrorCallback,
    _IoDataCallback onStartCallback,
    _IoDataCallback onEndCallback,
    VoidCallback onDoneCallback,
  })  : _onNextCallback = onNextCallback,
        _onErrorCallback = onErrorCallback,
        _onStartCallback = onStartCallback,
        _onEndCallback = onEndCallback,
        _onDoneCallback = onDoneCallback,
        _rx = RxHelper(),
        _task = Task.rx;

  final RxTask _task;

  _IoDataCallback _onNextCallback;
  Function _onErrorCallback;

  _IoDataCallback _onStartCallback;
  _IoDataCallback _onEndCallback;
  VoidCallback _onDoneCallback;

  RxHelper _rx;

  void ampero(IoData ioData) {
    var _subscription = Stream.value(ioData.start())
        // Check power
        .doOnData(_onStartCallback ?? (data) {})
        .flatMap(_task.validatePower)
        .delay(Duration(seconds: 5))
        // Calibration
        .flatMap(_task.calibrateSensor)
        .flatMap(_task.calibrateSingle)
        // Drop
        .doOnData(_onEndCallback ?? (data) {})
        .listen(
          _onNextCallback ?? (data) {},
          onError: _onErrorCallback,
          cancelOnError: true,
        );

    _subscription.onDone(() {
      if (_onDoneCallback != null) {
        _onDoneCallback();
      }

      _rx?.remove(_subscription);
    });

    _rx?.add(_subscription);
  }

  void start(IoData ioData) {
    final _subscription = Stream.value(ioData.start())
        // Check power
        .doOnData(_onStartCallback ?? (data) {})
        .flatMap(_task.validatePower)
        // Calibration
        .flatMap(_task.calibrateSensor)
        .flatMap(_task.calibrateMultiple)
        // Drop
        .doOnData(_onEndCallback ?? (data) {})
        .listen(
          _onNextCallback ?? (data) {},
          onError: _onErrorCallback,
          cancelOnError: true,
        );

    _subscription.onDone(() {
      _onDoneCallback?.call();
      _rx?.remove(_subscription);
    });

    _rx?.add(_subscription);
  }

  void startTest(IoData ioData) {
    final _subscription = Stream.value(ioData.start())

        // Check power
        .doOnData(_onStartCallback ?? (data) {})
        .flatMap(_task.validatePower)
        // Calibration
        // .flatMap(_task.calibrateSensor)
        // .flatMap(_task.calibrateMultiple)
        // Drop
        .doOnData(_onEndCallback ?? (data) {})
        .listen(
          _onNextCallback ?? (data) {},
          onError: _onErrorCallback,
          cancelOnError: true,
        );

    _subscription.onDone(() {
      _onDoneCallback?.call();
      _rx?.remove(_subscription);
    });

    _rx?.add(_subscription);
  }

  void dispose() {
    _onNextCallback = null;
    _onErrorCallback = null;

    _onStartCallback = null;
    _onEndCallback = null;
    _onDoneCallback = null;

    _rx?.dispose();
    _rx = null;
  }
}
