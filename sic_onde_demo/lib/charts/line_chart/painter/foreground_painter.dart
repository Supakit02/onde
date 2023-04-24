part of widgets.chart.line_chart.painter;

class ForegroundPainter extends ChartPainter implements LineDataProvider {
  /// object responsible for rendering the data.
  LineChartRenderer? _renderer;

  final Transformer _yAxisTransformer;

  ForegroundPainter(
    ChartData data,
    ViewPortHandler viewPortHandler,
    XAxis xAxis,
    Transformer yAxisTransformer
  ) : _yAxisTransformer = yAxisTransformer,
      super(
        data,
        viewPortHandler,
        xAxis);

  @override
  void initDefaultWithData() {
    _renderer = LineChartRenderer(this, viewPortHandler);
  }

  @override
  void onPaint(Canvas canvas, Size size) {
    // make sure the data cannot be drawn outside the content-rect
    canvas.save();
    canvas.clipRect(
      viewPortHandler.contentRect);

    _renderer?.drawData(canvas);

    // Removes clipping rectangle
    canvas.restore();
  }

  /// Returns the Transformer class that contains all matrices and is
  /// responsible for transforming values into pixels on the screen and
  /// backwards.
  ///
  ///     [return] leftAxisTransformer
  ///
  @override
  Transformer getTransformer() => _yAxisTransformer;

  /// buffer for storing lowest visible x point.
  final MPPointD _posForGetLowestVisibleX = MPPointD.getInstance(0, 0);

  /// Returns the lowest x-index (value on the x-axis)
  /// that is still visible on the chart.
  ///
  ///     [return] x value
  ///
  @override
  double getLowestVisibleX() {
    getTransformer().getValuesByTouchPoint2(
      viewPortHandler.contentLeft(),
      viewPortHandler.contentBottom(),
      _posForGetLowestVisibleX);

    return math.max(
      xAxis.axisMinimum,
      _posForGetLowestVisibleX.x);
  }

  /// buffer for storing highest visible x point
  final MPPointD _posForGetHighestVisibleX = MPPointD.getInstance(0, 0);

  /// Returns the highest x-index (value on the x-axis)
  /// that is still visible on the chart.
  ///
  ///     [return] x value
  ///
  @override
  double getHighestVisibleX() {
    getTransformer().getValuesByTouchPoint2(
      viewPortHandler.contentRight(),
      viewPortHandler.contentBottom(),
      _posForGetHighestVisibleX);

    return math.min(
      xAxis.axisMaximum,
      _posForGetHighestVisibleX.x);
  }

  @override
  ChartData getData() => super.getData();
}