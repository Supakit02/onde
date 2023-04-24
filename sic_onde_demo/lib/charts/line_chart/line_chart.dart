library widgets.chart.line_chart;



import 'package:flutter/material.dart';
import 'package:sic_onde_demo/charts/line_chart/controller.dart';

part 'chart/foreground_chart.dart';
part 'chart/background_chart.dart';

class LineChart extends StatelessWidget {
  final ChartController _controller;

  const LineChart(
    this._controller, {
    Key? key,
  }) :  assert(_controller != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _controller.backgroundColor
            ?? Colors.white,
      ),
      child: Stack(
        children: [
          BackgroundChart(_controller),
          ForegroundChart(_controller),
        ],
      ),
    );
  }
}