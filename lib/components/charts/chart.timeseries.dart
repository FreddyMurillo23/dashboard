import 'package:admin/constants.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class CustomTimeChart extends StatelessWidget {

  final String title;
  final Size size;
  final List<charts.Series<dynamic, DateTime>> seriesList;

  const CustomTimeChart({ 
    Key? key, 
    required this.title,
    required this.seriesList, 
    required this.size
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
            child: charts.TimeSeriesChart(
              seriesList,
              defaultRenderer: charts.LineRendererConfig(
                includeLine: true,
                includePoints: true
              ),
              
              domainAxis: charts.DateTimeAxisSpec(
                tickProviderSpec: seriesList.first.data.length > 1? null:charts.StaticDateTimeTickProviderSpec(
                  [
                    // do it to avoid to show '12 00' when there is only one point
                    charts.TickSpec<DateTime>((seriesList.first.data.first['name'] as DateTime).subtract(Duration(days: 30))),
                    charts.TickSpec<DateTime>(seriesList.first.data.first['name']),
                    charts.TickSpec<DateTime>((seriesList.first.data.first['name'] as DateTime).add(Duration(days: 30))),
                  ]
                ),
                tickFormatterSpec: charts.AutoDateTimeTickFormatterSpec(
                  day: charts.TimeFormatterSpec(
                    format: 'dd MMM',
                    transitionFormat: 'MM/dd/yyyy'
                  )
                )
              )
            ),
          )
        ],
      ),
    );
  }
}