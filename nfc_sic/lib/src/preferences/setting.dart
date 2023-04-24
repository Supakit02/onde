part of nfc_sic.preferences;

class SharedPreferenceSetting {
  SharedPreferenceSetting._() {
    _init();
  }

  static const String _PREF__SETTING = "iquan_setting";

  static const String _PREF__SETTING_SUBSTANCE = "${_PREF__SETTING}_substance";
  static const String _PREF__SETTING_FILE_NAME = "${_PREF__SETTING}_file_name";

  // static const String _PREF__SETTING_IS_NOTICK = "${_PREF__SETTING}_is_notick";
  static const String _PREF__SETTING_USE_PREV_OFFSET =
      "${_PREF__SETTING}_use_prev_offset";
  static const String _PREF__SETTING_CURRENT_RANGE =
      "${_PREF__SETTING}_current_range";

  static const String _PREF__SETTING_T_EQUILIBRATION =
      "${_PREF__SETTING}_t_equilibration";

  static const String _PREF__SETTING_IS_USE_3_PIN =
      "${_PREF__SETTING}_is_use_3_pin";
  static const String _PREF__SETTING_RE_PIN = "${_PREF__SETTING}_re_pin";
  static const String _PREF__SETTING_WE_PIN = "${_PREF__SETTING}_we_pin";
  static const String _PREF__SETTING_CE_PIN = "${_PREF__SETTING}_ce_pin";

  static const String _PREF__SETTING_E_CONDITION =
      "${_PREF__SETTING}_e_condition";
  static const String _PREF__SETTING_T_CONDITION =
      "${_PREF__SETTING}_t_condition";
  static const String _PREF__SETTING_E_DEPOSITION =
      "${_PREF__SETTING}_e_deposition";
  static const String _PREF__SETTING_T_DEPOSITION =
      "${_PREF__SETTING}_t_deposition";
  // static const String _PREF__SETTING_USE_SHORTED_DEPOSITION = "${_PREF__SETTING}_use_shorted_deposition";

  static const String _PREF__SETTING_E_BEGIN = "${_PREF__SETTING}_e_begin";
  static const String _PREF__SETTING_E_END = "${_PREF__SETTING}_e_end";

  static const String _PREF__SETTING_E_PULSE = "${_PREF__SETTING}_e_pulse";
  static const String _PREF__SETTING_T_PULSE = "${_PREF__SETTING}_t_pulse";

  static const String _PREF__SETTING_E_STEP = "${_PREF__SETTING}_e_step";
  static const String _PREF__SETTING_T_STEP = "${_PREF__SETTING}_t_step";
  static const String _PREF__SETTING_SCAN_RATE = "${_PREF__SETTING}_scan_rate";

  //! add [ONDE]
  static const String _PREF__SETTING_FIRST_CURRENT =
      "${_PREF__SETTING}_first_current";

  static const String _PREF__SETTING_PREV_CURRENT =
      "${_PREF__SETTING}_prev_current";

  //! add i100 and i280 i400 for API
  static const String _PREF__SETTING_I_100 = "${_PREF__SETTING}_I_100";
  static const String _PREF__SETTING_I_280 = "${_PREF__SETTING}_I_280";
  static const String _PREF__SETTING_I_400 = "${_PREF__SETTING}_I_400";

  SharedPreferences _sf;

  Future<void> _init() async {
    _sf ??= await SharedPreferences.getInstance();
  }

  Future<void> save(Setting _setting) async {
    if (_setting == null) {
      return;
    }

    if (_sf == null) {
      await _init();
    }

    await _sf.setString(_PREF__SETTING_FILE_NAME, _setting.fileName);

    // Substance
    await _sf.setInt(
        _PREF__SETTING_SUBSTANCE, Substance.values.indexOf(_setting.substance));

    // Configuration
    // await _sf.setBool(
    //   _PREF__SETTING_IS_NOTICK,
    //   _setting.isNoTick);
    await _sf.setBool(_PREF__SETTING_USE_PREV_OFFSET, _setting.usePrevOffset);
    await _sf.setDouble(_PREF__SETTING_CURRENT_RANGE, _setting.currentRange);

    // Custom I/O
    await _sf.setBool(_PREF__SETTING_IS_USE_3_PIN, _setting.isUse3Pin);
    await _sf.setInt(_PREF__SETTING_RE_PIN, _setting.rePin);
    await _sf.setInt(_PREF__SETTING_WE_PIN, _setting.wePin);
    await _sf.setInt(_PREF__SETTING_CE_PIN, _setting.cePin);

    // Pretreatment
    await _sf.setDouble(_PREF__SETTING_E_CONDITION, _setting.eCondition);
    await _sf.setInt(_PREF__SETTING_T_CONDITION, _setting.tCondition);
    await _sf.setDouble(_PREF__SETTING_E_DEPOSITION, _setting.eDeposition);
    await _sf.setInt(_PREF__SETTING_T_DEPOSITION, _setting.tDeposition);
    // await _sf.setBool(
    //   _PREF__SETTING_USE_SHORTED_DEPOSITION,
    //   _setting.useShortDepos);

    // Reaction
    await _sf.setInt(_PREF__SETTING_T_EQUILIBRATION, _setting.tEquilibration);

    // Voltam
    await _sf.setDouble(_PREF__SETTING_E_BEGIN, _setting.eBegin);
    await _sf.setDouble(_PREF__SETTING_E_END, _setting.eEnd);

    // DPV / SWV
    await _sf.setInt(_PREF__SETTING_E_PULSE, _setting.ePulse);
    await _sf.setInt(_PREF__SETTING_T_PULSE, _setting.tPulse);

    // Scan Rate
    await _sf.setInt(_PREF__SETTING_E_STEP, _setting.eStep);
    await _sf.setInt(_PREF__SETTING_T_STEP, _setting.tStep);
    await _sf.setDouble(_PREF__SETTING_SCAN_RATE, _setting.scanRate);
  }

