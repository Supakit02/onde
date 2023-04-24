import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sic_onde_demo/TEST/modelbutton.dart';

class TestDev extends StatefulWidget {
  TestDev({Key? key}) : super(key: key);

  @override
  _TestDevState createState() => _TestDevState();
}

class _TestDevState extends State<TestDev> {
  Future<void> getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
      timeLimit: Duration(seconds: 2),
    );
    print(
        "Latitude : ${position.latitude} ,Longittude : ${position.longitude}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TEST DEV"),
      ),
      body: Column(
        children: [
          ButtonCustom(
              text: "TEST",
              onPressed: () async {
                
                await getLocation();
                print("test");
              })
        ],
      ),
    );
  }
}
