import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

/// This is a multi bar chart that for every single record shows
/// three features, for example, for every faculty shows the 
/// 'delgadez, 'pesonormal', 'sobrepeso' keys coming from the
/// backend
class CustomMultibarChart extends StatelessWidget {

  final List<charts.Series<dynamic, String>> seriesList;

  const CustomMultibarChart({ 
    required this.seriesList,
    Key? key 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new charts.BarChart(
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
          // Positions for "start" and "end" will be left and right respectively
          // for widgets with a build context that has directionality ltr.
          // For rtl, "start" and "end" will be right and left respectively.
          // Since this example has directionality of ltr, the legend is
          // positioned on the right side of the chart.
          position: charts.BehaviorPosition.top,
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
    );
  }  
}


/// Sample ordinal data type.
class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}