import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class CustomLineChart extends StatelessWidget {

  final Size size;
  final String title;
  final List<charts.Series<dynamic, num>> seriesList;

  const CustomLineChart({ Key? key, required this.size, required this.seriesList, required this.title }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width,
      height: size.height,
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          charts.LineChart(
            seriesList,
            animate: true,
            defaultRenderer: charts.LineRendererConfig(
              includePoints: true
            )
          ),
        ],
      ),
    );
  }
}