part of nfc_sic.chip.sic4341;

class Flag {
  Flag._();

  static const int NULL = 0x00;

  // Response Flag (RF - UART, RF - RegPage)
  static const int B_ACK = 0x1A;
  static const int B_NAK = 0x80;

  // Response NAK
  static const int VDD_RDY_L = 0x01;
  static const int VDD_RDY_H = 0x02;

  static bool isAck(int value) =>
      (value & B_ACK) == B_ACK;

  static bool isNakVddL(int value) {
    const _flag = B_NAK | VDD_RDY_L;

    return (value & _flag) == _flag;
  }

  static bool isNakVddH(int value) {
    const _flag = B_NAK | VDD_RDY_H;

    return (value & _flag) == _flag;
  }

  static String getName(int flag) {
    switch (flag) {
      case B_ACK:
        return "B_ACK";

      default:
        if ( (flag & B_NAK) == B_NAK ) {
          final _flag = StringBuffer(
            "B_NAK");

          if ( (flag & VDD_RDY_L) == VDD_RDY_L ) {
            if ( _flag.isNotEmpty ) {
              _flag.write(
                "/");
            }

            _flag.write(
              "VDD_RDY_L");
          }

          if ( (flag & VDD_RDY_H) == VDD_RDY_H ) {
            if ( _flag.isNotEmpty ) {
              _flag.write(
                "/");
            }

            _flag.write(
              "VDD_RDY_H");
          }

          return _flag.toString();
        }
    }

    return "";
  }
}