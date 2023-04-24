part of widgets.chart.line_chart;

class BackgroundChart extends StatefulWidget {
  final ChartController controller;

  const BackgroundChart(this.controller, {
    Key? key,
  }) :  assert(controller != null),
        super(key: key);

  @override
  _BackgroundChartState createState() => _BackgroundChartState();
}

class _BackgroundChartState extends State<BackgroundChart> {
  @override
  void reassemble() {
    super.reassemble();
    widget.controller.backPainter.reassemble();
  }

  @override
  Widget build(BuildContext context) {
    widget.controller.doneBeforePainterInit();
    widget.controller.initialPainter();

    return Container(
      height: double.infinity,
      width: double.infinity,
      child: CustomPaint(
        painter: widget.controller.backPainter,
      ),
    );
  }
}