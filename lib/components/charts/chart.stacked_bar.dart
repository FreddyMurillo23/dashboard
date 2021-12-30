import 'package:admin/constants.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

/// This is a multi bar chart that for every single record shows
/// three features, for example, for every faculty shows the 
/// 'delgadez, 'pesonormal', 'sobrepeso' keys coming from the
/// backend
class CustomStackedBar extends StatelessWidget {

  final String title;
  final Size size;
  final List<charts.Series<dynamic, String>> seriesList;

  const CustomStackedBar({ 
    required this.title,
    required this.size,
    required this.seriesList,
    Key? key 
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
            offset: Offset(-2, 2)
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: defaultPadding,
          ),
          SizedBox(
            height: size.height,
            child: charts.BarChart(
              seriesList,
              defaultRenderer: charts.BarRendererConfig(
                groupingType: charts.BarGroupingType.stacked, 
                strokeWidthPx: 2.0
              ),
              behaviors: [
                charts.SeriesLegend(
                  outsideJustification: charts.OutsideJustification.middle,
                  position: charts.BehaviorPosition.end,
                  showMeasures: true,
                ),
              ],
            ),
          )
        ],
      ),
    );
    
  }  
}