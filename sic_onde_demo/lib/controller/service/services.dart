library services;

import 'package:flutter/material.dart';

import 'package:get/get.dart';

typedef AsyncCallback<A> = void Function(AsyncSnapshot<A> snapshot);

class AppService {
  AppService._();

  static Future<T?> loadDialog<T, F>({
    required Future<F> future,
    AsyncCallback<Object?>? onDone,
  }) async {
    return Get.dialog<T>(Dialog(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Container(
        alignment: Alignment.center,
        child: FutureBuilder(
            future: future,
            builder: (_, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (onDone != null) {
                  onDone(snapshot);
                }
              }

              return CircularProgressIndicator();
            }),
      ),
    ));
  }

  static Future<T?> errorDialog<T>({
    required String title,
    Widget? content,
    VoidCallback? onBack,
  }) async {
    return Get.defaultDialog<T>(
      barrierDismissible: false,
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      title: title,
      titleStyle: Get.textTheme.headline6,
      content: content,
      actions: <Widget>[
        Container(
          child: ElevatedButton(
            child: Text(
              'EXIT',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
            onPressed: onBack,
          ),
        ),
      ],
    );
  }
}
