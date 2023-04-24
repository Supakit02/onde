part of lib.screens;

class ConversionView extends StatefulWidget {
  const ConversionView({Key? key}) : super(key: key);

  @override
  _ConversionViewState createState() => _ConversionViewState();
}

class _ConversionViewState extends State<ConversionView> {
  bool _initComplete = false;
  Conversion? _conversion;

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  void dispose() {
    _conversion?.dispose();
    _conversion = null;

    super.dispose();
  }

  void _init() {
    Get.find<ConversionProvider>().reset();

    _initComplete = false;

    _conversion = Conversion<Entry>(
      onNextActionCallback: _onNextAction,
      onNextReactionCallback: _onNextReaction,
      onErrorCallback: _onErrorAction,
      onMapStartCallback: _onMapStartCallback,
      onMapResultCallback: _onMapResultCallback,
      onCycleCallback: (cycle) {
        _setInitialChart();
      },
      onConditionCallback: (time) {
        _setStatus('Condition Time $time sec');
      },
      onDepositionCallback: (time) {
        _setStatus('Deposition Time $time sec');
      },
      onEquilibrationCallback: (time) {
        _setStatus('Equilibration Time $time sec');
      },
      onConversionCallback: (data) {
        _setStatus('Conversion running');
      },
      onDoneCallback: _onDoneCallback,

      //! don't use
      // onMapDataCallback: _onMapDataCallback,
      // onMapIndexCallback: _onMapIndexCallback,
      // // onInitialStartCallback: (data) {
      // //   _setInitialChart();
      // // },

      // onResetTimeCallback: (resetTime) {
      //   _setStatus('Deposition time $resetTime sec');
      // },
      // onWaitTimeCallback: (waitTime) {
      //   _setStatus('Wait for next scan $waitTime sec');
      // },
      // onConversionRunningCallback: (data) {
      //   _setStatus('Conversion running');
      //   print(data);
      // },
      // onCompleteCallback: _onCompleteCallback,
    );

    // context.read<ConversionProvider>().initChartModel(Manager.setting.get());

    // _conversion?.setLoop(1);
    _conversion?.start(IoData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Color(0xFF73C2FB),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          "Conversion",
          style: GoogleFonts.nunito(fontSize: 24, color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16.0,
                  ),
                  child: GetBuilder<ConversionProvider>(
                    builder: (value) {
                      return Text(
                        value.status,
                        style: GoogleFonts.nunito(
                            fontSize: 26,
                            color: Color(0xFF73C2FB),
                            fontWeight: FontWeight.w800),
                      );
                    },
                  )),
              SizedBox(
                height: 80,
              ),
              GetBuilder<ConversionProvider>(builder: (value) {
                if (value.complete) {
                  return Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: ClipOval(
                        clipBehavior: Clip.antiAlias,
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(
                                10.0), //width of the border
                            child: ClipOval(
                              clipBehavior: Clip.antiAlias,
                              child: Container(
                                width:
                                    200.0, // this width forces the container to be a circle
                                height:
                                    200.0, // this height forces the container to be a circle
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      Manager.result.peak[0].concentration !=
                                              null
                                          ? Manager.result.peak[0].concentration
                                              .toStringAsFixed(1)
                                          : "N/A",
                                      style: GoogleFonts.nunito(
                                          fontSize: 50,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w700),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      Manager.result.peak[0].unit,
                                      style: GoogleFonts.nunito(
                                          fontSize: 24,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w700),
                                      textAlign: TextAlign.start,
                                    ),
                                  ],
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.white),
                                  borderRadius: BorderRadius.circular(32),
                                ),
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              Color(0xFF98D2FC),
                              Color(0xFF72C2FB),
                              Color(0xFF41acfa),
                              Color(0xFF078BEA)
                            ]),
                            border: Border.all(
                              color: Color(
                                  0xFF73C2FB), //kHintColor, so this should be changed?
                            ),
                            borderRadius: BorderRadius.circular(32),
                          ),
                        ),
                      ),
                    ),
                  );
                } else {
                  return Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: SafeArea(
                        child: Image(
                          image: ExactAssetImage(
                              "assets/process/electrochem-process.gif"),
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                  );
                }
              }),
              GetBuilder<ConversionProvider>(builder: (value) {
                return Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              Get.back();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Color(0xFF73C2FB),
                                  borderRadius: BorderRadius.circular(40),
                                  boxShadow: [
                                    BoxShadow(
                                        offset: Offset(0, 10),
                                        blurRadius: 20,
                                        spreadRadius: -18,
                                        color: Colors.black)
                                  ]),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 16),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: 25,
                                      width: 27,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle),
                                      child: Icon(
                                        (value.complete)
                                            ? Icons.home
                                            : Icons.cancel_outlined,
                                        color: Color(0xFF73C2FB),
                                        size: 15,
                                      ),
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          value.complete ? "HOME" : "CANCEL",
                                          style: GoogleFonts.nunito(
                                              fontSize: 16,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400),
                                        )),

                                    // Container(
                                    //   height: 25,
                                    //   width: 27,
                                    //   decoration: BoxDecoration(
                                    //       color: Colors.white, shape: BoxShape.circle),
                                    //   child: Icon(
                                    //     Icons.arrow_forward_ios,
                                    //     color: Color(0xFF73C2FB),
                                    //     size: 15,
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          if (value.complete)
                            GestureDetector(
                              onTap: () async {
                                DialogHelper.dialogShow(text: "Saveing ..");
                                final dataReport = ReportFunc.getReportHeavy(
                                    date: DateTime.now());
                                final fileName = ReportFunc.fileName(
                                    substance:
                                        Get.find<SettingProvider>().substance);
                                await Get.find<ReportController>().saveFile(
                                    fileName: fileName, data: dataReport);
                                DialogHelper.hideLoading();
                                Get.dialog(
                                  CustomDialogError(
                                      hideBotton: true,
                                      text: "Save Success.",
                                      onTap: () {
                                        Get.back();
                                      },
                                      pathImage: "assets/chemical/checked.png"),
                                );
                                await Future.delayed(Duration(seconds: 1), () {
                                  DialogHelper.hideLoading();
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Color(0xFF73C2FB),
                                    borderRadius: BorderRadius.circular(40),
                                    boxShadow: [
                                      BoxShadow(
                                          offset: Offset(0, 10),
                                          blurRadius: 20,
                                          spreadRadius: -18,
                                          color: Colors.black)
                                    ]),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 16),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height: 25,
                                        width: 27,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle),
                                        child: Icon(
                                          Icons.save_alt,
                                          color: Color(0xFF73C2FB),
                                          size: 15,
                                        ),
                                      ),
                                      Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "SAVE",
                                            style: GoogleFonts.nunito(
                                                fontSize: 16,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400),
                                          )),
                                      // Container(
                                      //   height: 25,
                                      //   width: 27,
                                      //   decoration: BoxDecoration(
                                      //       color: Colors.white, shape: BoxShape.circle),
                                      //   child: Icon(
                                      //     Icons.arrow_forward_ios,
                                      //     color: Color(0xFF73C2FB),
                                      //     size: 15,
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              })
            ],
          ),
        ),
      ),
    );
  }

  void _onNextAction(IoData data) {
    if (_initComplete) {
      _initComplete = false;
      Get.find<ConversionProvider>().load = true;
      _conversion?.run(data);
    }
  }

  void _onNextReaction(Entry entry) {
    Get.find<ConversionProvider>().setResult(entry);
  }

  void _onErrorAction(Object error, [StackTrace? stackTrace]) {
    CaptureException.instance.exception(
        message: "Error on conversion page",
        library: "TEST DEMOAPP Exception",
        error: error,
        stackTrace: stackTrace ?? StackTrace.current);

    if (!mounted) {
      return;
    }

    Get.find<ConversionProvider>().setValues(
      load: true,
      complete: true,
      status: 'Conversion error',
    );
  }

  IoData _onMapStartCallback(IoData data) {
    _initComplete = true;
    return data;
  }

  Entry _onMapResultCallback(IoData data, int index) => // ! DPV
      Entry(data.result.result.elementAt(index).voltage.toDouble(),
          data.result.result.elementAt(index).current);

  void _setStatus(String status) {
    if (!mounted) {
      return;
    }

    Get.find<ConversionProvider>().status = status;
  }

  void _setInitialChart() {
    Get.find<ConversionProvider>().addNewLine();
  }

  Future<void> _onDoneCallback(IoData data) async {
    await data.result.findPeak();
    List<Result> _getData = Manager.result.result;
    double _result = Manager.result.peak[0].concentration != null
        ? Manager.result.peak[0].concentration
        : 0.0;

    List<String> _dataAPI = [];
    for (var _res in _getData) {
      _dataAPI.add(_res.adcOut.toString());
    }

    Get.find<APIController>()
        .setResultHeavy(result: _result, rawStringResult: _dataAPI);

    ONDEModel test = Get.find<APIController>().dataModelAPI;
    print(test);

    await Get.find<APIController>().postAPI();

    if (!mounted) {
      return;
    }

    Get.find<ConversionProvider>().setValues(
      load: true,
      complete: true,
      status: 'Conversion completed',
    );
  }
}
