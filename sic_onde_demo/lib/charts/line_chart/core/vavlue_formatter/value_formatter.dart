library widgets.chart.line_chart.core.value_formatter;



import 'package:intl/intl.dart';

import '../entry.dart';
part 'default_axis_value_formatter.dart';

abstract class ValueFormatter {
  String getFormattedValue1(double value) =>
      value.toString();

  String getAxisLabel(double value) =>
      getFormattedValue1(value);

  String getPointLabel(Entry entry) =>
      getFormattedValue1(entry.y);
}