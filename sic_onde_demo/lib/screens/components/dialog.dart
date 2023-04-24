import 'dart:typed_data';
import 'dart:ui';

import 'package:convert/convert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nfc_sic/nfc_sic.dart';

import 'package:sic_onde_demo/controller/PageDetailController.dart';
import 'package:sic_onde_demo/controller/service/LibService.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomDialogBox extends StatefulWidget {
  const CustomDialogBox({
    Key? key,
  }) : super(key: key);

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() {
    NFC.session.startSession(onTagDiscovered: _tagCallBack);
    Get.find<ProcessProvider>().setValues(
      notify: false,
      isProcess: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(left: 10, top: 55, right: 10, bottom: 20),
            margin: EdgeInsets.only(top: 45),
            decoration: BoxDecoration(
                border: Border.all(color: Color(0xFF47AFFA), width: 4),
                shape: BoxShape.rectangle,
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      offset: Offset(0, 10),
                      blurRadius: 10),
                ]),
            child: GetBuilder<ProcessProvider>(builder: (value) {
              if (value.isProcess == false) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Scan Card",
                      style: GoogleFonts.nunito(
                          fontSize: 24,
                          color: Color(0xFF47AFFA),
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: SafeArea(
                        child: Image(
                          image: ExactAssetImage(value.status, scale: 1.5),
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                );
              } else {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      "Select Mode",
                      style: GoogleFonts.nunito(
                          fontSize: 24,
                          color: Color(0xFF47AFFA),
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    // Text(
                    //   widget.descriptions,
                    //   style: TextStyle(fontSize: 14),
                    //   textAlign: TextAlign.center,
                    // ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: GestureDetector(
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
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400)),
                              ),
                            ),
                            onTap: () async {
                              Get.find<PageDetailController>()
                                  .setModeSearch("heavymetal");
                              await searchHistory(
                                  url: Get.find<PageDetailController>()
                                      .urlHistory);
                            },
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: GestureDetector(
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
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400)),
                              ),
                            ),
                            onTap: () async {
                              Get.find<PageDetailController>()
                                  .setModeSearch("pesticide");
                              await searchHistory(
                                  url: Get.find<PageDetailController>()
                                      .urlHistory);
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }
            })),
        Positioned(
          left: 20,
          right: 20,
          child: CircleAvatar(
            backgroundColor: Color(0xFF47AFFA),
            radius: 45,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(45)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image(
                  image:
                      ExactAssetImage("assets/chemical/history.png", scale: 10),
                ),
              ),
            ),
          ),
        ),
      ],
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
    Get.find<PageDetailController>().setUid(uid_test);
    if (isTag4341) {
      Get.find<ProcessProvider>().setValues(
        status: "assets/process/electrochem-process.gif",
        text: 'Chcek UID ..',
      );
      await Future.delayed(Duration(seconds: 2));
      Get.find<ProcessProvider>().setValues(
        isProcess: true,
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

  Future<void> searchHistory({required String url}) async =>
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
}

class CustomDialogError extends StatefulWidget {
  CustomDialogError(
      {Key? key,
      required this.text,
      required this.onTap,
      required this.pathImage,
      this.onlyRigth = true,
      this.hideBotton = false})
      : super(key: key);
  final String text;
  final String pathImage;
  final bool onlyRigth;
  final VoidCallback onTap;
  final bool hideBotton;
  @override
  _CustomDialogErrorState createState() => _CustomDialogErrorState();
}

class _CustomDialogErrorState extends State<CustomDialogError> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBoxError(context),
    );
  }

  contentBoxError(context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.only(left: 10, top: 55, right: 10, bottom: 20),
          margin: EdgeInsets.only(top: 45),
          decoration: BoxDecoration(
              border: Border.all(color: Color(0xFF47AFFA), width: 4),
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    offset: Offset(0, 10),
                    blurRadius: 10),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                widget.text,
                textAlign: TextAlign.center,
                style: GoogleFonts.nunito(
                    fontSize: 20,
                    color: Color(0xFF47AFFA),
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 30,
              ),
              // Text(
              //   widget.descriptions,
              //   style: TextStyle(fontSize: 14),
              //   textAlign: TextAlign.center,
              // ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  if (!widget.onlyRigth)
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: GestureDetector(
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
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400)),
                          ),
                        ),
                        onTap: widget.onTap,
                      ),
                    ),
                  if (!widget.hideBotton)
                    Align(
                      alignment: Alignment.bottomRight,
                      child: GestureDetector(
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
                            child: Text("OK",
                                style: GoogleFonts.nunito(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400)),
                          ),
                        ),
                        onTap: widget.onTap,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          left: 20,
          right: 20,
          child: CircleAvatar(
            backgroundColor: Color(0xFF47AFFA),
            radius: 45,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(45)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image(
                  image: ExactAssetImage(widget.pathImage, scale: 10),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class DialogHelper {
  static void showLoadingProcess({required String text}) {
    Get.defaultDialog(
      onWillPop: () async => false,
      barrierDismissible: false,
      title: "",
      backgroundColor: Colors.white.withOpacity(0.0),
      radius: 50,
      content: Center(
        child: Column(
          children: [
            SizedBox(
              height: 60,
              width: 60,
              child: CircularProgressIndicator(
                // color: Color(0xFF73C2FB),
                color: Colors.white,
                strokeWidth: 5,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(text,
                  style: GoogleFonts.nunito(
                      fontSize: 20,
                      // color: Color(0xFF73C2FB),
                      color: Colors.white,
                      fontWeight: FontWeight.w400)),
            )
          ],
        ),
      ),
    );
  }

  static void dialogShow({required String text}) {
    Get.dialog(
      Material(
        type: MaterialType.transparency,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 60,
                width: 60,
                child: CircularProgressIndicator(
                  // color: Color(0xFF73C2FB),
                  color: Colors.white,
                  strokeWidth: 5,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(text,
                    style: GoogleFonts.nunito(
                        fontSize: 20,
                        // color: Color(0xFF73C2FB),
                        color: Colors.white,
                        fontWeight: FontWeight.w400)),
              )
            ],
          ),
        ),
      ),
      barrierDismissible: false,
      // barrierColor: Colors.transparent,
    );
  }

  static void hideLoading() {
    if (Get.isDialogOpen == true) {
      Get.back();
    }
  }
}
