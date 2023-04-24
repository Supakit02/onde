library lib.screens;

import 'dart:io';
import 'dart:typed_data' show Uint8List;
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:convert/convert.dart' show hex;
import 'package:nfc_sic/controller/DataController.dart';
import 'package:nfc_sic/nfc_sic.dart';
import 'package:sic_onde_demo/API/libAPI.dart';
import 'package:sic_onde_demo/TEST/testdev.dart';


import 'package:sic_onde_demo/charts/line_chart/core/entry.dart';
import 'package:sic_onde_demo/controller/APIController.dart';
import 'package:sic_onde_demo/controller/LoginController.dart';
import 'package:sic_onde_demo/controller/PageDetailController.dart';
import 'package:sic_onde_demo/controller/service/LibService.dart';
import 'package:sic_onde_demo/controller/service/services.dart';
import 'package:sic_onde_demo/model/Product.dart';
import 'package:sic_onde_demo/screens/components/drawerScreen.dart';
import 'package:sic_onde_demo/utils/utils.dart';
import 'package:wakelock/wakelock.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:sic_onde_demo/screens/components/dialog.dart';

part 'Login.dart';
part 'Home.dart';
part 'VegetableScreen.dart';
part 'VegetableSelect.dart';
part 'process.dart';
part 'conversion.dart';
part 'coversionPesticideResult.dart';
part 'conversionCdPb.dart';
part 'processPesticideEnzyme.dart';
part 'conversionPesticide.dart';
part 'coversionEnzyme.dart';
part 'history.dart';
part 'components/productCard.dart';

// extension Uint8ListExtension on Uint8List {
//   String toHexString() => hex.encode(toList()).toUpperCase();
// }
