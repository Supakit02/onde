part of nfc_sic.process;

class Conversion<E> {
  Conversion({
    @required _IoDataCallback onNextActionCallback,
    @required _IndexCallback<E> onNextReactionCallback,
    @required Function onErrorCallback,
    _MapIoDataCallback onMapStartCallback,
    _MapResultCallback<E> onMapResultCallback,
    _IndexCallback<int> onCycleCallback,
    _IoDataCallback onDoneCallback,
    _TimeCountCallback onConditionCallback,
    _TimeCountCallback onDepositionCallback,
    _TimeCountCallback onEquilibrationCallback,
    _IoDataCallback onConversionCallback,
    _TimeCountCallback onConversionTime,
  })  : _onNextActionCallback = onNextActionCallback,
        _onNextReactionCallback = onNextReactionCallback,
        _onErrorCallback = onErrorCallback,
        _onMapStartCallback = onMapStartCallback,
        _onMapResultCallback = onMapResultCallback,
        _onCycleCallback = onCycleCallback,
        _onDoneCallback = onDoneCallback,
        _onConditionCallback = onConditionCallback,
        _onDepositionCallback = onDepositionCallback,
        _onEquilibrationCallback = onEquilibrationCallback,
        _onConversionCallback = onConversionCallback,
        _onConversionTime = onConversionTime,
        _rx = RxHelper(),
        _task = Task.rx;

  final RxTask _task;

  _IoDataCallback _onNextActionCallback;
  _IndexCallback<E> _onNextReactionCallback;
  Function _onErrorCallback;

  _MapIoDataCallback _onMapStartCallback;
  _MapResultCallback<E> _onMapResultCallback;

  _IndexCallback<int> _onCycleCallback;
  _IoDataCallback _onDoneCallback;

  _TimeCountCallback _onConditionCallback;
  _TimeCountCallback _onDepositionCallback;
  _TimeCountCallback _onEquilibrationCallback;
  _IoDataCallback _onConversionCallback;
  _TimeCountCallback _onConversionTime;

  RxHelper _rx;

  void start(IoData data) {
    // debugPrint("[conversion] started conversion");
    final _setting = data.setting.get();
    final _tCondition = _setting.tCondition;
    final _tDeposition = _setting.tDeposition;
    final _tEquilibration = _setting.tEquilibration;
    final _tRun = _setting.tRun1;

    final _subscription = Stream.value(data.start())
        .doOnData((data) {
          _onConditionCallback?.call(_tCondition);
        })
        .flatMap(_task.condition)
        .flatMap((data) => _counterTime(data,
            seconds: _tCondition, callback: _onConditionCallback))
        .doOnData((data) {
          _onDepositionCallback?.call(_tDeposition);
        })
        .flatMap(_task.deposition)
        .flatMap((data) => _counterTime(data,
            seconds: _tDeposition, callback: _onDepositionCallback))
        // .doOnData((data) {
        //   _onEquilibrationCallback?.call(_tEquilibration);
        // })
        // .flatMap(_task.equilibration)
        // .flatMap((data) => _counterTime(data,
        //     seconds: _tEquilibration, callback: _onEquilibrationCallback))
        .doOnData(_onConversionCallback ?? (data) {})
        .flatMap(_task.initReaction)
        // .flatMap((data) =>
        //     _counterTime(data, seconds: _tRun, callback: _onConversionTime))
        .map(_onMapStartCallback ?? (ioData) => ioData)
        // .flatMap((data) =>
        //     _counterTime(data, seconds: _tRun, callback: _onConversionTime))
        .listen(
          _onNextActionCallback ?? (data) {},
          onError: _onErrorCallback,
          cancelOnError: true,
        );

    if (_subscription != null) {
      _subscription.onDone(() {
        _rx?.remove(_subscription);
      });

      _rx?.add(_subscription);
    }
  }

// ! only Pesticide
  void runCoversionCA(IoData data) {
    final _setting = data.setting.get();

    print(data.setting.get().toString());
    print(data.calibration.toString());
    print(data.characteristic.get().toString());

    final eDc = ReactFunc.toMilli(_setting.eDc1);
    final tRun = ReactFunc.toMilli(_setting.tRun1);

    final tInterval = 100; //! fix T Interval [REF TOXIN APP]
    final count = (tRun / tInterval).round() + 1;

    final _subscription = _task
        .conversionCA(data, eDc, 0, 0, count, tInterval)
        .map((index) {
      if (_onMapResultCallback != null) {
        return _onMapResultCallback(data, index);
      }
      return null;
    }).listen(_onNextReactionCallback ?? (data) {},
            onError: _onErrorCallback, cancelOnError: true);

    if (_subscription != null) {
      _subscription.onDone(() {
        _rx?.remove(_subscription);
        _endProcess(data);
      });

      _rx?.add(_subscription);
    }
  }

