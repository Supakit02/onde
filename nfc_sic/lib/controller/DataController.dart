import 'package:get/get.dart';

class DataController extends GetxController {
  String _data = "";

  int _time = 0;
  int _timeCount = 0;

  bool _conversionState = false ;

  int get time => _time;

  String get data => _data;

  bool get conversionState => _conversionState;

  void setConversionState (bool value) {
    _conversionState = value ;
    update();
  }

  void setTime(int value) {
    _time = value;
    _timeCount = value;
    _conversionState = true ;
    _data = "Conversion Time $value";
    update();
  }

  void setData() {
    _timeCount--;
    _data = "Conversion Time ${_timeCount}";
    print(_data);
    update();
  }
}
