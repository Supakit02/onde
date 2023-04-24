part of widgets.chart.line_chart.core.data;



mixin IDataSet {
  double getLineWidth();

  double getYMin();

  double getYMax();

  double getXMin();

  double getXMax();

  int getEntryCount();

  void calcMinMax();

  Entry getEntryForXValue1(
    double xValue, double closestToY, Rounding rounding);

  Entry getEntryForIndex(int index);

  int getEntryIndex1(
    double xValue, double closestToY, Rounding rounding);

  int getEntryIndex2(Entry e);

  void addEntryOrdered(Entry e);

  Color getColor();
}