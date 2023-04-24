part of nfc_sic.managers;

class SettingManager {
  SettingManager._()
      : _setting = Setting(),
        _note = "";

  final Setting _setting;

  String _note;

  Setting get() => _setting;

  String get note => _note;

  void setNote(String value) {
    _note = value ?? "";
  }

  Future<void> setFromModel(
    Setting model, {
    bool save = true,
  }) async {
    if (model == null) {
      return;
    }

    _setting
      ..filterOption = model.filterOption
      ..mode = model.mode
      ..fileName = model.fileName
      // Substance
      ..substance = model.substance
      // Configuration
      // ..isNoTick = model.isNoTick
      ..usePrevOffset = model.usePrevOffset
      ..currentRange = model.currentRange
      // Custom I/O
      ..isUse3Pin = model.isUse3Pin
      ..rePin = model.rePin
      ..wePin = model.wePin
      ..cePin = model.cePin
      // Pretreatment
      ..eCondition = model.eCondition
      ..tCondition = model.tCondition
      ..eDeposition = model.eDeposition
      ..tDeposition = model.tDeposition
      // ..useShortDepos = model.useShortDepos
      // Reaction
      ..tEquilibration = model.tEquilibration
      //! CA

      ..eDc1 = model.eDc1
      ..tRun1 = model.tRun1
      // Voltam
      ..eBegin = model.eBegin
      ..eEnd = model.eEnd
      // DPV / SWV
      ..ePulse = model.ePulse
      ..tPulse = model.tPulse
      // Scan Rate
      ..eStep = model.eStep
      ..tStep = model.tStep
      ..scanRate = model.scanRate;

    if (save) {
      await Preference.setting.save(model);
    }
  }
}
