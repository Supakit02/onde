import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:nfc_sic/nfc_sic.dart';
import 'package:sic_onde_demo/API/libAPI.dart';
import 'package:sic_onde_demo/controller/LoginController.dart';

class APIController extends GetxController {
  String _uid = "";
  String _mode = "";
  String _testingType = "";
  String _testingSubType = "";
  String _vegetable = "";
  List<Result> _rawResult = [];
  List<String> _rawStringResult = [];
  List<Result> _fristResult = [];
  List<Result> _secondResult = [];
  String _fristADC = "0";
  String _secondADC = "0";
  double _lati = 0.0;
  double _longit = 0.0;

  double _result = 0.0;
  String _operateTime = "";

  Setting _setting = Setting();

  String get uid => _uid;
  String get testingType => _testingType;
  String get testingSubType => _testingSubType;
  String get vegetable => _vegetable;

  List<Result> get fristResult => _fristResult;
  List<Result> get secondResult => _secondResult;
  Setting get setting => _setting;

  void setFristRawResult(List<Result> isResult) {
    _fristResult = isResult;
    for (var _res in _fristResult) {
      var _time = _res.tSamp / 1000.0;
      if (_time == 10.0) {
        _fristADC = _res.adcOut.toString();
      } else if (_time == 30.0) {
        _secondADC = _res.adcOut.toString();
      }
    }
    update();
  }

  void setSecondRawResult(List<Result> isResult) {
    _secondResult = isResult;
    update();
  }

  void setResult(double value) {
    _result = value;
  }

  void setResultPesticide(
      {required double result, required List<String> rawStringResult}) {}

  void setResultHeavy(
      {required double result, required List<String> rawStringResult}) {
    _result = result;
    _rawStringResult = rawStringResult;
    update();
  }

  void setTestingType({required String testingSubType}) {
    _testingSubType = testingSubType;
    update();
  }

  void setSettingAPi(Setting settingModel) {
    _setting = settingModel;
    update();
  }

  void setHeavyMetalAPIOnlyPb(
      {required String testingSubType, required Setting settingModel}) {
    _testingType = "heavymetal";
    _testingSubType = testingSubType;
    _vegetable = "";
    _mode = "DPV";
    _setting = settingModel;
    update();
  }

  void setHeavyMetalAPI(
      {required String testingSubType, required Setting settingModel}) {
    _testingType = "heavymetal";
    _testingSubType = testingSubType;
    _vegetable = "";
    _mode = "DPV";
    _setting = settingModel;
    update();
  }

  void setPesticideAPI(
      {required String testingType,
      required String testingSubType,
      required String vegetable,
      required Setting settingModel}) {
    _testingType = testingType;
    _testingSubType = testingSubType;
    _vegetable = vegetable;
    _mode = "CA";
    _setting = settingModel;
    update();
  }

  void setUid(String uid) {
    _uid = uid;
    update();
  }

  String get operateTimeAPI {
    String _date = getDate(DateTime.now());
    String _time = getTime(DateTime.now());
    String _operateTime = "$_date $_time";
    return _operateTime;
  }

