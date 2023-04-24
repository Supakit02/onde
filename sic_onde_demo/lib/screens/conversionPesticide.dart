part of lib.screens;

class ConversionPesticide extends StatefulWidget {
  const ConversionPesticide({Key? key}) : super(key: key);

  @override
  _ConversionPesticideState createState() => _ConversionPesticideState();
}

class _ConversionPesticideState extends State<ConversionPesticide> {
  final constantController = Get.find<SettingConstantLinear>();
  final serviceController = Get.find<SettingProvider>();
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
      onMapStartCallback: _onMapDataCallback,
      onMapResultCallback: _onMapIndexCallback,
      // onInitialStartCallback: (data) {
      //   _setInitialChart();
      // },

      onConditionCallback: (time) {
        _setStatus('Condition Time $time sec');
      },
      onDepositionCallback: (time) {
        _setStatus('Deposition Time $time sec');
      },
      // onEquilibrationCallback: (time) {
      //   _setStatus('Equilibration Time $time sec');
      // },
      onConversionCallback: (data) {
        _setStatus('Conversion running');
      },

      // onConversionTime: (data) {
      //   _setStatus("Convertion time $data sec");
      // },

      onDoneCallback: _onDoneCallback,
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
                // child: GetBuilder<ConversionProvider>(
                //   builder: (value) {
                //     return Text(
                //       value.status,
                //       style: GoogleFonts.nunito(
                //           fontSize: 26,
                //           color: Color(0xFF73C2FB),
                //           fontWeight: FontWeight.w800),
                //     );
                //   },
                // ),
                child: GetBuilder<DataController>(
                  builder: (value) {
                    if (value.conversionState) {
                      return Text(
                        value.data,
                        style: GoogleFonts.nunito(
                            fontSize: 26,
                            color: Color(0xFF73C2FB),
                            fontWeight: FontWeight.w800),
                      );
                    } else {
                      return GetBuilder<ConversionProvider>(
                        builder: (value) {
                          return Text(
                            value.status,
                            style: GoogleFonts.nunito(
                                fontSize: 26,
                                color: Color(0xFF73C2FB),
                                fontWeight: FontWeight.w800),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
              SizedBox(
                height: 80,
              ),
              GetBuilder<ConversionProvider>(builder: (value) {
                if (value.complete) {
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
              GetBuilder<ConversionProvider>(builder: (value) {
                if (value.complete) {
                  return Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: SafeArea(
                        child: Image(
                          image: ExactAssetImage(
                              "assets/process/electrochem-drop.gif"),
                          fit: BoxFit.fitWidth,
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
                                if (serviceController.firstEnzym ||
                                    serviceController.lastEnzyme) {
                                  await _onRunEnzyem();
                                } else {
                                  await _onRun();
                                }
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
                                          Icons.play_arrow,
                                          color: Color(0xFF73C2FB),
                                          size: 15,
                                        ),
                                      ),
                                      Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "RUN",
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

  // ! CA MODE
  Entry _onMapIndexCallback(IoData data, int index) {
    final _setting = data.setting.get();

    switch (_setting.mode) {
      case Mode.CHRONOAMPEROMETRY_MODE:
        return Entry(
            index.toDouble(), data.result.result.elementAt(index).current);

      case Mode.DIFFERENTIAL_PULSE_VOLTAMMETRY_MODE:
        return Entry(data.result.result.elementAt(index).voltage.toDouble(),
            data.result.result.elementAt(index).current);

      default:
        throw UnimplementedError('Error on build entry chart(Conversion Page): '
            'Unexpected mode value: ${_setting.mode}');
    }
  }

  void _onErrorAction(Object error, {StackTrace? stackTrace}) {
    CaptureException.instance.exception(
        message: 'Error on conversion page',
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

  // void _onNextReaction(Entry entry) {
  //   context.read<ConversionProvider>().setResult(entry);
  // }

  void _onNextAction(IoData ioData) {
    if (_initComplete) {
      _initComplete = false;
      Get.find<ConversionProvider>().load = true;
      _conversion?.runCoversionCA(ioData);
    }
  }

  void _setStatus(String status) {
    if (!mounted) {
      return;
    }

    Get.find<ConversionProvider>().status = status;
  }

  void _onNextReaction(Entry entry) {
    Get.find<ConversionProvider>().setResult(entry);
  }

  IoData _onMapDataCallback(IoData data) {
    _initComplete = true;
    return data;
  }

  Future<void> _onDoneCallback(IoData data) async {
    final _setting = data.setting.get();
    if (_setting.mode.isAmpero) {
      await data.result.runFilter(
        option: _setting.filterOption,
      );
    }
    await data.result.findPeak();

    if (!mounted) {
      return;
    }

    Get.find<ConversionProvider>().setValues(
      load: true,
      complete: true,
      status: (serviceController.firstEnzym || serviceController.lastEnzyme)
          ? "Acetylthiocholine Chloride"
          : 'Prepare Solution',
    );
  }

  // void _onCompleteCallback(IoData data) async {
  //   print(">>>>>>>>>>>>>> 1");
  //   final _setting = data.settingManager.get();

  //   if (_setting.mode.isAmpero) {
  //     await data.resultManager.runFilter(
  //       option: _setting.filterOption,
  //     );
  //   }
  //   print(">>>>>>>>>>>>>> 2");
  //   await data.resultManager.findPeak();

  //   if (!mounted) {
  //     return;
  //   }

  //   await Get.find<ConversionProvider>().setValues(
  //     load: true,
  //     complete: true,
  //     status: 'Prepare Sample',
  //   );
  // }

  Future<void> _onRun() async {
    try {
      print(Manager.characteristic.get().toString());
      print(Manager.setting.get().toString());

      for (final _p in Manager.result.peak) {
        _p.first = false;

        _p.m = constantController.m;
        _p.c = constantController.c;
      }
      await Task.reaction.passDropDetect(Manager.characteristic.get());
      // ? RECHECK
      // if (serviceController.lastEnzyme) {
      //   print("last Enzyme");
      //   serviceController.setTRun1(300);
      // } else {
      //   serviceController.setTRun1(180);
      // }
      serviceController.setTRun1(180);

      await Manager.setting.setFromModel(serviceController.setting);
      Get.off(() => ConversionPesticideResult());

      // await Get.offNamed(
      //   ConversionView.routeName);
    } catch (e) {
      if (!mounted) {
        return;
      }

      Get.find<ConversionProvider>().setStatusError(
        status: 'Error occurs\nplease re-tap for re-scan',
      );
    }
  }

  Future<void> _onRunEnzyem() async {
    try {
      for (final _p in Manager.result.peak) {
        _p.first = false;
      }
      await Task.reaction.passDropDetect(Manager.characteristic.get());
      serviceController.setTRun1(300);
      // serviceController.setTRun1(20); //! test
      await Manager.setting.setFromModel(serviceController.setting);
      // Get.off(() => ConversionView());
      if (serviceController.lastEnzyme) {
        Get.off(() => ConversionPesticideResult());
      } else {
        Get.off(() => ConversionEnzyme());
      }

      // await Get.offNamed(
      //   ConversionView.routeName);
    } catch (e) {
      if (!mounted) {
        return;
      }

      Get.find<ConversionProvider>().setStatusError(
        status: 'Error occurs\nplease re-tap for re-scan',
      );
    }
  }
}
