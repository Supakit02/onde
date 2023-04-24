part of widgets.chart.line_chart.core.poolable;

class MPPointF extends Poolable {
  static ObjectPool<Poolable> pool = ObjectPool.create(32, MPPointF(0, 0))
    ..setReplenishPercentage(0.5);

  double _x;
  double _y;

  MPPointF(this._x, this._y);

  // ignore: unnecessary_getters_setters
  double get y => _y;

  // ignore: unnecessary_getters_setters
  set y(double value) {
    _y = value;
  }

  // ignore: unnecessary_getters_setters
  double get x => _x;

  // ignore: unnecessary_getters_setters
  set x(double value) {
    _x = value;
  }

  static MPPointF getInstance(double x, double y) {
    MPPointF result = pool.get() as MPPointF;

    result.x = x;
    result.y = y;

    return result;
  }

  static void recycleInstance(MPPointF instance) {
    pool.recycle(instance);
  }

  @override
  Poolable instantiate() => MPPointF(0.0, 0.0);

  @override
  String toString() {
    return '[$runtimeType] x: $_x, y: $_y';
  }
}

class MPPointD extends Poolable {
  static final ObjectPool<Poolable> pool = ObjectPool.create(64, MPPointD(0, 0))
    ..setReplenishPercentage(0.5);

  double _x;
  double _y;

  MPPointD(this._x, this._y);

  // ignore: unnecessary_getters_setters
  double get y => _y;

  // ignore: unnecessary_getters_setters
  set y(double value) {
    _y = value;
  }

  // ignore: unnecessary_getters_setters
  double get x => _x;

  // ignore: unnecessary_getters_setters
  set x(double value) {
    _x = value;
  }

  static MPPointD getInstance(double x, double y) {
    MPPointD result = pool.get() as MPPointD;

    result.x = x;
    result.y = y;

    return result;
  }

  static void recycleInstance(MPPointD instance) {
    pool.recycle(instance);
  }

  @override
  Poolable instantiate() => MPPointD(0.0, 0.0);

  /// returns a string representation of the object.
  @override
  String toString() {
    return '[$runtimeType] x: $x, y: $y';
  }
}

class ObjectPool<T extends Poolable> {
  static int ids = 0;

  int poolId = 0;
  int desiredCapacity;
  List<dynamic> objects = [];
  int objectsPointer = 0;
  T modelObject;
  double replenishPercentage = 1.0;

  /// Returns an ObjectPool instance, of a given starting capacity,
  /// that recycles instances of a given Poolable object.
  ///
  ///     [@param] withCapacity A positive integer value.
  ///     [@param] object An instance of the object that the pool should recycle.
  ///
  ///     [return] ObjectPool
  ///
  static ObjectPool create(int withCapacity, Poolable object) {
    var result = ObjectPool(withCapacity, object);

    result.poolId = ids;
    ids++;

    return result;
  }

  ObjectPool(this.desiredCapacity, this.modelObject) {
    if (desiredCapacity <= 0) {
      throw Exception(
          'Object Pool must be instantiated with a capacity greater than 0!');
    }

    objects = [desiredCapacity];
    objectsPointer = 0;
    replenishPercentage = 1.0;
    refillPool1();
  }

  /// Set the percentage of the pool to replenish on empty.
  /// Valid values are between 0.0 and 1.0
  ///
  ///     [@param] percentage a value between 0 and 1,
  ///              representing the percentage of the pool to replenish.
  ///
  void setReplenishPercentage(double percentage) {
    var p = percentage;

    if (p > 1) {
      p = 1;
    } else if (p < 0) {
      p = 0;
    }

    replenishPercentage = p;
  }

  void refillPool1() {
    refillPool2(replenishPercentage);
  }

  void refillPool2(double percentage) {
    var portionOfCapacity = (desiredCapacity * percentage).round();

    if (portionOfCapacity < 1) {
      portionOfCapacity = 1;
    } else if (portionOfCapacity > desiredCapacity) {
      portionOfCapacity = desiredCapacity;
    }

    for (var i = 0; i < portionOfCapacity; i++) {
      objects[i] = modelObject.instantiate();
    }

    objectsPointer = portionOfCapacity - 1;
  }

  /// Returns an instance of Poolable.  If get() is called with an empty pool,
  /// the pool will be replenished. If the pool capacity is sufficiently large,
  /// this could come at a performance cost.
  ///
  ///     [return] An instance of Poolable object T
  ///
  T get() {
    if ((objectsPointer == -1) && (replenishPercentage > 0.0)) {
      refillPool1();
    }

    T result = objects[objectsPointer];
    result.currentOwnerId = Poolable.NO_OWNER;
    objectsPointer--;

    return result;
  }

  /// Recycle an instance of Poolable that this pool is capable of generating.
  /// The T instance passed must not already exist inside this or
  /// any other ObjectPool instance.
  ///
  ///     [@param] object An object of type T to recycle.
  ///
  void recycle(T object) {
    if (object.currentOwnerId != Poolable.NO_OWNER) {
      if (object.currentOwnerId == poolId) {
        throw Exception('The object passed is already stored in this pool!');
      } else {
        throw Exception(
            'The object to recycle already belongs to poolId ${object.currentOwnerId}. '
            'Object cannot belong to two different pool instances simultaneously!');
      }
    }

    objectsPointer++;

    if (objectsPointer >= objects.length) {
      resizePool();
    }

    object.currentOwnerId = poolId;
    objects[objectsPointer] = object;
  }

  void resizePool() {
    final oldCapacity = desiredCapacity;
    desiredCapacity *= 2;

    var temp = [desiredCapacity];

    for (var i = 0; i < oldCapacity; i++) {
      temp[i] = objects[i];
    }
    objects = temp;
  }
}
