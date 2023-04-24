part of widgets.chart.line_chart.core.utils;

class Matrix4Utils {
  static void postScale(
      Matrix4 m, double sx, double sy) {
    m
      ..storage[13] *= sy
      ..storage[5] *= sy
      ..storage[12] *= sx
      ..storage[0] *= sx;
  }

  static void postTranslate(
      Matrix4 m, double tx, double ty) {
    m.storage[12] += tx;
    m.storage[13] += ty;
  }

  static void mapPoints(
      Matrix4 m, List<double> valuePoints) {
    var x = 0.0;
    var y = 0.0;

    for ( var i = 0 ; i < valuePoints.length ; i += 2 ) {
      x = (valuePoints[i] == null)
          ? 0.0
          : valuePoints[i];
      y = (valuePoints[i + 1] == null)
          ? 0.0
          : valuePoints[i + 1];

      final transformed = m.perspectiveTransform(
        Vector3(x, y, 0));

      valuePoints[i] = transformed.x;
      valuePoints[i + 1] = transformed.y;
    }
  }
}