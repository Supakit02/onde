part of lib.screens;

class ProcessPageEnzyme extends StatefulWidget {
  const ProcessPageEnzyme({Key? key}) : super(key: key);

  @override
  _ProcessPageEnzymeState createState() => _ProcessPageEnzymeState();
}

class _ProcessPageEnzymeState extends State<ProcessPageEnzyme> {
  final serviceController = Get.find<SettingProvider>();
  Mode? _mode;
  Substance? _substance;
  Calibration? _calibrate;
  bool changeSizeFont = false;

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  void dispose() {
    NFC.session.setOnTagDiscovered(null);

    _calibrate?.dispose();
    _calibrate = null;

    super.dispose();
  }
  // ! แทนที่

  // @override
  // void dispose() {
  //   if (Platform.isAndroid) {
  //     NfcSession.instance.setOnTagDiscovered(null);
  //   } else {
  //     _stopSession();
  //   }

  //   _calibrate?.dispose();
  //   _calibrate = null;

  //   super.dispose();
  // }

  void _init() {
    _mode = Get.find<SettingProvider>().mode;
    print(_mode);
    _substance = Get.find<SettingProvider>().substance;

    Get.find<ProcessProvider>().setValues(
      notify: false,
      text:
          "Please clean \nthe biosensor with PBS.\nDrop Solution and wait 10 minutes and clean again.",
    );
    print(_substance.text);

    NFC.session.startSession(onTagDiscovered: _tagCallBack);

    // if (Platform.isAndroid) {
    //   NfcSession.instance.setOnTagDiscovered(_tagCallBack);
    // } else {
    //   NfcSession.instance.startSession(
    //     onTagDiscovered: _tagCallBack,
    //     alertMessage: 'Please tap a tag.',
    //     onSessionError: (error) {
    //       // debugPrint("onSessionError: ${error.toString()}");
    //       _stopSession(error: error.message);
    //     },
    //   );
    // }

    _calibrate = Calibration(
      onNextCallback: _onNextAction,
      onErrorCallback: _onErrorAction,
      onStartCallback: (data) {
        if (!mounted) {
          return;
        }

        Get.find<ProcessProvider>().setValues(
            text: "Check UID..",
            status: "assets/process/electrochem-process.gif",
            changeFontSize: true);
      },
      onEndCallback: (data) {
        if (!mounted) {
          return;
        }

        // data.characteristicsManager.externalOffset?.forEach((key, value) {
        //   print("volt: $key, current: $value");
        // });
        // print("adcGainErr: ${data.characteristicsManager.get().adcGainErr}");

        Get.find<ProcessProvider>().setValues(
          // complete: true,
          isProcess: true,
          text: Get.find<PageDetailController>().useSubstance,
          status: "assets/process/electrochem-drop.gif",
          changeFontSize: true,
        );
      },
      onDoneCallback: () {
        // _stopSession();
      },
    );
  }

