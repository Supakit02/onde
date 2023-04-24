import 'package:connectivity/connectivity.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sic_onde_demo/screens/LibScreens.dart';
import 'package:sic_onde_demo/screens/components/dialog.dart';

class LoginController extends GetxController {
  // todo : Parameter
  bool _isSignUp = false;
  bool _isRemember = false;
  bool _validator = false;
  String _user = "";
  String _password = "";
  String _token = "";

  // todo : Add NEW USER
  String _userNew = "";
  String _firstName = "";
  String _lastName = "";
  String _group = "";
  String _email = "";
  String _passwordNew = "";

  // todo : Getter
  bool get isSignUp => _isSignUp;
  bool get isRemember => _isRemember;
  String get user => _user;
  String get password => _password;
  String get token => _token;

  String get userNew => _userNew;
  String get firstName => _firstName;
  String get lastName => _lastName;
  String get group => _group;
  String get email => _email;
  String get passwordNew => _passwordNew;

  // todo : Setter
  void setIsSignUp(bool value) {
    _isSignUp = value;
    update();
  }

  void setIsRemember(bool value) {
    _isRemember = value;
    update();
  }

  void setUser(String value) {
    _user = value;
    update();
  }

  void setPassword(String value) {
    _password = value;
    update();
  }

  void setAuth({required String username, required String password}) {
    _user = username;
    _password = password;
    update();
  }

  Future<void> setNewUser(
      {required String firstName,
      required String lastName,
      required String email,
      required String group,
      required String username,
      required String password}) async {
    if (firstName.isEmpty ||
        lastName.isEmpty ||
        email.isEmpty ||
        group.isEmpty ||
        username.isEmpty ||
        password.isEmpty) {
      Get.dialog(CustomDialogError(
          text: "Please fill all information",
          onTap: () {
            Get.back();
          },
          pathImage: "assets/chemical/warning.png"));
    } else {
      _firstName = firstName;
      _lastName = lastName;
      _email = email;
      _group = group;
      _userNew = username;
      _passwordNew = password;
      await addNewUser();
    }
  }

  // todo : Func

  void clearToken() {
    _token = "";
    update();
  }

  Future<void> addNewUser() async {
    // DialogHelper.showLoadingProcess(text: "Login");
    DialogHelper.dialogShow(text: "Sign Up ..");
    var headers = {
      'Content-Type': 'application/json',
    };
    var request = http.Request(
        'POST', Uri.parse('https://sicchemistryapi.azurewebsites.net/users'));
    request.body = json.encode({
      "firstname": _firstName,
      "lastname": _lastName,
      "email": _email,
      "group": _group,
      "username": _userNew,
      "role": "user",
      "passwd": _passwordNew
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200 || response.statusCode == 201) {
      print(await response.stream.bytesToString());
      DialogHelper.hideLoading();
      Get.dialog(
        CustomDialogError(
            text: "Success.",
            onTap: () {
              Get.back();
              _isSignUp = false;
            },
            pathImage: "assets/chemical/checked.png"),
      );
    } else {
      DialogHelper.hideLoading();

      Get.dialog(
        CustomDialogError(
            text: "Forbidden.",
            onTap: () {
              Get.back();
            },
            pathImage: "assets/chemical/warning.png"),
      );

      print(response.reasonPhrase);
    }
  }

  Future<bool> CheckConnect() async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    switch (connectivityResult) {
      case ConnectivityResult.mobile:
      case ConnectivityResult.wifi:
        print("Connect");

        return true;
      default:
        return false;
    }
  }

  Future<bool> ConnectingNetwork() async {
    DialogHelper.dialogShow(text: "Connecting ..");
    final checkConnect = await CheckConnect();
    if (checkConnect) {
      print("Connect Internet");
      DialogHelper.hideLoading();
      return true;
    } else {
      DialogHelper.hideLoading();
      Get.dialog(
        CustomDialogError(
            text: "Please connect to the internet.",
            onTap: () {
              Get.back();
            },
            pathImage: "assets/chemical/warning.png"),
      );
      return false;
    }
  }

  Future<void> authLogin() async {
    // DialogHelper.showLoadingProcess(text: "Login");
    DialogHelper.dialogShow(text: "Login ..");
    var headers = {
      'Content-Type': 'application/json',
    };
    var request = http.Request(
        'POST', Uri.parse('https://sicchemistryapi.azurewebsites.net/auth'));
    request.body = json.encode({"username": _user, "passwd": _password});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      var responseData = await response.stream.bytesToString();
      final responseDataToken = json.decode(responseData);
      _token = responseDataToken["toke"];
      print(_token);
      DialogHelper.hideLoading();
      Get.off(HomeScreen());
    } else {
      DialogHelper.hideLoading();

      Get.dialog(
        CustomDialogError(
            text: "Username or password incorrect.",
            onTap: () {
              Get.back();
            },
            pathImage: "assets/chemical/warning.png"),
      );

      print(response.reasonPhrase);
    }
  }
}
