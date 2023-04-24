import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import 'package:nfc_sic/controller/DataController.dart';

class PageDetailController extends GetxController {
  String _modeSearch = "";
  String _uid = "";

  String get urlHistory =>
      "https://sicchemistry.azurewebsites.net/onde/$_modeSearch";

  String get modeSearch => _modeSearch;
  String get uid => _uid;

  void setModeSearch(String value) {
    _modeSearch = value;
    update();
  }

  void setUid(String value) {
    _uid = value;
    update();
  }

  String data = Get.put(DataController()).data;

  String _useSubstance = "";

  String _modeProcess = "";
  String _modeTitle = "";
  String _selectType = "";

  String _pathImage = "";

  String _mockUpData = "";

  bool _stateProcess = false;
  bool _processComplete = false;

  String get modeProcess => _modeProcess;
  String get modeTitle => _modeTitle;
  String get selectType => _selectType;

  String get pathImage => _pathImage;

  String get mockUpData => _mockUpData;

  bool get stateProcess => _stateProcess;
  bool get processComplete => _processComplete;

  String get useSubstance => _useSubstance;
  void setModeProcess(String mode) {
    _modeProcess = mode;
    update();
  }

  void setModeTitle(String title) {
    _modeTitle = title;
    update();
  }

  void setSelectType(String selectType) {
    _selectType = selectType;
    update();
  }

  void setPathImage(String path) {
    _pathImage = path;
    update();
  }

  void setMockUpData(String data) {
    _mockUpData = data;
    update();
  }

  void setStateProcess(bool state) {
    _stateProcess = state;
    update();
  }

  void setProcessComplete(bool state) {
    _processComplete = state;
    update();
  }

  void setUseSubstance(String value) {
    _useSubstance = value;
    update();
  }

  void setParameterHeavyMetals(
      {String mode = "Heavy Metals",
      String path = "assets/process/group-286.png",
      String useSubstance = "",
      required String title,
      required String selecType}) {
    _modeProcess = mode;
    _modeTitle = title;
    _selectType = selecType;
    _pathImage = path;
    _useSubstance = useSubstance;
    update();
  }
}
