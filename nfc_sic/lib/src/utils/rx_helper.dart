part of nfc_sic.utils;

/// Manage and store a subscription on events
/// from a `Stream` is running now.
class RxHelper {
  RxHelper()
    : _subscriptions = <StreamSubscription>[];

  final List<StreamSubscription> _subscriptions;

  /// Returns the total amount of currently
  /// added [StreamSubscription].
  int get length => _subscriptions.length;

  /// Checks if there currently are
  /// no [StreamSubscription] added.
  bool get isEmpty => _subscriptions.isEmpty;

  /// Checks if there currently are
  /// [StreamSubscription] added.
  bool get isNotEmpty => _subscriptions.isNotEmpty;

  /// Adds new subscription on events from
  /// a `Stream` to subscription list.
  StreamSubscription<T> add<T>(
      StreamSubscription<T> subscription) {
    assert(
      subscription != null,
      'subscription cannot be null');

    _subscriptions.add(subscription);

    return subscription;
  }

  /// Cancels subscription on events and
  /// removes it from subscriptions list.
  Future<bool> remove<T>(
      StreamSubscription<T> subscription) async {
    assert(
      subscription != null,
      'subscription cannot be null');

    await subscription.cancel();

    return _subscriptions.remove(subscription);
  }

  /// Cancels all subscriptions added to this
  /// subscriptions list.
  /// Clears subscriptions collection.
  Future<void> clear() async {
    if ( isEmpty ) {
      return;
    }

    for ( final _sub in _subscriptions ) {
      await _sub?.cancel();
    }

    _subscriptions.clear();
  }

  /// Cancels all subscriptions added to this
  /// class. Disposes this.
  Future<void> dispose() async {
    await clear();
  }
}