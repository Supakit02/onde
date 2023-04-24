library nfc_sic.preferences;

import 'package:shared_preferences/shared_preferences.dart'
  show SharedPreferences;

import '../models/models.dart'
  show Setting;
import '../peak/peak.dart'
  show Substance;

part 'setting.dart';

class Preference {
  Preference._();

  static SharedPreferenceSetting _setting;

  /// Singleton instance of SharedPreferenceSettings.
  static SharedPreferenceSetting get setting =>
      _setting ??= SharedPreferenceSetting._();
}