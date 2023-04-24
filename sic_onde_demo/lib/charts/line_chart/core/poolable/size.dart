part of widgets.chart.line_chart.core.poolable;

class FSize extends Poolable {
  double _width;
  double _height;

  static final ObjectPool<Poolable> pool = ObjectPool.create(256, FSize(0, 0))
    ..setReplenishPercentage(0.5);

  @override
  Poolable instantiate() => FSize(0, 0);

  // ignore: unnecessary_getters_setters
  double get width => _width;

  // ignore: unnecessary_getters_setters
  set width(double value) {
    _width = value;
  }

  // ignore: unnecessary_getters_setters
  double get height => _height;

  // ignore: unnecessary_getters_setters
  set height(double value) {
    _height = value;
  }

  static FSize getInstance(double width, double height) {
    FSize result = pool.get() as FSize;
    result._width = width;
    result._height = height;
    return result;
  }

  static void recycleInstance(FSize instance) {
    pool.recycle(instance);
  }

  FSize(this._width, this._height);

  bool equals(Object obj) {
    if (obj == null) {
      return false;
    }
    if (obj == this) {
      return true;
    }

    if (obj is FSize) {
      var _other = obj;
      return _width == _other._width && _height == _other._height;
    }

    return false;
  }

  @override
  String toString() {
    return '$_width x $_height';
  }
}
