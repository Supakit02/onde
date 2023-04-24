part of widgets.chart.line_chart.core.utils;

double _designW = 360.0;

/// Screen Util.
class ScreenUtils {
  double _screenWidth = 0.0;
  double _screenDensity = 0.0;
  MediaQueryData? _mediaQueryData;

  static final ScreenUtils _singleton = ScreenUtils();

  static ScreenUtils getInstance() {
    _singleton.init();
    return _singleton;
  }

  void init() {
    var mediaQuery = MediaQueryData.fromWindow(window);

    if ( _mediaQueryData != mediaQuery ) {
      _mediaQueryData = mediaQuery;
      _screenWidth = mediaQuery.size.width;
      _screenDensity = mediaQuery.devicePixelRatio;
    }
  }

  /// returns the font size after adaptation
  /// according to the screen density.
  double getSp(double fontSize) {
    if ( _screenDensity == 0.0 ) { return fontSize; }
    return fontSize * _screenWidth / _designW;
  }
}