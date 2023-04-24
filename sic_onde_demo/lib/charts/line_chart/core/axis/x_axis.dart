part of widgets.chart.line_chart.core.axis;

class XAxis extends AxisBase {
  /// width of the x-axis labels in pixels this is
  /// automatically calculated by the computeSize()
  /// methods in the renderers.
  int _labelWidth = 1;

  /// height of the x-axis labels in pixels this is
  /// automatically calculated by the computeSize()
  /// methods in the renderers.
  int _labelHeight = 1;

  /// width of the (rotated) x-axis labels in pixels
  /// this is automatically calculated by the computeSize()
  /// methods in the renderers.
  int _labelRotatedWidth = 1;

  /// height of the (rotated) x-axis labels in pixels
  /// this is automatically calculated by the computeSize()
  /// methods in the renderers.
  int _labelRotatedHeight = 1;

  XAxis() : super() {
    yOffset = Utils.convertDpToPixel(4.0);
  }

  // ignore: unnecessary_getters_setters
  int get labelRotatedHeight => _labelRotatedHeight;

  // ignore: unnecessary_getters_setters
  set labelRotatedHeight(int value) {
    _labelRotatedHeight = value;
  }

  // ignore: unnecessary_getters_setters
  int get labelRotatedWidth => _labelRotatedWidth;

  // ignore: unnecessary_getters_setters
  set labelRotatedWidth(int value) {
    _labelRotatedWidth = value;
  }

  // ignore: unnecessary_getters_setters
  int get labelHeight => _labelHeight;

  // ignore: unnecessary_getters_setters
  set labelHeight(int value) {
    _labelHeight = value;
  }

  // ignore: unnecessary_getters_setters
  int get labelWidth => _labelWidth;

  // ignore: unnecessary_getters_setters
  set labelWidth(int value) {
    _labelWidth = value;
  }

  int getRequiredHeightSpace(TextPainter painter) {
    painter = PainterUtils.create(painter, '', Colors.transparent, textSize);

    return Utils.calcTextHeight(painter, 'A');
  }
}
