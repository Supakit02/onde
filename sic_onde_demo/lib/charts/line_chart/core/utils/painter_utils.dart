part of widgets.chart.line_chart.core.utils;

class PainterUtils {
  static TextPainter create(
    TextPainter painter,
    String text,
    Color color,
    double fontSize, {
    String? fontFamily,
    FontWeight? fontWeight, // add on
  }) {
    if (painter == null) {
      return _create(
        text,
        color,
        fontSize,
        fontFamily: fontFamily,
        fontWeight: fontWeight,
      );
    }

    var _textSpan = painter.text;

    if ((_textSpan != null) && (_textSpan is TextSpan)) {
      var preText = _textSpan.text!;
      var preColor = _textSpan.style?.color ?? Colors.black;
      var preFontSize =
          _textSpan.style?.fontSize ?? Utils.convertDpToPixel(13.0);

      return _create(
        text,
        color,
        fontSize,
        fontFamily: fontFamily ?? _textSpan.style?.fontFamily,
        fontWeight: fontWeight ?? _textSpan.style?.fontWeight,
      );
    } else {
      return _create(
        text,
        color,
        fontSize,
        fontFamily: fontFamily,
        fontWeight: fontWeight,
      );
    }
  }

  static TextPainter _create(
    String text,
    Color color,
    double fontSize, {
    String? fontFamily,
    FontWeight? fontWeight,
  }) {
    return TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
      text: TextSpan(
        text: text,
        style: createTextStyle(
          color,
          fontSize,
          fontFamily: fontFamily,
          fontWeight: fontWeight,
        ),
      ),
    );
  }

  static TextStyle createTextStyle(
    Color color,
    double fontSize, {
    String? fontFamily,
    FontWeight? fontWeight,
  }) {
    return TextStyle(
      color: color,
      fontSize: fontSize,
      fontFamily: fontFamily,
      fontWeight: fontWeight ?? FontWeight.normal,
    );
  }
}
