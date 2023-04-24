library nfc_sic;

import 'src/managers/managers.dart'
  show Manager;
import 'src/preferences/preferences.dart'
  show Preference;

export 'src/managers/managers.dart';
export 'src/models/models.dart';
export 'src/nfc.dart'
  hide channel;
export 'src/peak/peak.dart';
export 'src/process/process.dart';
export 'src/tasks/tasks.dart';
export 'src/utils/utils.dart'
  hide
    NoCaseError,
    TaskException,
    OthersException;

/// Initialization all module in plugin.
/// [Manager] and [Preference]
Future<void> initPlugin() async {
  final _setting = await Preference.setting.restore();

  /// [SharedPreferences] initial all shared preferences.
  /// [SharedPreferenceSettings] restore settings.
  await Manager.setting.setFromModel(
    _setting,
    save: false);

  await Manager.calibration.loadOffsetData();
}