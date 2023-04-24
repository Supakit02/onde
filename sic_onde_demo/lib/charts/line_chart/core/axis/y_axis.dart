part of widgets.chart.line_chart.core.axis;

class YAxis extends AxisBase {
  YAxis() : super() {
    yOffset = 0;
  }

  @override
  void calculate(double dataMin, double dataMax) {
    var min = (dataMin);
    var max = (dataMax);

    var range = (max - min).abs();

    // in case all values are equal
    if (range == 0) {
      max = max + 1;
      min = min - 1;
    }

    // recalculate
    range = (max - min).abs();

    // calc extra spacing
    axisMinimum = customAxisMin ? axisMinimum : min - (range / 100.0) * 10.0;

    axisMaximum = customAxisMax ? axisMaximum : max + (range / 100.0) * 10.0;

    axisRange = (axisMinimum - axisMaximum).abs();
  }

  /// This is for normal (not horizontal) charts horizontal spacing.
  ///
  ///     [@param] painter
  ///
  ///     [return] width space
  ///
  double getRequiredWidthSpace(TextPainter painter) {
    painter = PainterUtils.create(painter, '', Colors.transparent, textSize);

    var label = getLongestLabel();
    var width = Utils.calcTextWidth(painter, label) + xOffset * 2.0;

    width = math.max(0.0, width);
    return width;
  }

  /// This is for HorizontalBarChart vertical spacing.
  ///
  ///     [@param] painter
  ///
  ///     [return] height space
  ///
  double getRequiredHeightSpace(TextPainter painter) {
    painter = PainterUtils.create(painter, '', Colors.transparent, textSize);

    return Utils.calcTextHeight(painter, getLongestLabel()) + yOffset * 2;
  }
}
