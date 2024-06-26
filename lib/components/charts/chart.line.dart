import 'package:admin/constants.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class CustomLineChart extends StatelessWidget {

  final String title;
  final Size size;
  final int lowerBound;
  final int upperBound;
  final List<charts.Series<dynamic, num>> seriesList;

  const CustomLineChart({ 
    Key? key, 
    required this.title,
    required this.seriesList, 
    required this.size, 
    required this.lowerBound, 
    required this.upperBound
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {

    
    return Container(
      width: size.width,
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
              color: Theme.of(context).shadowColor.withOpacity(0.2),
              blurRadius: 5,
              offset: Offset(-2, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: defaultPadding,
          ),
          SizedBox(
            height: size.height,
            child: charts.LineChart(
              seriesList,
              primaryMeasureAxis: charts.NumericAxisSpec(
                viewport: charts.NumericExtents.fromValues(
                  Iterable.castFrom([0, 100])
                ),
                tickFormatterSpec: charts.BasicNumericTickFormatterSpec(
                  (value) => "$value %"
                )
              ),
              domainAxis: charts.NumericAxisSpec(
                tickProviderSpec: charts.StaticNumericTickProviderSpec(
                  List.generate(upperBound - lowerBound, (index) {
                    return charts.TickSpec<int>(lowerBound + index);
                  })
                ),
                tickFormatterSpec: charts.BasicNumericTickFormatterSpec(
                  (value)=>value.toString()
                )
              ),
              behaviors: [charts.SeriesLegend()],
              defaultRenderer: charts.LineRendererConfig(
                includeLine: true,
                includePoints: true,
                includeArea: true
              )
            ),
          )
        ],
      ),
    );
  }
}