part of widgets.chart.line_chart;

class ForegroundChart extends StatefulWidget {
  final ChartController controller;

  const ForegroundChart(this.controller, {
    Key? key,
  }) :  assert(controller != null),
        super(key: key);

  @override
  ForegroundChartState createState() => controller.createState();
}

class ForegroundChartState extends State<ForegroundChart> {
  @override
  void didUpdateWidget(ForegroundChart oldWidget) {
    super.didUpdateWidget(oldWidget);
    widget.controller.state = this;
  }

  void setStateIfNotDispose() {
    if ( mounted ) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    widget.controller.setPainter();

    return Container(
      height: double.infinity,
      width: double.infinity,
      child: CustomPaint(
        painter: widget.controller.painter,
      ),
    );
  }
}