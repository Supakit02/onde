import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sic_onde_demo/TEST/testdev.dart';
import 'package:sic_onde_demo/controller/LoginController.dart';
import 'package:sic_onde_demo/model/MenuItem.dart';
import 'package:sic_onde_demo/screens/LibScreens.dart';
import 'package:sic_onde_demo/screens/components/dialog.dart';

class DrawerScreen extends StatefulWidget {
  DrawerScreen({Key? key}) : super(key: key);

  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[400],
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Padding(
            //   padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            //   child: Text(
            //     "Welcome",
            //     style: GoogleFonts.nunito(
            //         fontSize: 30,
            //         color: Colors.white,
            //         fontWeight: FontWeight.w400),
            //   ),
            // ),
            Spacer(
                // flex: 3,
                ),
            BuildMenu(
                title: "History",
                icon: Icons.history,
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CustomDialogBox();
                      });
                }),
            BuildMenu(
                title: "DEV",
                icon: Icons.developer_board,
                onTap: () {
                  Get.to(() => TestDev());
                }),
            BuildMenu(
                title: "Log out",
                icon: Icons.logout,
                onTap: () {
                  Get.find<LoginController>().clearToken();
                  Get.off(() => LoginPage());
                }),

            Spacer(
              flex: 2,
            ),
            Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Text(
                    "Version : 1.0.7.DEV",
                    style: GoogleFonts.nunito(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.w400),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
