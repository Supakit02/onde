part of nfc_sic.utils;

/// Function for convert data value.
class ReactFunc {
  ReactFunc._();

  static bool checkArraySize(List data, int minSize) =>
      (data != null) && !((minSize < 0) || (data.length < minSize));

  static int toMilli(num volt) =>
      (volt * 1000.0).round();

  static int round(num value, int step) =>
      (value / step).round() * step;

  static int getIndexCurrentRange(double currentRange) =>
      (currentRange == SettingArray.CURRENT_RANGE[0])
        ? Config.CHEM_RANGE__2_5uA
        : Config.CHEM_RANGE__20uA;

  static int getIoPin({ bool isUse3Pin }) =>
      isUse3Pin
        ? 1
        : 0;

  static int getCePinFromPinSelect(int cePin, { bool isUse3Pin }) =>
      isUse3Pin
        ? (cePin ?? 2)
        : 3;

  static int getReCeShortFromPinSelect(int pinItem) =>
      (pinItem == 0)
        ? Config.CHEM_RE_CE_SHT__Connect
        : Config.CHEM_RE_CE_SHT__NoConnect;
}