part of service.provider;

class ConversionProvider extends GetxController {
  bool _load = false;
  bool _complete = false;

  String _status = '';

  ChartController? _chartController;

  ConversionProvider() {
    reset();
  }

  void reset() {
    _status = '';

    _load = false;
    _complete = false;
  }

  bool get load => _load;
  bool get complete => _complete;

  String get status => _status;

  void addNewLine() {
    final _lineData = _chartController?.data;
    final _count = _lineData?.getDataSetCount() ?? 0;

    _lineData?.addDataSet(LineDataSet(<Entry>[])
      ..setLineWidth(1.5)
      ..setColor(
          Colors.primaries.elementAt((_count + 1) % Colors.primaries.length)));

    _lineData?.notifyDataChanged();
    _chartController?.state.setStateIfNotDispose();
  }

  set load(bool value) {
    _load = value;
    update();
  }

  set status(String value) {
    _status = value;
    update();
  }

  void setResult(Entry value) {
    _setLineChartNewEntry(value);
  }

  void setLoopBack(int value) {
    assert(value != null);
    _setLineChartNewLineRightToLeft(value);
  }

  void _setLineChartNewLineRightToLeft(int val) {
    // debugPrint("[setLineChartNewLineRightToLeft] loopBack: $val");
    if (val <= -1) {
      _chartController?.data.clearValues();
      _chartController?.state.setStateIfNotDispose();
      // debugPrint("[setLineChartNewLineRightToLeft] RightToLeft =========================");
      return;
    }

    _chartController?.data;

    var _lineData = _chartController?.data;

    _lineData?.addDataSet(_getLineDataSet(Colors.primaries.elementAt(
        ((_lineData.getDataSetCount()) + 1) % Colors.primaries.length)));

    _lineData?.notifyDataChanged();
    _chartController?.state.setStateIfNotDispose();
  }

  void _setLineChartNewEntry(Entry entry) {
    if (entry == null) {
      _chartController?.data.clearValues();
      _chartController?.state.setStateIfNotDispose();
      // debugPrint("[setLineChartNewEntry] NewEntry =========================");
      return;
    }

    if (_chartController?.data == null) {
      _chartController?.data = ChartData();

      if (_chartController?.data.getDataSetCount() == 0) {
        return;
      }
    }

    var _lineData = _chartController?.data;

    // debugPrint("[setLineChartNewEntry] Entry ==================== X: ${entry.x}, Y: ${entry.y}");
    var _dataSet =
        _lineData?.getDataSetByIndex((_lineData.getDataSetCount()) - 1);

    _dataSet?.addEntryOrdered(entry);
    _lineData?.notifyDataChanged();
    _chartController?.state.setStateIfNotDispose();
  }

  LineDataSet _getLineDataSet(Color color) {
    var dataSet = LineDataSet(<Entry>[]);
    dataSet.setLineWidth(1.5);
    dataSet.setColor(color);
    return dataSet;
  }

  void setStatusError({required String status}) {
    _status = status;
    update();
  }

  void setValues({
    String status = '',
    bool load = false,
    bool complete = false,
    bool notify = true,
  }) {
    _status = status;
    _load = load;
    _complete = complete;

    update();
  }
}