  Future<Setting> restore() async {
    var _index = 0;
    Substance _substance;

    if (_sf == null) {
      await _init();
    }

    // Substance
    _index = _sf.getInt(_PREF__SETTING_SUBSTANCE);

    if (_index != null) {
      _substance = Substance.values[_index];
    }

    return Setting(
      fileName: _sf.getString(_PREF__SETTING_FILE_NAME),
      // Substance
      substance: _substance,
      // Configuration
      // isNoTick: _sf.getBool(
      //   _PREF__SETTING_IS_NOTICK),
      usePrevOffset: _sf.getBool(_PREF__SETTING_USE_PREV_OFFSET),
      currentRange: _sf.getDouble(_PREF__SETTING_CURRENT_RANGE),
      // Custom I/O
      isUse3Pin: _sf.getBool(_PREF__SETTING_IS_USE_3_PIN),
      rePin: _sf.getInt(_PREF__SETTING_RE_PIN),
      wePin: _sf.getInt(_PREF__SETTING_WE_PIN),
      cePin: _sf.getInt(_PREF__SETTING_CE_PIN),
      // Pretreatment
      eCondition: _sf.getDouble(_PREF__SETTING_E_CONDITION),
      tCondition: _sf.getInt(_PREF__SETTING_T_CONDITION),
      eDeposition: _sf.getDouble(_PREF__SETTING_E_DEPOSITION),
      tDeposition: _sf.getInt(_PREF__SETTING_T_DEPOSITION),
      // useShortDepos: _sf.getBool(
      //   _PREF__SETTING_USE_SHORTED_DEPOSITION),
      // Reaction
      tEquilibration: _sf.getInt(_PREF__SETTING_T_EQUILIBRATION),
      // Voltam
      eBegin: _sf.getDouble(_PREF__SETTING_E_BEGIN),
      eEnd: _sf.getDouble(_PREF__SETTING_E_END),
      // DPV / SWV
      ePulse: _sf.getInt(_PREF__SETTING_E_PULSE),
      tPulse: _sf.getInt(_PREF__SETTING_T_PULSE),
      // Scan Rate
      eStep: _sf.getInt(_PREF__SETTING_E_STEP),
      tStep: _sf.getInt(_PREF__SETTING_T_STEP),
      scanRate: _sf.getDouble(_PREF__SETTING_SCAN_RATE),
    );
  }

  Future<void> setPrevCurrent(double value) async {
    await _sf?.setDouble(_PREF__SETTING_PREV_CURRENT, value);
  }

  double getPrevCurrent() => _sf?.getDouble(_PREF__SETTING_PREV_CURRENT);

  Future<void> setFirstCurrent(double value) async {
    await _sf?.setDouble(_PREF__SETTING_FIRST_CURRENT, value);
  }

  double getFirstCurrent() => _sf?.getDouble(_PREF__SETTING_FIRST_CURRENT);

  Future<void> setI100(double value) async {
    await _sf?.setDouble(_PREF__SETTING_I_100, value);
  }

  double getSetI100() => _sf?.getDouble(_PREF__SETTING_I_100);

  Future<void> setI280(double value) async {
    await _sf?.setDouble(_PREF__SETTING_I_280, value);
  }

  double getSetI280() => _sf?.getDouble(_PREF__SETTING_I_280);

  Future<void> setI400(double value) async {
    await _sf?.setDouble(_PREF__SETTING_I_400, value);
  }

  double getSetI400() => _sf?.getDouble(_PREF__SETTING_I_400);
}
