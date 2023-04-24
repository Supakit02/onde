part of nfc_sic.models;

@immutable
class Result {
  /// [Result] set initial value in model
  /// when create new class.
  const Result(
      {this.index = 0,
      this.tSamp = 0,
      this.voltage = 0,
      this.current = 0.0,
      this.adcOut = 0,
      this.filter = 0.0});

  final int index;
  final int tSamp;
  final int voltage;
  final double current;
  final int adcOut;
  final double filter;

  Result copyWith({
    int index,
    int tSamp,
    int voltage,
    double current,
    int adcOut,
    double filter,
  }) =>
      Result(
          index: index ?? this.index,
          tSamp: tSamp ?? this.tSamp,
          voltage: voltage ?? this.voltage,
          current: current ?? this.current,
          adcOut: adcOut ?? this.adcOut,
          filter: filter ?? this.filter);

  @override
  bool operator ==(Object other) =>
      other is Result &&
      other.index == index &&
      other.tSamp == tSamp &&
      other.voltage == voltage &&
      other.current == current &&
      // other.filter == filter &&
      other.adcOut == adcOut;

  @override
  int get hashCode => hashValues(index, tSamp, voltage, current, adcOut);

  @override
  String toString() => "[Result] index: $index, "
      "tSamp: $tSamp, voltage: $voltage, "
      "current: ${current.toStringAsFixed(10)}, "
      "filter : ${filter.toStringAsFixed(10)}, "
      "adcOut: $adcOut";
}
