part of lib.screens;

class SelectMode extends StatefulWidget {
  SelectMode({
    Key? key,
    required this.product,
    required this.isMIP,
  }) : super(key: key);

  final bool isMIP;
  final Product product;

  @override
  _SelectModeState createState() => _SelectModeState();
}

class _SelectModeState extends State<SelectMode> {
  final pageController = Get.find<PageDetailController>();
  final serviceController = Get.find<SettingProvider>();
  final constantController = Get.find<SettingConstantLinear>();
  final apiController = Get.find<APIController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Color(0xFF73C2FB),
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Get.back();
            },
          ),
          title: Text(
            widget.product.title!,
            style: GoogleFonts.nunito(color: Colors.white, fontSize: 30),
          )),
      body: Column(
        children: [
          AspectRatio(
            aspectRatio: 2,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  decoration: BoxDecoration(color: Color(0xFF73C2FB)),
                  width: double.infinity,
                  child: Hero(
                      tag: widget.product.title!,
                      child: Image.asset(widget.product.image!)),
                ),
                Positioned(
                  bottom: -25,
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Color(0xFF41ACFA),
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(35),
                              bottomRight: Radius.circular(35),
                            ),
                            boxShadow: [
                              BoxShadow(
                                  color: Color(0xFF41ACFA).withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 7,
                                  offset: Offset(0, 3))
                            ]),
                        height: 50,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            child: Row(
                              children: [
                                Text(
                                  "Select Mode",
                                  style: GoogleFonts.nunito(
                                      fontSize: 16, color: Colors.white),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  Icons.architecture_outlined,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 40,
          ),
          if (widget.isMIP)
            Expanded(
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      CardPesticide(
                        cardColor: Color(0xFF73C2FB),
                        iconColor: Color(0xFF73C2FB),
                        textColor: Colors.white,
                        circleColor: Colors.white,
                        title: "Cypermethrin",
                        onTap: () async {
                          pageController.setParameterHeavyMetals(
                              useSubstance: "Ethanol solution",
                              mode: "Pesticide",
                              title: widget.product.title!,
                              selecType: "MIP (Cypermethrin)");
                          serviceController
                              .setSubstance(Substance.CYPERMETHRIN);
                          constantController.setConstantLinear(
                              vegatableName: widget.product.title!,
                              substance: Substance.CYPERMETHRIN);
                          await Manager.setting
                              .setFromModel(serviceController.setting);
                          print(Manager.setting.get().toString());
                          for (final _p in Manager.result.peak) {
                            _p.first = true;
                          }
                          serviceController.setFirstEnzyme(false);
                          serviceController.setLastEnzyme(false);

                          apiController.setPesticideAPI(
                              testingType: "MIP",
                              testingSubType: "Cypermethrin",
                              vegetable: widget.product.title!,
                              settingModel: serviceController.setting);

                          Get.to(() => ProcessPage());
                        },
                        width: MediaQuery.of(context).size.width,
                      ),
                      SizedBox(height: 20),
                      CardPesticide(
                        cardColor: Color(0xFF73C2FB),
                        iconColor: Color(0xFF73C2FB),
                        textColor: Colors.white,
                        circleColor: Colors.white,
                        title: "Carbaryl",
                        onTap: () async {
                          pageController.setParameterHeavyMetals(
                              useSubstance: "Ethanol solution",
                              mode: "Pesticide",
                              title: widget.product.title!,
                              selecType: "MIP (Carbaryl)");
                          serviceController.setSubstance(Substance.CARBARYL);
                          constantController.setConstantLinear(
                              vegatableName: widget.product.title!,
                              substance: Substance.CARBARYL);
                          await Manager.setting
                              .setFromModel(serviceController.setting);

                          print(Manager.setting.get().toString());
                          for (final _p in Manager.result.peak) {
                            _p.first = true;
                          }
                          serviceController.setFirstEnzyme(false);
                          serviceController.setLastEnzyme(false);
                          apiController.setPesticideAPI(
                              testingType: "MIP",
                              testingSubType: "Carbaryl",
                              vegetable: widget.product.title!,
                              settingModel: serviceController.setting);

                          Get.to(() => ProcessPage());
                        },
                        width: MediaQuery.of(context).size.width,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          if (!widget.isMIP)
            Expanded(
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      CardPesticide(
                        cardColor: Color(0xFF73C2FB),
                        iconColor: Color(0xFF73C2FB),
                        textColor: Colors.white,
                        circleColor: Colors.white,
                        title: "Chlorpyrifos",
                        onTap: () async {
                          pageController.setParameterHeavyMetals(
                              useSubstance: "Phosphate Buffer",
                              mode: "Pesticide",
                              title: widget.product.title!,
                              selecType: "Enzyme (Chlorpyrifos)");
                          serviceController
                              .setSubstance(Substance.CHLORPYRIFOS);

                          serviceController.setUsePrevOffset(false);
                          await Manager.setting
                              .setFromModel(serviceController.setting);
                          constantController
                              .setVegetableName(widget.product.title!);

                          serviceController.setFirstEnzyme(true);
                          serviceController.setLastEnzyme(false);
                          for (final _p in Manager.result.peak) {
                            _p.first = true;
                            _p.firstEnzyme = true;
                          }

                          apiController.setPesticideAPI(
                              testingType: "Enzyme",
                              testingSubType: "Chlorpyrifos",
                              vegetable: widget.product.title!,
                              settingModel: serviceController.setting);

                          Get.to(() => ProcessPage());
                        },
                        width: MediaQuery.of(context).size.width,
                      ),
                    ],
                  ),
                ),
              ),
            )

          // Row(
          //   children: [
          //     Container(
          //       decoration: BoxDecoration(
          //           color: Colors.red,
          //           borderRadius: BorderRadius.only(
          //             bottomRight: Radius.circular(35),
          //           )),
          //       height: 50,
          //       child: Center(
          //         child: Padding(
          //           padding:
          //               const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          //           child: Row(
          //             children: [
          //               Text(
          //                 "Select Mode",
          //                 style: GoogleFonts.nunito(
          //                     fontSize: 16, color: Colors.white),
          //               ),
          //               SizedBox(
          //                 width: 10,
          //               ),
          //               Icon(
          //                 Icons.architecture_outlined,
          //                 color: Colors.white,
          //               ),
          //               SizedBox(
          //                 width: 10,
          //               ),
          //             ],
          //           ),
          //         ),
          //       ),
          //     ),
          //   ],
          // )
        ],
      ),
    );
  }
}
