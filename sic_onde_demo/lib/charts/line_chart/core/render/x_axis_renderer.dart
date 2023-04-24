part of widgets.chart.line_chart.core.render;

class XAxisRenderer extends AxisRenderer {
  XAxis? _xAxis;

  XAxisRenderer(ViewPortHandler viewPortHandler, XAxis xAxis, Transformer trans)
      : super(viewPortHandler, trans, xAxis) {
    _xAxis = xAxis;
  }

  XAxis get xAxis => _xAxis!;

  @override
  void computeAxis(double min, double max) {
    computeAxisValues(min, max);
  }

  @override
  void computeAxisValues(double min, double max) {
    super.computeAxisValues(min, max);
    computeSize();
  }

  void computeSize() {
    axisLabelPaint;

    final _labelSize =
        Utils.calcTextSize1(axisLabelPaint, _xAxis!.getLongestLabel());

    final _labelWidth = _labelSize.width;
    final _labelHeight = Utils.calcTextHeight(axisLabelPaint, 'Q').toDouble();

    final _labelRotatedSize =
        Utils.getSizeOfRotatedRectangle(_labelWidth, _labelHeight);

    _xAxis?.labelWidth = _labelWidth.round();
    _xAxis?.labelHeight = _labelHeight.round();
    _xAxis?.labelRotatedWidth = _labelRotatedSize.width.round();
    _xAxis?.labelRotatedHeight = _labelRotatedSize.height.round();

    FSize.recycleInstance(_labelRotatedSize);
    FSize.recycleInstance(_labelSize);
  }

  List<String>? _labels;
  List<double>? _positionLabels;

  @override
  void renderAxisLabels(Canvas canvas) {
    if (_positionLabels == null) {
      _positionLabels =
          List<double>.generate(((_xAxis?.entryCount ?? 0) * 2), (index) => 0);

      for (var i = 0; i < _positionLabels!.length; i += 2) {
        // only fill x values
        _positionLabels![i] = _xAxis!.entries[i ~/ 2];
        _positionLabels![i + 1] = 0.0;
      }
    }

    var _position = List<double>.from(_positionLabels!);

    trans.pointValuesToPixel(_position);

    if (_labels == null) {
      _labels = <String>[];

      for (var i = 0; i < _position.length; i += 2) {
        if (viewPortHandler.isInBoundsX(_position[i])) {
          _labels?.add(_xAxis!
              .getValueFormatter()
              .getAxisLabel(_xAxis!.entries[i ~/ 2]));
        }
      }
    }

    for (var i = 0, j = 0; i < _position.length; i += 2) {
      var _x = _position[i];

      if (viewPortHandler.isInBoundsX(_x)) {
        drawLabel(canvas, _labels![j++], _x, viewPortHandler.contentTop());
      }
    }
  }

  void drawLabel(Canvas canvas, String label, double x, double y) {
    var _originalTextAlign = axisLabelPaint.textAlign;
    axisLabelPaint.textAlign = TextAlign.left;

    axisLabelPaint.text = TextSpan(
      text: label,
      style: axisLabelPaint.text?.style,
    );

    axisLabelPaint.layout();
    axisLabelPaint.paint(
      canvas,
      Offset(
        (x - axisLabelPaint.width / 2),
        (y - axisLabelPaint.height - 5),
      ),
    );

    axisLabelPaint.textAlign = _originalTextAlign;
  }

  List<Path>? _pathBuffer;
  List<double>? _renderGridLinesBuffer;

  @override
  void renderGridLines(Canvas canvas) {
    canvas.save();
    canvas.clipRect(getGridClippingRect());

    if (_renderGridLinesBuffer == null) {
      _renderGridLinesBuffer =
          List<double>.generate(((_xAxis?.entryCount ?? 0) * 2), (index) => 0);

      for (var i = 0; i < _renderGridLinesBuffer!.length; i += 2) {
        _renderGridLinesBuffer![i] = _xAxis!.entries[i ~/ 2];
        _renderGridLinesBuffer![i + 1] = _xAxis!.entries[i ~/ 2];
      }
    }

    var _buffer = List<double>.from(_renderGridLinesBuffer!);

    trans.pointValuesToPixel(_buffer);

    if (_pathBuffer == null) {
      _pathBuffer = <Path>[];

      for (var i = 0; i < _buffer.length; i += 2) {
        var path = Path();
        path.reset();

        path.moveTo(_buffer[i], viewPortHandler.contentBottom());
        path.lineTo(_buffer[i], viewPortHandler.contentTop());

        _pathBuffer?.add(path);
      }
    }

    gridPaint;

    for (var i = 0, j = 0; i < _buffer.length; i += 2) {
      canvas.drawPath(_pathBuffer![j++], gridPaint);
    }

    canvas.restore();
  }

  Rect? _gridClippingRect;

  Rect getGridClippingRect() => _gridClippingRect ??= Rect.fromLTRB(
      viewPortHandler.contentLeft() - 1.0,
      viewPortHandler.contentTop() - 1.0,
      viewPortHandler.contentRight(),
      viewPortHandler.contentBottom());
}
