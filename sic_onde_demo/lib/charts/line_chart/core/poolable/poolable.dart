library widgets.chart.line_chart.core.poolable;

part 'size.dart';
part 'point.dart';

abstract class Poolable {
  static const int NO_OWNER = -1;

  int currentOwnerId = NO_OWNER;

  Poolable instantiate();
}