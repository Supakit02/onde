part of widgets.chart.line_chart.painter;

class BackgroundPainter extends ChartPainter {
  final Paint _borderPaint;

  /// Sets the minimum offset (padding) around the chart, defaults to 15.
  final double _minOffset;

  /// the object representing the labels on the left y-axis.
  final YAxis _yAxis;

  final double _extraTopOffset,
    _extraLeftOffset,
    _extraRightOffset,
    _extraBottomOffset;

  /// flag that indicates if offsets calculation has already been done or not?
  bool _offsetsCalculated = false;

  TextPainter? _descPainter;

  Offset? _descOffset;

  final Rect _offsetsBuffer = Rect.zero;

  final XAxisRenderer _xAxisRenderer;
  final YAxisRenderer _yAxisRenderer;
  final Transformer _yAxisTransformer;
  final Description _description;

  YAxis get yAxis => _yAxis;

  double get minOffset => _minOffset;

  double get extraTopOffset => _extraTopOffset;
  double get extraLeftOffset => _extraLeftOffset;
  double get extraRightOffset => _extraRightOffset;
  double get extraBottomOffset => _extraBottomOffset;

  BackgroundPainter(
    ChartData data,
    ViewPortHandler viewPortHandler,
    double extraTopOffset,
    double extraLeftOffset,
    double extraRightOffset,
    double extraBottomOffset,
    Paint borderPaint,
    double minOffset,
    XAxis xAxis,
    YAxis yAxis,
    XAxisRenderer xAxisRenderer,
    YAxisRenderer yAxisRenderer,
    Transformer yAxisTransformer,
    Description description,
  ) : _xAxisRenderer = xAxisRenderer,
      _yAxisRenderer = yAxisRenderer,
      _yAxisTransformer = yAxisTransformer,
      _minOffset = minOffset,
      _yAxis = yAxis,
      _extraTopOffset = extraTopOffset,
      _extraLeftOffset = extraLeftOffset,
      _extraRightOffset = extraRightOffset,
      _extraBottomOffset = extraBottomOffset,
      _borderPaint = borderPaint,
      _description = description,
      super(
          data,
          viewPortHandler,
          xAxis);

  @override
  void initDefaultWithData() {}

  void reassemble() {
    _offsetsCalculated = false;
  }

  @override
  void onPaint(Canvas canvas, Size size) {
    if ( !_offsetsCalculated ) {
      _offsetsCalculated = true;

      viewPortHandler.setChartDimens(
        size.width, size.height);

      _calculateOffsets();
      _compute();
    }

    // execute all drawing commands.
    _drawBorder(canvas);

    _xAxisRenderer.renderGridLines(canvas);
    _yAxisRenderer.renderGridLines(canvas);

    _renderDescription(canvas);

    _xAxisRenderer.renderAxisLabels(canvas);
    _yAxisRenderer.renderAxisLabels(canvas);
  }

  void _compute() {
    _yAxisRenderer.computeAxis(
      yAxis.axisMinimum,
      yAxis.axisMaximum);
    _xAxisRenderer.computeAxis(
      xAxis.axisMinimum,
      xAxis.axisMaximum);
  }

  /// Calculates the offsets of the chart to the border
  /// depending on the position of an eventual legend or
  /// depending on the length of the y-axis and x-axis
  /// labels and their position.
  ///
  void _calculateOffsets() {
    _calcMinMax();

    var offsetTop = 0.0,
      offsetLeft = 0.0,
      offsetRight = 0.0,
      offsetBottom = 0.0;

    offsetTop += (_offsetsBuffer.top );
    offsetLeft += (_offsetsBuffer.left );
    offsetRight += (_offsetsBuffer.right );
    offsetBottom += (_offsetsBuffer.bottom );

    // offsets for y-labels.
    offsetLeft += (yAxis.getRequiredWidthSpace(
      _yAxisRenderer.axisLabelPaint) );

    double xLabelHeight = (xAxis.labelRotatedHeight ) +
      (xAxis.yOffset ) +
      (xAxis.getRequiredHeightSpace(
        _xAxisRenderer.axisLabelPaint) );

    // offsets for x-labels.
    offsetTop += xLabelHeight;

    offsetTop += extraTopOffset;
    offsetLeft += extraLeftOffset;
    offsetRight += extraRightOffset;
    offsetBottom += extraBottomOffset;

    var minOffset = Utils.convertDpToPixel(_minOffset);

    viewPortHandler.restrainViewPort(
      math.max(minOffset, offsetLeft),
      math.max(minOffset, offsetTop),
      math.max(minOffset, offsetRight),
      math.max(minOffset, offsetBottom),
    );

    _prepareOffsetMatrix();
    _prepareValuePxMatrix();
  }

  void _prepareValuePxMatrix() {
    _yAxisTransformer.prepareMatrixValuePx(
      xAxis.axisMinimum, xAxis.axisRange,
      yAxis.axisRange, yAxis.axisMinimum);
  }

  void _prepareOffsetMatrix() {
    _yAxisTransformer.prepareMatrixOffset();
  }

  /// Calculates the y-min and y-max value and the y-delta and x-delta value.
  void _calcMinMax() {
    xAxis.calculate(
      getData().xMin,
      getData().xMax);

    // calculate axis range (min / max) according to provided data.
    yAxis.calculate(
      getData().yMin,
      getData().yMax);
  }

  /// draws the grid background.
  void _drawBorder(Canvas canvas) {
    canvas.drawRect(
      viewPortHandler.contentRect,
      _borderPaint);
  }

  /// Draws the LimitLines associated with this axis to the screen.
  ///
  ///     [@param] canvas
  ///
  void _renderDescription(Canvas canvas) {
    if ( _description == null ) { return; }

    var _pts = <double>[
      0.0,
      _description.pos,
    ];

    _yAxisRenderer.trans.pointValuesToPixel(_pts);

    var _label = _description.text;

    // if drawing the limit-value label is enabled.
    if ( (_label != null) && (_label.isNotEmpty) ) {
      _descPainter ??= PainterUtils.create(
        TextPainter(),
        _label,
        _description.textColor,
        _description.textSize,
        fontWeight: _description.typeface.fontWeight,
        fontFamily: _description.typeface.fontFamily,
      );

      if ( _descOffset == null ) {
        final _labelLineHeight = Utils.calcTextHeight(
          _descPainter!,
          _label).toDouble();

        var _xOffset = Utils.convertDpToPixel(4.0) + _description.xOffset;
        var _yOffset = 2.0 + _labelLineHeight + _description.yOffset;

        _descPainter?.layout();

        _descOffset = Offset(
          viewPortHandler.contentRight() -
          _xOffset -
          _descPainter!.width,
          _pts[1] -
          _yOffset +
          _labelLineHeight -
          _descPainter!.height);
      }

      _descPainter?.paint(
        canvas,
        _descOffset!);
    }
  }
}