library widgets.chart.line_chart.core.transformer;

import 'package:flutter/rendering.dart' show Matrix4;

import 'poolable/poolable.dart' show MPPointD;
import 'utils/utils.dart' show Matrix4Utils;
import 'view_port.dart';

class Transformer {
  /// matrix to map the values to the screen pixels.
  Matrix4 _matrixValueToPx = Matrix4.identity();

  /// matrix for handling the different offsets of the chart.
  Matrix4 _matrixOffset = Matrix4.identity();

  ViewPortHandler? _viewPortHandler;

  Transformer(ViewPortHandler viewPortHandler) {
    _viewPortHandler = viewPortHandler;
  }

  ViewPortHandler get viewPortHandler => _viewPortHandler!;

  /// Prepares the matrix that Matrix4Utils.transforms values to pixels.
  /// Calculates the scale factors from the charts size and offsets.
  ///
  ///     [@param] xChartMin
  ///     [@param] deltaX
  ///     [@param] deltaY
  ///     [@param] yChartMin
  ///
  void prepareMatrixValuePx(
      double xChartMin, double deltaX, double deltaY, double yChartMin) {
    var _scaleX = ((_viewPortHandler!.contentWidth()) / deltaX);
    var _scaleY = ((_viewPortHandler!.contentHeight()) / deltaY);

    if (_scaleX.isInfinite) {
      _scaleX = 0;
    }
    if (_scaleY.isInfinite) {
      _scaleY = 0;
    }

    // setup all matrices
    _matrixValueToPx = Matrix4.identity();

    Matrix4Utils.postTranslate(_matrixValueToPx, -xChartMin, -yChartMin);
    Matrix4Utils.postScale(_matrixValueToPx, _scaleX, -_scaleY);
  }

  /// Prepares the matrix that contains all offsets.
  ///
  void prepareMatrixOffset() {
    _matrixOffset = Matrix4.identity();

    Matrix4Utils.postTranslate(_matrixOffset, _viewPortHandler!.offsetLeft(),
        _viewPortHandler!.chartHeight - _viewPortHandler!.offsetBottom());
  }

  /// Transform an array of points with all matrices.
  /// VERY IMPORTANT: Keep matrix order "value-touch-offset"
  /// when Matrix4Utils.transforming.
  ///
  ///     [@param] pts
  ///
  void pointValuesToPixel(List<double> pts) {
    Matrix4Utils.mapPoints(_matrixValueToPx, pts);
    Matrix4Utils.mapPoints(Matrix4.identity(), pts);
    Matrix4Utils.mapPoints(_matrixOffset, pts);
  }

  /// Transforms the given array of touch positions (pixels)
  /// (x, y, x, y, ...) into values on the chart.
  ///
  ///     [@param] pixels
  ///
  void pixelsToValue(List<double> pixels) {
    var _tmp = Matrix4.identity();

    // copyInverse all matrixes to convert back to the original value
    _tmp.copyInverse(_matrixOffset);
    Matrix4Utils.mapPoints(_tmp, pixels);

    _tmp.copyInverse(Matrix4.identity());
    Matrix4Utils.mapPoints(_tmp, pixels);

    _tmp.copyInverse(_matrixValueToPx);
    Matrix4Utils.mapPoints(_tmp, pixels);
  }

  /// buffer for performance
  final List<double> _ptsBuffer = [0, 0];

  void getValuesByTouchPoint2(double x, double y, MPPointD outputPoint) {
    _ptsBuffer[0] = x;
    _ptsBuffer[1] = y;

    pixelsToValue(_ptsBuffer);

    outputPoint.x = _ptsBuffer[0];
    outputPoint.y = _ptsBuffer[1];
  }

  /// Returns a recyclable MPPointD instance.
  /// Returns the x and y coordinates (pixels)
  /// for a given x and y value in the chart.
  ///
  ///     [@param] x
  ///     [@param] y
  ///
  ///     [return] MPPointD
  ///
  MPPointD getPixelForValues(double x, double y) {
    _ptsBuffer[0] = x;
    _ptsBuffer[1] = y;

    pointValuesToPixel(_ptsBuffer);

    var _xPx = _ptsBuffer[0];
    var _yPx = _ptsBuffer[1];

    return MPPointD.getInstance(_xPx, _yPx);
  }
}