  void run(IoData data) {
    // debugPrint("reaction");
    final _setting = data.setting.get();

    _onCycleCallback?.call(1);

    final _eBegin = ReactFunc.round(ReactFunc.toMilli(_setting.eBegin), 5);
    final _eEnd = ReactFunc.round(ReactFunc.toMilli(_setting.eEnd), 5);
    var _ePulse = ReactFunc.round(_setting.ePulse, 5);
    var _eStep = ReactFunc.round(_setting.eStep, 5);

    final _pulseWidth = _setting.tPulse;
    final _pulsePeriod = _eStep / _setting.scanRate;

    var _size1 = 0;
    var _size2 = 0;

    if (_eBegin > _eEnd) {
      _size1 = ((_eBegin - 0) / _eStep).round();
      _size2 = ((0 - (_eEnd / 2)) / (_eStep / 2)).round();

      _ePulse = -_ePulse;
      _eStep = -_eStep;
    } else {
      _size1 = ((0 - (_eBegin / 2)) / (_eStep / 2)).round();
      _size2 = ((_eEnd - 0) / _eStep).round();
    }

    final _size = _size1 + _size2;

    final _tStep = _setting.tStep;

    final _round1 = ((_pulsePeriod - _pulseWidth) / _tStep).round();
    final _round2 = (_pulseWidth / _tStep).round();

    final _subscription = _task
        .conversion(data,
            bias: _eBegin,
            ePulse: _ePulse,
            eStep: _eStep,
            tStep: _tStep,
            size: _size,
            round1: _round1,
            round2: _round2)
        .map((index) => _onMapResultCallback?.call(data, index))
        .listen(
          _onNextReactionCallback ?? (data) {},
          onError: _onErrorCallback,
          cancelOnError: true,
        );

    if (_subscription != null) {
      _subscription.onDone(() {
        _rx?.remove(_subscription);
        _endProcess(data);
      });

      _rx?.add(_subscription);
    }
  }

  void _endProcess(IoData data) {
    // debugPrint("[Conversion] endProcess(IoData)");
    final _subscription = _task.cleanProcess(data).listen(
          (data) {},
          onError: _onErrorCallback,
          cancelOnError: true,
        );

    _subscription.onDone(() {
      _rx?.remove(_subscription);
      _onDoneCallback?.call(data);
    });

    _rx?.add(_subscription);
  }

  void dispose() {
    _onNextActionCallback = null;
    _onNextReactionCallback = null;
    _onErrorCallback = null;

    _onMapStartCallback = null;
    _onMapResultCallback = null;

    _onCycleCallback = null;
    _onDoneCallback = null;

    _onConditionCallback = null;
    _onDepositionCallback = null;
    _onEquilibrationCallback = null;
    _onConversionCallback = null;

    _rx?.dispose();
    _rx = null;
  }

  Stream<IoData> _counterTime(
    IoData data, {
    int seconds = 0,
    _TimeCountCallback callback,
  }) async* {
    Timer _timer;

    try {
      if (seconds > 0) {
        if (callback != null) {
          _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
            callback(seconds - timer.tick);
          });
        }

        await Future.delayed(Duration(seconds: seconds), () {
          _timer?.cancel();
        });
      }

      yield data;
    } catch (error, stackTrace) {
      throw OthersException(
        code: "_counterTime(Conversion)",
        details: error,
        stackTrace: stackTrace ?? StackTrace.current,
      );
    }
  }
}
