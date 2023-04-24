part of widgets.chart.line_chart.core.render;

class LineChartRenderer extends Renderer {
  /// buffer for storing the current
  /// minimum and maximum visible x.
  XBounds? _xBounds;

  /// main paint object used for rendering.
  Paint? _renderPaint;

  LineDataProvider? _provider;

  LineChartRenderer(
    LineDataProvider chart,
    ViewPortHandler viewPortHandler
  ) : super(viewPortHandler) {
    _xBounds = XBounds();
    _provider = chart;

    _renderPaint = Paint()
      ..isAntiAlias = true
      ..style = PaintingStyle.stroke;
  }

  LineDataProvider get provider => _provider!;

  /// Draws the actual data in form of lines, bars, ... depending on Renderer subclass.
  ///
  /// [@param] canvas
  ///
  void drawData(Canvas canvas) {
    var _lineData = _provider?.getData();

    for ( var _dataSet in _lineData!.dataSets ) {
      _renderPaint!
        ..strokeWidth = _dataSet.getLineWidth()
        ..color = _dataSet.getColor();

      _drawDataSet(
        canvas,
        _dataSet);
    }
  }

  void _drawDataSet(Canvas canvas, IDataSet dataSet) {
    var _entryCount = dataSet.getEntryCount() ;

    if ( _entryCount < 1 ) { return; }

    _drawLinear(
      canvas,
      _entryCount,
      dataSet);
  }

  List<double> _lineBuffer = [0,0,0,0];

  /// Draws a normal line.
  ///
  ///     [@param] c
  ///     [@param] dataSet
  ///
  void _drawLinear(
      Canvas canvas, int entryCount, IDataSet dataSet) {
    _xBounds?.setBounds(
      _provider!, dataSet);

    // only one color per dataset.
    if ( _lineBuffer.length < (math.max((entryCount) * 2, 2) * 2) ) {
      _lineBuffer = List.generate((
        math.max((entryCount) * 2, 2) * 4), (index) => 0);
    }

    if ( dataSet.getEntryForIndex(_xBounds!.min) != null ) {
      var j = 0;
      var _length = (_xBounds!.range + _xBounds!.min);

      for ( var x = _xBounds!.min ; x <= _length ; x++ ) {
        var _e1 = dataSet.getEntryForIndex(
          (x == 0)
              ? 0
              : (x - 1));
        var _e2 = dataSet.getEntryForIndex(x);

        if ( (_e1 == null) || (_e2 == null) ) { continue; }

        _lineBuffer[j++] = _e1.x;
        _lineBuffer[j++] = _e1.y;

        _lineBuffer[j++] = _e2.x;
        _lineBuffer[j++] = _e2.y;
      }

      if ( j > 0 ) {
        _provider?.getTransformer()
            .pointValuesToPixel(_lineBuffer);

        var _size = math.max(
          (_xBounds!.range + 1) * 2, 2) * 2;

        _drawLines(
          canvas,
          _lineBuffer,
          _size,
          _renderPaint!);
      }
    }
  }

  void _drawLines(
      Canvas canvas, List<double> pts, int count, Paint paint) {
    for ( var i = 0 ; i < count ; i += 4 ) {
      canvas.drawLine(
        Offset(pts[i], pts[i + 1]),
        Offset(pts[i + 2], pts[i + 3]),
        paint);
    }
  }
}