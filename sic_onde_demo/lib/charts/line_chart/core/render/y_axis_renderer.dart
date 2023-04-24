part of widgets.chart.line_chart.core.render;

class YAxisRenderer extends AxisRenderer {
  YAxis? _yAxis;

  Paint? _zeroLinePaint;

  YAxisRenderer(ViewPortHandler viewPortHandler, YAxis yAxis, Transformer trans)
      : super(viewPortHandler, trans, yAxis) {
    _yAxis = yAxis;
  }

  /// draws the y-axis labels to the screen.
  @override
  void renderAxisLabels(Canvas canvas) {
    axisLabelPaint;

    _drawYLabels(canvas, viewPortHandler.offsetLeft());
  }

  List<Offset>? _labelsOffsetBuffer;
  List<TextPainter>? _labelsPaintBuffer;

  /// draws the y-labels on the specified x-position.
  void _drawYLabels(Canvas canvas, double fixedPosition) {
    var _entryCount = _yAxis?.entryCount ?? 0;

    var _positions = _getTransformedPositions();

    if (_labelsPaintBuffer == null) {
      _labelsOffsetBuffer = <Offset>[];
      _labelsPaintBuffer = <TextPainter>[];

      for (var i = 0; i < _entryCount; i++) {
        axisLabelPaint.text = TextSpan(
          text: _yAxis?.getFormattedLabel(i),
          style: axisLabelPaint.text?.style,
        );

        var labelPaint = PainterUtils.create(axisLabelPaint, '', Color(0xFFFFFF), 0.0);

        labelPaint.layout();

        _labelsPaintBuffer?.add(labelPaint);
        _labelsOffsetBuffer?.add(Offset(fixedPosition - labelPaint.width - 5.0,
            _positions[i * 2 + 1] - labelPaint.height / 2.0));
      }
    }

    // draw
    for (var i = 0; i < _entryCount; i++) {
      _labelsPaintBuffer?[i].paint(canvas, _labelsOffsetBuffer![i]);
    }
  }

  List<Path>? _pathBuffer;

  @override
  void renderGridLines(Canvas canvas) {
    canvas.save();
    canvas.clipRect(_getGridClippingRect());

    var _positions = _getTransformedPositions();

    if (_pathBuffer == null) {
      _pathBuffer = <Path>[];

      for (var i = 0; i < _positions.length; i += 2) {
        var path = Path();
        path.reset();

        path.moveTo(viewPortHandler.offsetLeft(), _positions[i + 1]);
        path.lineTo(viewPortHandler.contentRight(), _positions[i + 1]);

        _pathBuffer?.add(path);
      }
    }

    gridPaint;

    // draw the grid.
    for (var i = 0, j = 0; i < _positions.length; i += 2) {
      // draw a path because lines don't support dashing on lower android versions.
      canvas.drawPath(_pathBuffer![j++], gridPaint);
    }

    canvas.restore();

    _drawZeroLine(canvas);
  }

  Rect? _gridClippingRect;

  Rect _getGridClippingRect() => _gridClippingRect!;

  List<double>? _getTransformedPositionsBuffer;

  /// Transforms the values contained in the axis entries to screen pixels
  /// and returns them in form of a double array
  /// of x- and y-coordinates.
  List<double> _getTransformedPositions() {
    if (_getTransformedPositionsBuffer == null) {
      _getTransformedPositionsBuffer =
          List<double>.generate(((_yAxis?.entryCount ?? 0) * 2), (index) => 0);

      for (var i = 0; i < _getTransformedPositionsBuffer!.length; i += 2) {
        // only fill y values, x values are not needed for y-labels
        _getTransformedPositionsBuffer?[i] = 0.0;
        _getTransformedPositionsBuffer?[i + 1] = _yAxis!.entries[i ~/ 2];
      }
    }

    var _positions = List<double>.from(_getTransformedPositionsBuffer!);

    trans.pointValuesToPixel(_positions);
    return _positions;
  }

  Path? _drawZeroLinePath;
  Rect? _zeroLineClippingRect;

  /// Draws the zero line.
  void _drawZeroLine(Canvas c) {
    c.save();

    _zeroLineClippingRect ??= Rect.fromLTRB(
        viewPortHandler.contentLeft(),
        viewPortHandler.contentTop(),
        viewPortHandler.contentRight() + 1.0,
        viewPortHandler.contentBottom() + 1.0);

    c.clipRect(_zeroLineClippingRect!);

    // draw zero line
    var _pos = trans.getPixelForValues(0.0, 0.0);

    _zeroLinePaint ??= Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.grey
      ..strokeWidth = 1.0;

    if (_drawZeroLinePath == null) {
      _drawZeroLinePath = Path();
      _drawZeroLinePath?.reset();

      _drawZeroLinePath?.moveTo(viewPortHandler.contentLeft(), _pos.y);
      _drawZeroLinePath?.lineTo(viewPortHandler.contentRight(), _pos.y);
    }

    // draw a path because lines don't support
    // dashing on lower android versions.
    c.drawPath(_drawZeroLinePath!, _zeroLinePaint!);

    c.restore();
  }
}