  bool test = false;
  final pageController = Get.find<PageDetailController>();
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
          pageController.modeProcess,
          style: GoogleFonts.nunito(fontSize: 24, color: Colors.white),
        ),
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 20,
          ),
          GetBuilder<ProcessProvider>(builder: (value) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                value.text,
                // "Please clean \nthe biosensor with PBS.\nDrop Solution and wait 10 minutes and clean again.",
                style: GoogleFonts.nunito(
                    fontSize: value.changeFontSize ? 28 : 20,
                    color: Color(0xFF73C2FB),
                    fontWeight: FontWeight.w800),
                textAlign: TextAlign.center,
              ),
            );
          }),
          SizedBox(
            height: 100,
          ),
          GetBuilder<ProcessProvider>(builder: (value) {
            if (value.isProcess && !value.complete) {
              return Image(
                image: ExactAssetImage(
                  "assets/process/group-311.png",
                ),
                fit: BoxFit.fitWidth,
              );
            } else {
              return Container();
            }
          }),
          GetBuilder<ProcessProvider>(builder: (value) {
            if (!value.complete) {
              return Align(
                alignment: Alignment.center,
                child: SafeArea(
                  child: Image(
                    image: ExactAssetImage(value.status),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              );
            } else {
              return Container();
            }
          }),
          GetBuilder<ProcessProvider>(builder: (value) {
            if (value.isProcess) {
              return Expanded(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            print(pageController.selectType);
                            if (!value.complete) {
                              await _onRun();
                            }
                          },
                          child: Container(
                            width: 125,
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
                                          : Icons.play_arrow,
                                      color: Color(0xFF73C2FB),
                                      size: 15,
                                    ),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        value.complete ? "HOME" : "RUN",
                                        style: GoogleFonts.nunito(
                                            fontSize: 16,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400),
                                      )),
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
            } else {
              return Container();
            }
          }),
          if (test)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      print(pageController.selectType);
                    },
                    child: Container(
                      width: 125,
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 25,
                              width: 27,
                              decoration: BoxDecoration(
                                  color: Colors.white, shape: BoxShape.circle),
                              child: Icon(
                                Icons.home,
                                color: Color(0xFF73C2FB),
                                size: 15,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: RichText(
                                  text: TextSpan(
                                      style: GoogleFonts.nunito(),
                                      children: [
                                    TextSpan(
                                        text: "HOME",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400)),
                                  ])),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
        ],
      ),
    );
  }

  void _tagCallBack(Uint8List uid) async {
    if (!(ModalRoute.of(context)?.isCurrent ?? false)) {
      return;
    }
    print(uid);
    final uid_test = hex.encode(uid.toList());
    print(uid_test);

    var isTag4341 = await Task.reaction.checkUid(uid: uid_test);

    if (isTag4341) {
      //! Check UID for on RUN
      // Get.find<ProcessProvider>().setValues(
      //   text: _substance.text,
      //   status: "assets/process/electrochem-process.gif",
      // );
      // await Future.delayed(Duration(seconds: 2));
      // Get.find<ProcessProvider>().setValues(
      //   // complete: true,
      //   isProcess: true,
      //   text: _substance.text,
      //   status: "assets/process/electrochem-drop.gif",
      // );

      //! Disable
      _tagDetect(IoData(), uid: uid);
    } else {
      Get.snackbar(
        '',
        '',
        titleText: Text(
          'Tag Detect'.toUpperCase(),
          textAlign: TextAlign.center,
          style: Get.textTheme.headline6?.copyWith(
            color: Colors.black,
          ),
        ),
        messageText: Text(
          'This tag is not SIC4341.',
          textAlign: TextAlign.center,
          style: Get.textTheme.bodyText2?.copyWith(
            color: Colors.black,
          ),
        ),
        snackPosition: SnackPosition.BOTTOM,
        borderRadius: 16.0,
        backgroundColor: Colors.white,
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.all(8.0),
        duration: Duration(seconds: 2),
      );
    }
  }

  Future<void> _onRun() async {
    try {
      serviceController.setSubstance(Substance.CHLORPYRIFOS);
      serviceController.setUsePrevOffset(true);
      await Manager.setting.setFromModel(serviceController.setting);
      for (final _p in Manager.result.peak) {
        _p.first = true;
        _p.firstEnzyme = false;
      }
      serviceController.setLastEnzyme(true);
      await Task.reaction.passDropDetect(Manager.characteristic.get());

      // Get.off(() => ConversionView());
      if (_substance.isHeavyMetals) {
        Get.off(() => ConversionView());
      } else {
        Get.off(() => ConversionPesticide());
        print("in to pesticide step 4");
      }

      // await Get.offNamed(
      //   ConversionView.routeName);
    } catch (e, stackTrace) {
      CaptureException.instance.exception(
          message: "Error onRun method",
          library: "TEST DEMOAPP Exception",
          error: e,
          stackTrace: stackTrace);
      if (!mounted) {
        return;
      }

      Get.find<ProcessProvider>().setValues(
        text: 'Error occurs\nplease re-tap for re-scan',
      );
    }
  }

  Future<void> _tagDetect(IoData data, {Uint8List? uid}) async {
    final _usePrevOffset = data.setting.get().usePrevOffset;

    if (_usePrevOffset) {
      final _calibration = data.calibration;

      var _validate = await _calibration.loadOffsetData();

      if (_validate) {
        _validate = await _calibration.checkUid();

        if (_validate) {
          const indent = '     ';

          _validate = await _calibration.validateData();

          if (_validate) {
            _validate = await _calibration.validateOffset();

            if (!_validate) {
              await AppService.errorDialog<Object>(
                title: 'Error: Offset no data.',
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Record offsets :',
                      style: context.textTheme.bodyText2?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${indent}pin 0 : ${(_calibration.hasOffsetPin0) ? "record" : "no record"}\r\n"
                      "${indent}pin 1 : ${(_calibration.hasOffsetPin1) ? "record" : "no record"}\r\n"
                      "${indent}pin 2 : ${(_calibration.hasOffsetPin2) ? "record" : "no record"}\r\n"
                      "\r\nhasn't save offset data this we pin in record.",
                      style: context.textTheme.bodyText2,
                    ),
                  ],
                ),
              );
              return;
            }
          } else {
            await AppService.errorDialog<Object>(
              title: 'Error: Data settings not match.',
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Settings in record :',
                    style: context.textTheme.bodyText2?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${indent}current range : ${_calibration.currentRange} uA\r\n'
                    '${indent}initial potential : ${_calibration.vStart / 1000.0} V\r\n'
                    '${indent}final potential : ${_calibration.vEnd / 1000.0} V',
                    style: context.textTheme.bodyText2,
                  ),
                ],
              ),
            );
            return;
          }
        } else {
          await AppService.errorDialog<Object>(
            title: 'Error: Check uid.',
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Now UID: ${uid.toHexString()}\r\n"
                  "Prev UID: ${_calibration.uid}\r\n"
                  "\r\nhasn't save offset data at this uid.",
                  style: context.textTheme.bodyText2,
                ),
              ],
            ),
          );
          return;
        }
      } else {
        await AppService.errorDialog<Object>(
          title: 'Error: Load data.',
          onBack: () {
            Get.back();
          },
          content: Text(
            "hasn't record offset data.",
            style: context.textTheme.bodyText2,
          ),
        );
        return;
      }
    }

    // todo : Add Frist Result
    Get.find<APIController>().setFristRawResult(Manager.result.result);

    await data.initResult();
    // _calibrate?.startTest(data);

    if (_mode == Mode.DIFFERENTIAL_PULSE_VOLTAMMETRY_MODE) {
      _calibrate?.start(data);
      print("start Calibeate DPV");
    } else {
      _calibrate?.ampero(data);
      print("start Calibeate CA");
    }
  }

  void _onNextAction(IoData ioData) {
    if (!mounted) {
      return;
    }
  }

  void _onErrorAction(Object error, {StackTrace? stackTrace}) {
    CaptureException.instance.exception(
        message: "Error on process page",
        library: "TEST DEMOAPP Exception",
        error: error,
        stackTrace: stackTrace ?? StackTrace.current);
    if (!mounted) {
      return;
    }

    Get.find<ProcessProvider>().setValues(
      text: 'Error occurs\nplease re-tap',
    );
  }
}