  Future<void> getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
      timeLimit: Duration(seconds: 2),
    );
    print(
        "Latitude : ${position.latitude} ,Longittude : ${position.longitude}");
  }

  Future<void> postAPI({bool usePervLocation = false}) async {
    try {
      if (usePervLocation == false) {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 5),
        );
        _lati = position.latitude;
        _longit = position.longitude;
        print(
            "Latitude : ${position.latitude} ,Longittude : ${position.longitude}");
      }

      print("this $_lati , $_longit");
    } catch (e) {
      print(e);
      print("this $_lati , $_longit");
      if (usePervLocation == false) {
        _lati = 0.0;
        _longit = 0.0;
      }
    }
    print(_result);
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${Get.find<LoginController>().token}',
      };
      var request = http.Request(
          'POST', Uri.parse('https://sicchemistryapi.azurewebsites.net/onde'));
      request.body = ONDEModelToJson(dataModelAPI);
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print(e);
    }
  }

  ONDEModel get dataModelAPI {
    ONDEModel _dataModelAPi = ONDEModel(
        uid: _uid,
        testingType: _testingType,
        testingSubType: _testingSubType,
        vegetable: _vegetable,
        potentiostatSetting: settingPotentiostatSetting,
        rawData: isRawStringResult,
        result: _result.toPrecision(3),
        temperature: 0.0,
        operateTime: operateTimeAPI,
        operateByUserId: "SIC",
        latitude: _lati,
        longitude: _longit);
    return _dataModelAPi;
  }

  List<String> get isRawStringResult {
    switch (_testingType) {
      case "heavymetal":
        return _rawStringResult;
      case "MIP":
        return rawStringMIP;
      case "Enzyme":
        return rawStringEnzyme;

      default:
        return ["0"];
    }
  }

  List<String> get rawStringMIP {
    List<String> _rawStringMIP = [];
    for (var _res in _secondResult) {
      var _time = _res.tSamp / 1000.0;
      if (_time == 100.0) {
        _rawStringMIP.add(_res.adcOut.toString());
      } else if (_time == 280.0) {
        _rawStringMIP.add(_res.adcOut.toString());
      }
    }
    return _rawStringMIP;
  }

  List<String> get rawStringEnzyme {
    List<String> _rawStringEnzyme = [];
    _rawStringEnzyme.add(_fristADC);
    _rawStringEnzyme.add(_secondADC);
    for (var _res in _secondResult) {
      var _time = _res.tSamp / 1000.0;
      if (_time == 10.0) {
        _rawStringEnzyme.add(_res.adcOut.toString());
      } else if (_time == 30.0) {
        _rawStringEnzyme.add(_res.adcOut.toString());
      }
    }

    return _rawStringEnzyme;
  }

  PotentiostatSetting get settingPotentiostatSetting {
    switch (_testingSubType) {
      case "Arsenic":
      case "Chromium":
      case "Mercury":
      case "Cadmium":
      case "Lead":
        return PotentiostatSetting(
            mode: _mode,
            eCond: _setting.eCondition,
            tCond: _setting.tCondition,
            eDepo: _setting.eCondition,
            tDepo: _setting.tDeposition,
            tEqui: 0,
            eInit: _setting.eBegin,
            eCvLimit1: 0.0,
            eCvLimit2: 0.0,
            eFinal: _setting.eEnd,
            cvCycle: 0,
            tRun: 0,
            eAmp: _setting.ePulse.toDouble(),
            eStep: _setting.eStep.toDouble(),
            tStep: _setting.tStep.toDouble());
      case "Cypermethrin":
      case "Carbaryl":
        return PotentiostatSetting(
            mode: _mode,
            eCond: _setting.eCondition,
            tCond: _setting.tCondition,
            eDepo: _setting.eCondition,
            tDepo: _setting.tDeposition,
            tEqui: 0,
            eInit: _setting.eDc1,
            eCvLimit1: 0.0,
            eCvLimit2: 0.0,
            eFinal: 0.0,
            cvCycle: 0,
            tRun: 180,
            eAmp: 0.0,
            eStep: 0.0,
            tStep: 0.0);
      case "Chlorpyrifos":
        return PotentiostatSetting(
            mode: _mode,
            eCond: _setting.eCondition,
            tCond: _setting.tCondition,
            eDepo: _setting.eCondition,
            tDepo: _setting.tDeposition,
            tEqui: 0,
            eInit: _setting.eDc1,
            eCvLimit1: 0.0,
            eCvLimit2: 0.0,
            eFinal: 0.0,
            cvCycle: 0,
            tRun: 300,
            eAmp: 0.0,
            eStep: 0.0,
            tStep: 0.0);

      default:
        return PotentiostatSetting(
          mode: "Unknow",
          eCond: 0.0,
          tCond: 0,
          eDepo: 0.0,
          tDepo: 0,
          tEqui: 0,
          eInit: 0.0,
          eCvLimit1: 0.0,
          eCvLimit2: 0.0,
          eFinal: 0.0,
          cvCycle: 0,
          tRun: 0,
          eAmp: 0.0,
          eStep: 0.0,
          tStep: 0,
        );
    }
  }

  static String _fourDigits(int n) => n.toString().padLeft(4, "0");

  static String _twoDigits(int n) => n.toString().padLeft(2, "0");

  static String getDateTime(DateTime date) {
    assert(date != null, 'date cannot be null');

    final y = _fourDigits(date.year);
    final m = _twoDigits(date.month);
    final d = _twoDigits(date.day);
    final h = _twoDigits(date.hour);
    final min = _twoDigits(date.minute);
    final sec = _twoDigits(date.second);

    return "$y-$m-${d}_$h-$min-$sec";
  }

  static String getDate(DateTime date) {
    assert(date != null, 'date cannot be null');

    final d = _twoDigits(date.day);
    final m = _twoDigits(date.month);
    final y = _fourDigits(date.year);

    return "$y/$m/$d";
  }

  static String getTime(DateTime date) {
    assert(date != null, 'date cannot be null');

    final hour = _twoDigits(date.hour);
    final min = _twoDigits(date.minute);
    final sec = _twoDigits(date.second);

    return "$hour:$min:$sec";
  }
}
