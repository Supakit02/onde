part of lib.screens;

class HistoryPage extends StatefulWidget {
  HistoryPage({Key? key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  Mode? _mode;
  Substance? _substance;
  Calibration? _calibrate;

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() {
    NFC.session.startSession(onTagDiscovered: _tagCallBack);
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
          "History",
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
          Column(
            children: [
              Center(child: GetBuilder<ProcessProvider>(builder: (value) {
                return Text(
                  "Please Scan",
                  style: GoogleFonts.nunito(
                      fontSize: 32,
                      color: Color(0xFF73C2FB),
                      fontWeight: FontWeight.w800),
                );
              })),
              // Text(
              //   pageController.selectType,
              //   style: GoogleFonts.nunito(
              //       fontSize: 24,
              //       color: Color(0xFF73C2FB),
              //       fontWeight: FontWeight.w700),
              // ),
            ],
          ),
          SizedBox(
            height: 80,
          ),
          // GetBuilder<ProcessProvider>(builder: (value) {
          //   if (value.isProcess && !value.complete) {
          //     return Expanded(
          //       child: Align(
          //         alignment: Alignment.center,
          //         child: Image(
          //           image: ExactAssetImage(
          //             "assets/process/group-311.png",
          //           ),
          //           fit: BoxFit.fitWidth,
          //         ),
          //       ),
          //     );
          //   } else {
          //     return Container();
          //   }
          // }),

          GetBuilder<ProcessProvider>(builder: (value) {
            if (value.complete) {
              return ClipOval(
                clipBehavior: Clip.antiAlias,
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0), //width of the border
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
                              "test",
                              style: GoogleFonts.nunito(
                                  fontSize: 50,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w700),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              "ppm",
                              style: GoogleFonts.nunito(
                                  fontSize: 20,
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
              );
            } else {
              return Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: SafeArea(
                    child: Image(
                      image: ExactAssetImage(value.status),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              );
            }
          }),

          GetBuilder<ProcessProvider>(builder: (value) {
            return SizedBox(
              height: (value.complete) ? 220 : 180,
            );
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
                                    child: RichText(
                                        text: TextSpan(
                                            style: GoogleFonts.nunito(),
                                            children: [
                                          TextSpan(
                                              text: (value.complete)
                                                  ? "HOME"
                                                  : "RUN",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400)),
                                        ])),
                                  ),
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
            )
          // Container(
          //   decoration: BoxDecoration(
          //       // color: Colors.black,
          //       borderRadius: BorderRadius.circular(100),
          //       border: Border.all(color: Colors.black, width: 10)),
          //   height: 200,
          //   width: 200,
          //   child: Center(
          //       child: Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       Text("test"),
          //       Text("test"),
          //     ],
          //   )),
          // )
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
    Get.find<APIController>().setUid(uid_test);
    if (isTag4341) {
      Get.find<ProcessProvider>().setValues(
        status: "assets/process/electrochem-process.gif",
        text: 'Chcek UID ..',
      );
      await Future.delayed(Duration(seconds: 2));
       Get.find<ProcessProvider>().setValues(
        status: "assets/process/electrochem-process.gif",
        text: 'Chcek UID ..',
      );




      // _tagDetect(IoData(), uid: uid);
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
      await Task.reaction.passDropDetect(Manager.characteristic.get());
      // Get.off(() => ConversionView());
      if (_substance.isHeavyMetals) {
        Get.off(() => ConversionView());
      } else {
        Get.off(() => ConversionPesticide());
        print("in to pesticide");
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

    if (_mode == Mode.DIFFERENTIAL_PULSE_VOLTAMMETRY_MODE) {
      _calibrate?.start(data);
      print("start Calibeate DPV");
    } else {
      _calibrate?.ampero(data);
      print("start Calibeate CA");
    }
  }
}
