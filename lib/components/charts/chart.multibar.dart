import 'package:admin/constants.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

/// This is a multi bar chart that for every single record shows
/// three features, for example, for every faculty shows the 
/// 'delgadez, 'pesonormal', 'sobrepeso' keys coming from the
/// backend
class CustomMultibarChart extends StatelessWidget {

  final Widget title;
  final Size size;
  final List<charts.Series<dynamic, String>> seriesList;

  const CustomMultibarChart({ 
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
          title,
          SizedBox(
            height: defaultPadding,
          ),
          SizedBox(
            height: size.height,
            child: charts.BarChart(
              seriesList,
              animate: true,
              barGroupingType: charts.BarGroupingType.grouped,
              domainAxis: new charts.OrdinalAxisSpec(
                renderSpec: new charts.SmallTickRendererSpec(
                  // labelRotation: 85,
                  labelCollisionRotation: 30,
                  labelAnchor: charts.TickLabelAnchor.inside,
                )
              ),
              behaviors: [
                new charts.SeriesLegend(
                  entryTextStyle: charts.TextStyleSpec(
                    fontSize: 14
                  ),
                  // Positions for "start" and "end" will be left and right respectively
                  // for widgets with a build context that has directionality ltr.
                  // For rtl, "start" and "end" will be right and left respectively.
                  // Since this example has directionality of ltr, the legend is
                  // positioned on the right side of the chart.
                  position: charts.BehaviorPosition.end,
                  outsideJustification: charts.OutsideJustification.middle,

                  // By default, if the position of the chart is on the left or right of
                  // the chart, [horizontalFirst] is set to false. This means that the
                  // legend entries will grow as new rows first instead of a new column.
                  // horizontalFirst: false,
                  // This defines the padding around each legend entry.
                  cellPadding: new EdgeInsets.only(right: 4.0, bottom: 4.0),
                  // Set show measures to true to display measures in series legend,
                  // when the datum is selected.
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