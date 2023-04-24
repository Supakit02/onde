part of lib.screens;

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final pageController = Get.put(PageDetailController());
  final serviceController = Get.put(SettingProvider());
  final processProviderController = Get.put(ProcessProvider());
  final conversionController = Get.put(ConversionProvider());
  final constantController = Get.put(SettingConstantLinear());
  final apiController = Get.put(APIController());
  final reportController = Get.put(ReportController());
  final _drawerController = ZoomDrawerController();
  int count = 0;

  @override
  void initState() {
    super.initState();
    Wakelock.enable();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void dispose() {
    Wakelock.disable();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return ZoomDrawer(
      style: DrawerStyle.Style1,
      controller: _drawerController,
      openCurve: Curves.fastOutSlowIn,
      closeCurve: Curves.bounceIn,
      mainScreenScale: 0.2,
      borderRadius: 40,
      showShadow: true,
      backgroundColor: Color(0xFF93d0fc),
      angle: 0.0,
      slideWidth: MediaQuery.of(context).size.width * 0.55,
      menuScreen: DrawerScreen(),
      mainScreen: Scaffold(
          body: Stack(
        children: [
          // Align(
          //     alignment: Alignment.bottomRight,
          //     child: Padding(
          //       padding:
          //           const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          //       child: Text(
          //         "Version : 1.0.4.DEV",
          //         style: TextStyle(fontSize: 12),
          //       ),
          //     )),
          Column(
            children: [
              Container(
                  height: size.height * .2,
                  decoration: BoxDecoration(
                      color: Color(0xFF73C2FB),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40)))),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 80,
                ),
                Center(
                  child: Text("ONDE Project",
                      style: GoogleFonts.nunito(
                          fontSize: 40,
                          fontWeight: FontWeight.w800,
                          color: Colors.white)),
                ),
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xFF47AFFA),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 10),
                              blurRadius: 20,
                              spreadRadius: -18,
                              color: Colors.black)
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Text("Heavy Metals",
                          style: GoogleFonts.nunito(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.w400)),
                    ),
                  ),
                ),
                Center(
                  child: Column(
                    children: [
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: [
                          CardHeavy(
                            title: "Arsenic",
                            subtitle: "\nAs (III)",
                            onTap: () async {
                              pageController.setParameterHeavyMetals(
                                  useSubstance: "Arsenic Solution",
                                  title: "Arsenic",
                                  selecType: "As (III)");
                              serviceController.setSubstance(Substance.ARSENIC);
                              await Manager.setting
                                  .setFromModel(serviceController.setting);
                              for (final _p in Manager.result.peak) {
                                _p.m = 0.0374;
                                _p.c = 1.5564;
                              }
                              apiController.setHeavyMetalAPI(
                                  testingSubType: "Arsenic",
                                  settingModel: serviceController.setting);

                              Get.to(() => ProcessPage());
                            },
                          ),
                          CardHeavy(
                            title: "Chromium",
                            subtitle: "\nCr (VI)",
                            onTap: () async {
                              pageController.setParameterHeavyMetals(
                                  useSubstance: "Chromium Solution",
                                  title: "Chromium",
                                  selecType: "Cr (VI)");
                              serviceController
                                  .setSubstance(Substance.CHROMIUM);
                              await Manager.setting
                                  .setFromModel(serviceController.setting);
                              for (final _p in Manager.result.peak) {
                                //! P'tee
                                // _p.m = -0.4927;
                                // _p.c = -0.7089;

                                _p.m = -0.6307;
                                _p.c = 0.0407;
                              }
                              apiController.setHeavyMetalAPI(
                                  testingSubType: "Chromium",
                                  settingModel: serviceController.setting);

                              Get.to(() => ProcessPage());
                            },
                          ),
                          CardHeavy(
                            title: "Mercury",
                            subtitle: "\nHg (II)",
                            onTap: () async {
                              pageController.setParameterHeavyMetals(
                                  useSubstance: "Mercury Solution",
                                  title: "Mercury",
                                  selecType: "Hg (II)");

                              serviceController.setSubstance(Substance.MERCURY);
                              await Manager.setting
                                  .setFromModel(serviceController.setting);
                              for (final _p in Manager.result.peak) {
                                _p.m = 5.1604;
                                _p.c = 0.5767;
                              }
                              apiController.setHeavyMetalAPI(
                                  testingSubType: "Mercury",
                                  settingModel: serviceController.setting);

                              Get.to(() => ProcessPage());
                            },
                          ),
                          CardHeavy(
                            title: "Cd and Pb",
                            subtitle: "\nCd (II) and Pb (II)",
                            onTap: () async {
                              pageController.setParameterHeavyMetals(
                                  useSubstance: "Drop Solution",
                                  title: "Cadmium",
                                  selecType: "Cd (II)");
                              serviceController.setSubstance(
                                Substance.CADMIUM_LEAD,
                              );
                              await Manager.setting
                                  .setFromModel(serviceController.setting);
                              for (final _p in Manager.result.peak) {
                                if (count == 0) {
                                  _p.m = 0.0214;
                                  _p.c = -3.3615;
                                  count++;
                                } else if (count == 1) {
                                  _p.m = 0.0242;
                                  _p.c = -2.6865;
                                  count = 0;
                                }
                              }
                              apiController.setHeavyMetalAPI(
                                  testingSubType: "Cadmium",
                                  settingModel: serviceController.setting);

                              Get.to(() => ProcessPage());
                            },
                          ),
                          // CardHeavy(
                          //   title: "Lead",
                          //   subtitle: "\nPb (II)",
                          //   onTap: () async {
                          //     pageController.setParameterHeavyMetals(
                          //         title: "Lead", selecType: "Pb (II)");
                          //     pageController.setMockUpData("34.7");

                          //     serviceController.setSubstance(
                          //       Substance.CADMIUM_LEAD,
                          //     );
                          //     await Manager.setting
                          //         .setFromModel(serviceController.setting);
                          //     for (final _p in Manager.result.peak) {
                          //       _p.m = 0.0262;
                          //       _p.c = -2.1648;
                          //     }
                          //     apiController.setHeavyMetalAPI(
                          //         testingSubType: "Lead",
                          //         settingModel: serviceController.setting);

                          //     Get.to(() => ProcessPage());
                          //   },
                          // ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xFF47AFFA),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 10),
                              blurRadius: 20,
                              spreadRadius: -18,
                              color: Colors.black)
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Text("Pesticide",
                          style: GoogleFonts.nunito(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.w400)),
                    ),
                  ),
                ),
                CardPesticide(
                  title: "Molecularly Imprinted Polymer",
                  onTap: () {
                    Get.to(() => VegetableScreen(
                          isMIP: true,
                        ));
                  },
                  width: MediaQuery.of(context).size.width,
                ),
                SizedBox(
                  height: 10,
                ),
                CardPesticide(
                  title: "Enzyme Inhibition",
                  onTap: () {
                    Get.to(() => VegetableScreen(
                          isMIP: false,
                        ));
                  },
                  width: MediaQuery.of(context).size.width,
                ),
                SizedBox(
                  height: 80,
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: GestureDetector(
                      onTap: () {
                        print("MENU");
                        _drawerController.toggle!();
                        // Get.to(() => TestDev());
                        // await _launchURL();
                        // Get.to(() => HistoryPage());
                        // showDialog(
                        //     context: context,
                        //     builder: (BuildContext context) {
                        //       return CustomDialogBox(
                        //           title: "test", descriptions: "test", text: "tset");
                        //     });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color(0xFF47AFFA),
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                    offset: Offset(0, 10),
                                    blurRadius: 20,
                                    spreadRadius: -18,
                                    color: Colors.black)
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("MENU",
                                    style: GoogleFonts.nunito(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400)),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  Typicons.menu_outline,
                                  color: Colors.white,
                                  size: 15,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // GestureDetector(
                //   onTap: () async {
                //     print("history");
                //     Get.to(() => TestDev());
                //     // await _launchURL();
                //     // Get.to(() => HistoryPage());
                //     // showDialog(
                //     //     context: context,
                //     //     builder: (BuildContext context) {
                //     //       return CustomDialogBox(
                //     //           title: "test", descriptions: "test", text: "tset");
                //     //     });
                //   },

                //   child: Padding(
                //     padding: const EdgeInsets.symmetric(vertical: 10),
                //     child: Container(
                //       decoration: BoxDecoration(
                //           color: Color(0xFF47AFFA),
                //           borderRadius: BorderRadius.circular(30),
                //           boxShadow: [
                //             BoxShadow(
                //                 offset: Offset(0, 10),
                //                 blurRadius: 20,
                //                 spreadRadius: -18,
                //                 color: Colors.black)
                //           ]),
                //       child: Padding(
                //         padding: const EdgeInsets.symmetric(
                //             horizontal: 20, vertical: 10),
                //         child: Row(
                //           mainAxisSize: MainAxisSize.min,
                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //           children: [
                //             Text("History",
                //                 style: GoogleFonts.nunito(
                //                     fontSize: 20,
                //                     color: Colors.white,
                //                     fontWeight: FontWeight.w400)),
                //             SizedBox(
                //               width: 10,
                //             ),
                //             Icon(
                //               Icons.history,
                //               color: Colors.white,
                //               size: 20,
                //             ),
                //           ],
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          )
        ],
      )),
    );
  }

  Future<void> _launchURL() async => await canLaunch(
          "https://sicchemistry.azurewebsites.net/onde/pesticide")
      ? await launch("https://sicchemistry.azurewebsites.net/onde/pesticide")
      : throw 'Could not launch https://sicchemistry.azurewebsites.net/onde/pesticide';
}
