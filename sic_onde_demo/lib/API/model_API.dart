part of lib.api;

// To parse this JSON data, do
//
//     final ONDEModel = ONDEModelFromJson(jsonString);

ONDEModel ONDEModelFromJson(String str) => ONDEModel.fromJson(json.decode(str));

String ONDEModelToJson(ONDEModel data) => json.encode(data.toJson());

class ONDEModel {
  ONDEModel({
    @required this.uid,
    @required this.testingType,
    @required this.testingSubType,
    @required this.vegetable,
    @required this.potentiostatSetting,
    @required this.rawData,
    @required this.result,
    @required this.temperature,
    @required this.operateTime,
    @required this.operateByUserId,
    @required this.latitude,
    @required this.longitude,
  });

  String? uid;
  String? testingType;
  String? testingSubType;
  String? vegetable;
  PotentiostatSetting? potentiostatSetting;
  // String? rawData; // ! : Only Test rawData
  List<String>? rawData;
  double? result;
  double? temperature;
  String? operateTime;
  String? operateByUserId;
  double? latitude;
  double? longitude;

  factory ONDEModel.fromJson(Map<String, dynamic> json) => ONDEModel(
        uid: json["uid"],
        testingType: json["testingType"],
        testingSubType: json["testingSubType"],
        vegetable: json["vegetable"],
        potentiostatSetting:
            PotentiostatSetting.fromJson(json["potentiostatSetting"]),
        // rawData: json["rawData"], // ! : Only Test rawData
        rawData: List<String>.from(json["rawData"].map((x) => x)),
        result: json["result"].toDouble(),
        temperature: json["temperature"].toDouble(),
        operateTime: json["operateTime"],
        operateByUserId: json["operateByUserId"],
        latitude: json["latitude"].toDouble(),
        longitude: json["longitude"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "testingType": testingType,
        "testingSubType": testingSubType,
        "vegetable": vegetable,
        "potentiostatSetting": potentiostatSetting?.toJson(),
        // "rawData": rawData, // ! : Only Test rawData
        "rawData": List<dynamic>.from(rawData!.map((x) => x)),
        "result": result,
        "temperature": temperature,
        "operateTime": operateTime,
        "operateByUserId": operateByUserId,
        "latitude": latitude,
        "longitude": longitude
      };
}

class PotentiostatSetting {
  PotentiostatSetting({
    @required this.mode,
    @required this.eCond,
    @required this.tCond,
    @required this.eDepo,
    @required this.tDepo,
    @required this.tEqui,
    @required this.eInit,
    @required this.eCvLimit1,
    @required this.eCvLimit2,
    @required this.eFinal,
    @required this.cvCycle,
    @required this.tRun,
    @required this.eAmp,
    @required this.eStep,
    @required this.tStep,
  });

  String? mode;
  double? eCond;
  int? tCond;
  double? eDepo;
  int? tDepo;
  int? tEqui;
  double? eInit;
  double? eCvLimit1;
  double? eCvLimit2;
  double? eFinal;
  int? cvCycle;
  int? tRun;
  double? eAmp;
  double? eStep;
  double? tStep;

  factory PotentiostatSetting.fromJson(Map<String, dynamic> json) =>
      PotentiostatSetting(
        mode: json["Mode"],
        eCond: json["E_cond"].toDouble(),
        tCond: json["t_cond"],
        eDepo: json["E_depo"].toDouble(),
        tDepo: json["t_depo"],
        tEqui: json["t_equi"],
        eInit: json["E_init"].toDouble(),
        eCvLimit1: json["E_CV_limit1"].toDouble(),
        eCvLimit2: json["E_CV_limit2"].toDouble(),
        eFinal: json["E_final"].toDouble(),
        cvCycle: json["CV_Cycle"],
        tRun: json["t_run"],
        eAmp: json["E_amp"].toDouble(),
        eStep: json["E_step"].toDouble(),
        tStep: json["t_step"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "Mode": mode,
        "E_cond": eCond,
        "t_cond": tCond,
        "E_depo": eDepo,
        "t_depo": tDepo,
        "t_equi": tEqui,
        "E_init": eInit,
        "E_CV_limit1": eCvLimit1,
        "E_CV_limit2": eCvLimit2,
        "E_final": eFinal,
        "CV_Cycle": cvCycle,
        "t_run": tRun,
        "E_amp": eAmp,
        "E_step": eStep,
        "t_step": tStep,
      };
}
