import 'package:flutter/cupertino.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:sic_onde_demo/screens/LibScreens.dart';

void main() {
  runApp(ToxinSIC());
}


class ToxinSIC extends StatelessWidget {
  const ToxinSIC({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      
      debugShowCheckedModeBanner: false,
      title: "DEMO TOXIN",
      // home: HomeScreen(),
      home: LoginPage(),
    );
  }
}
