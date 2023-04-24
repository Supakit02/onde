part of service.provider;

class ProcessProvider extends GetxController {
  String _text = "";
  String _status = "assets/process/group-286.png";
  bool _complete = false;
  bool _isProcess = false;
  bool _changeFontSize = false;

  ProcessProvider() {
    _text = '';
    _status = "assets/process/group-286.png";
    _complete = false;
    _isProcess = false;
    _changeFontSize = false;
  }

  String get text => _text;
  String get status => _status;
  bool get complete => _complete;
  bool get isProcess => _isProcess;
  bool get changeFontSize => _changeFontSize;

  set text(String value) {
    _text = value;
    update();
  }

  set status(String value) {
    _status = value;
    update();
  }

  set complete(bool value) {
    _complete = value;
    update();
  }

  set isProcess(bool value) {
    _isProcess = value;
    update();
  }

  void setValues({
    String text = '',
    String status = "assets/process/group-286.png",
    bool complete = false,
    bool isProcess = false,
    bool notify = true,
    bool changeFontSize = false,
  }) {
   
      _text = text;
    
    _changeFontSize = changeFontSize;
    _status = status;
    _complete = complete;
    _isProcess = isProcess;

    if (notify) {
      update();
    }
  }
}
