part of nfc_sic.utils;

/// List value selection for setting data.
///  * I/O pin `[PIN]`
///  * Current range `[CURRENT_RANGE]`
///  * Pulse Duration `[T_PULSE]`
///  * Step size `[E_STEP]`
///  * Step time `[T_STEP]`
class SettingArray {
  /// I/O pin (RE, WE, CE)
  ///  * [0] pin 0
  ///  * [1] pin 1
  ///  * [2] pin 2
  static const List<int> PIN = <int>[
    0,
    1,
    2,
  ];

  /// Current range (uA)
  ///  * [0] 2.5 uA
  ///  * [1] 20.0 uA
  static const List<double> CURRENT_RANGE = <double>[
    2.5,
    20,
  ];

  /// Pulse Duration (ms)
  ///  * [0] 100 ms
  ///  * [1] 200 ms
  ///  * [2] 500 ms
  ///  * [3] 1000 ms
  static const List<int> T_PULSE = <int>[
    100,
    200,
    500,
    1000,
  ];

  /// E pulse (mV)
  ///  * [0] 10 mV
  ///  * [1] 20 mV
  ///  * [2] 30 mV
  ///  * [3] 40 mV
  ///  * [4] 50 mV
  ///  * [5] 60 mV
  ///  * [6] 70 mV
  ///  * [7] 80 mV
  ///  * [8] 90 mV
  ///  * [9] 100 mV
  static const List<int> E_PULSE = <int>[
    10,
    20,
    30,
    40,
    50,
    60,
    70,
    80,
    90,
    100,
  ];

  /// E step (mV)
  ///  * [0] 10 mV
  ///  * [1] 20 mV
  ///  * [2] 30 mV
  ///  * [3] 40 mV
  ///  * [4] 50 mV
  static const List<int> E_STEP = <int>[
    10,
    20,
    30,
    40,
    50,
  ];

  /// t step (ms)
  ///  * [1] 200 ms
  ///  * [2] 500 ms
  ///  * [3] 1000 ms
  static const List<int> T_STEP = <int>[
    200,
    500,
    1000,
  ];
}