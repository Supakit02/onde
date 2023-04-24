part of widgets.chart.line_chart.core.data;

mixin LineDataProvider {
  Transformer getTransformer();

  double getLowestVisibleX();

  double getHighestVisibleX();

  ChartData getData();
}
