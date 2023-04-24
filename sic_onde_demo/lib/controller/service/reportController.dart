part of service.provider;

class ReportController extends GetxController {

  Future<String> getFilePath(String fileName) async {
    Directory? appDocumentsDirectory = await getExternalStorageDirectory();
    String appDocumentsPath = appDocumentsDirectory!.path;
    print(appDocumentsPath);
    String filePath = "$appDocumentsPath/${fileName}.txt";

    return filePath;
  }

  Future<void> saveFile(
      {required String fileName, required String data}) async {
    File file = File(await getFilePath(fileName));
    file.writeAsString(data);
  }

  Future<bool> _exportReport() async {
    if (Platform.isAndroid) {
      try {
        final _date = DateTime.now();
        final _note = Manager.setting.note;
        final _substance = Manager.setting.get().substance;

        final _export = await FileFunc.export(
            data: _substance.getReport(
                date: _date, version: "1.0.4", note: _note),
            type: _substance.shortText,
            date: _date,
            directory: "TEST");

        return _export;
      } catch (error, stackTrace) {
        CaptureException.instance.exception(
            message: "Error on export report file",
            library: "TESTAPP Exception",
            error: error,
            stackTrace: stackTrace);
      }
    }

    return false;
  }
}
