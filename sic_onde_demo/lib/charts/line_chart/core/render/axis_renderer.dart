part of widgets.chart.line_chart.core.render;

abstract class AxisRenderer extends Renderer {
  /// base axis this axis renderer.
  AxisBase? _axis;

  /// transformer to transform values to screen pixels.
  Transformer? _trans;

  /// paint object for the grid lines.
  Paint? _gridPaint;

  /// paint for the x-label values.
  TextPainter? _axisLabelPaint;

  AxisRenderer(
    ViewPortHandler viewPortHandler, Transformer trans, AxisBase axis)
      : super(viewPortHandler) {
    _trans = trans;
    _axis = axis;
  }

  // ignore: unnecessary_getters_setters
  AxisBase get axis => _axis!;

  // ignore: unnecessary_getters_setters
  set axis(AxisBase value) {
    _axis = value;
  }

  // ignore: unnecessary_getters_setters
  Transformer get trans => _trans!;

  // ignore: unnecessary_getters_setters
  set trans(Transformer value) {
    _trans = value;
  }

  // ignore: unnecessary_getters_setters
  TextPainter get axisLabelPaint => _axisLabelPaint!;

  // ignore: unnecessary_getters_setters
  set axisLabelPaint(TextPainter value) {
    _axisLabelPaint = value;
  }

  // ignore: unnecessary_getters_setters
  Paint get gridPaint => _gridPaint!;

  // ignore: unnecessary_getters_setters
  set gridPaint(Paint value) {
    _gridPaint = value;
  }

  /// Computes the axis values.
  ///
  ///     [@param] min - the minimum value in the data object for this axis.
  ///     [@param] max - the maximum value in the data object for this axis.
  ///
  void computeAxis(double min, double max) {
    computeAxisValues(min, max);
  }

  /// Sets up the axis values. Computes the desired number of labels
  /// between the two given extremes.
  ///
  void computeAxisValues(double min, double max) {
    min ;
    max ;

    var yMin = min;
    var yMax = max;

    var labelCount = _axis?.labelCount;
    var range = (yMax - yMin).abs();

    if ( (labelCount == 0) ||
        (range <= 0) ||
        (range.isInfinite) ) {
      _axis?.entries = <double>[];
      _axis?.entryCount = 0;
      return;
    }

    // Find out how much spacing (in y value space) between axis values.
    var rawInterval = range / labelCount!;
    var interval = Utils.roundToNextSignificant(rawInterval);

    // Normalize interval
    var intervalMagnitude = Utils.roundToNextSignificant(
      math.pow(10.0, math.log(interval) ~/ math.ln10).toDouble());
    var intervalSigDigit = interval ~/ intervalMagnitude;

    if ( intervalSigDigit > 5 ) {
      // Use one order of magnitude higher,
      // to avoid intervals like 0.9 or 90.
      interval = (10 * intervalMagnitude).floorToDouble();
    }

    var num = 0;

    // force label count.
    if ( _axis!.forceLabels ) {
      interval = range / (labelCount - 1);
      _axis?.entryCount = labelCount;

      if ( _axis!.entries.length < labelCount ) {
        // Ensure stops contains at least numStops elements.
        _axis?.entries = List.generate(labelCount, (index) => 0);
      }

      var v = min;

      for ( var i = 0 ; i < labelCount ; i++ ) {
        _axis?.entries[i] = v;
        v += interval;
      }

      num = labelCount;

      // no forced count
    } else {
      var first = (interval == 0.0)
          ? 0.0
          : (yMin / interval).ceil() * interval;

      var last = (interval == 0.0)
          ? 0.0
          : Utils.nextUp((yMax / interval).floor() * interval);

      double f;
      int i;

      if ( interval != 0.0 ) {
        for ( f = first ; f <= last ; f += interval ) {
          ++num;
        }
      }

      _axis?.entryCount = num;

      if ( _axis!.entries.length < num ) {
        // Ensure stops contains at least numStops elements.
        _axis?.entries = List.generate(num, (index) => 0);
      }

      i = 0;
      for ( f = first ; i < num ; f += interval, ++i ) {
        // Fix for negative zero case (Where value == -0.0, and 0.0 == -0.0)
        if ( f == 0.0 ) {
          f = 0.0;
        }

        _axis?.entries[i] = f;
      }
    }

    // set decimals
    if ( interval < 1 ) {
      _axis?.decimals = (-math.log(interval) / math.ln10).ceil();
    } else {
      _axis?.decimals = 0;
    }
  }

  /// Draws the axis labels to the screen.
  ///
  ///     [@param] canvas
  ///
  void renderAxisLabels(Canvas canvas);

  /// Draws the grid lines belonging to the axis.
  ///
  ///     [@param] canvas
  ///
  void renderGridLines(Canvas canvas);
}