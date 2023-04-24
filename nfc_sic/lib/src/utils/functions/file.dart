part of nfc_sic.utils;

/// Function managing export file to log data.
class FileFunc {
  FileFunc._();

  /// Writing data and create text file to directory log file.
  static Future<bool> export({
    @required String data,
    String type = 'unknown',
    DateTime date,
    String directory,
  }) async {
    final _permission = Permission.storage;
    final _imageByte = Manager.result.imageByte;
    final _fileName = Manager.setting.get().fileName;
    final _uid = _ReportFunc.uid;

    try {
      var _status = await _permission.status;

      if ( !_status.isGranted ) {
        _status = await _permission.request();
      }

      if ( _status.isGranted ) {
        var _imagePath = "";
        var _textPath = "";
        var _folderPath = await _pathFile(directory);
        // debugPrint("pathFile: $_folderPath");

        if ( await _createFolder(_folderPath) ) {
          final _nameDefault = await Future.value(
            _ReportFunc.getDateTime(date));

          if ( _fileName.isEmpty ) {
            final _name = "${type}__${_nameDefault}__$_uid";

            _folderPath = join(
              _folderPath,
              _name);

            _imagePath = "$_folderPath/$_name.png";
            _textPath = "$_folderPath/$_name.txt";
          } else {
            final _name = "${_fileName}__${type}__${_nameDefault}__$_uid";

            _folderPath = join(
              _folderPath,
              _name);

            _imagePath = "$_folderPath/$_name.png";
            _textPath = "$_folderPath/$_name.txt";
          }
          // debugPrint("pathFile: $_folderPath");

          if ( await _createFolder(_folderPath) ) {
            if ( _imageByte != null ) {
              var _fileImage = File(_imagePath);
              // debugPrint("image file: $_imagePath");

              if ( !_fileImage.existsSync() ) {
                _fileImage = await _fileImage.writeAsBytes(_imageByte);

                // if ( await _fileImage.exists() ) {
                //   debugPrint("Image file exported successfully");
                // }
              }
            }

            var _fileText = File(_textPath);
            // debugPrint("text file: $_textPath");

            if ( !_fileText.existsSync() ) {
              _fileText = await _fileText.writeAsString(data);

              return _fileText.existsSync();
            }
          }
        }
      }
    } catch (error, stackTrace) {
      // several error may come out with file handling or OOM
      CaptureException.instance.exception(
        message: "Export file error on export(FileFunc)",
        error: error,
        stackTrace: stackTrace ?? StackTrace.current);
    }

    // debugPrint("File can not exported");
    return false;
  }

  static Future<String> _pathFile(String directory) async {
    Directory _directory;

    if ( Platform.isIOS ) {
      _directory = await getApplicationDocumentsDirectory();
    } else {
      _directory = await getExternalStorageDirectory();
    }

    return join(
      _directory.path,
      directory ?? "nfc_sic");
  }

  static Future<bool> _createFolder(String path) async {
    var _directory = Directory(path);

    if ( !_directory.existsSync() ) {
      _directory = await _directory.create();

      return _directory.existsSync();
    }

    return true;
  }
}