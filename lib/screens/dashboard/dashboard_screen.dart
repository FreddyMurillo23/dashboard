import 'package:admin/screens/dashboard/components/gauge_chart.dart';
import 'package:admin/screens/dashboard/components/gauge_chart.dart';
import 'package:charts_flutter/flutter.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import 'components/gauge_chart.dart';
import 'components/gauge_chart.dart';
import 'components/gauge_chart.dart';
import 'components/header.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:fl_chart/fl_chart.dart' as pie;

import '../../../constants.dart';
import 'components/legends_chart.dart';
import 'components/segment_line_chart.dart';
import 'components/left dashboard/component.medic_records.dart';

class DashboardScreen extends StatefulWidget {
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<charts.Series<dynamic, num>> data = [];
  _generateData() {
    final blue = charts.MaterialPalette.blue.makeShades(2);
    final red = charts.MaterialPalette.red.makeShades(2);
    final green = charts.MaterialPalette.green.makeShades(2);
        final colorChangeData = [
      new LinearSales(0, 5, [], 2.0),
      new LinearSales(1, 15, [], 2.0),
      new LinearSales(2, 25, [], 2.0),
      new LinearSales(3, 75, [], 2.0),
      new LinearSales(4, 100, [], 2.0),
      new LinearSales(5, 90, [], 2.0),
      new LinearSales(6, 75, [], 2.0),
      new LinearSales(7, 78, [], 2.0),
      new LinearSales(8, 79, [], 2.0),
      new LinearSales(9, 85, [], 2.0),
      new LinearSales(10, 90, [], 2.0),
    ];

    // Series of data with changing color and dash pattern.
    final dashPatternChangeData = [
      new LinearSales(0, 5, [2, 2], 2.0),
      new LinearSales(1, 15, [2, 2], 2.0),
      new LinearSales(2, 25, [4, 4], 2.0),
      new LinearSales(3, 75, [4, 4], 2.0),
      new LinearSales(4, 100, [4, 4], 2.0),
      new LinearSales(5, 90, [8, 3, 2, 3], 2.0),
      new LinearSales(6, 75, [8, 3, 2, 3], 2.0),
      new LinearSales(7, 80, [8, 3, 2, 3], 2.0),
      new LinearSales(8, 90, [8, 3, 2, 3], 2.0),
      new LinearSales(9, 75, [8, 3, 2, 3], 2.0),
      new LinearSales(10, 60, [8, 3, 2, 3], 2.0),
    ];

    // Series of data with changing color and stroke width.
    final strokeWidthChangeData = [
      new LinearSales(0, 5, [], 2.0),
      new LinearSales(1, 15, [], 2.0),
      new LinearSales(2, 25, [], 4.0),
      new LinearSales(3, 75, [], 4.0),
      new LinearSales(4, 100, [], 4.0),
      new LinearSales(5, 90, [], 6.0),
      new LinearSales(6, 75, [], 6.0),
      new LinearSales(7, 90, [], 6.0),
      new LinearSales(8, 86, [], 6.0),
      new LinearSales(9, 80, [], 6.0),
      new LinearSales(10, 60, [], 6.0),
    ];
    data = [
      new charts.Series<LinearSales, int>(
        id: 'Color Change',
        // Light shade for even years, dark shade for odd.
        colorFn: (LinearSales sales, _) =>
            sales.year % 2 == 0 ? blue[1] : blue[0],
        dashPatternFn: (LinearSales sales, _) => sales.dashPattern,
        strokeWidthPxFn: (LinearSales sales, _) => sales.strokeWidthPx,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: colorChangeData,
      ),
      new charts.Series<LinearSales, int>(
        id: 'Dash Pattern Change',
        // Light shade for even years, dark shade for odd.
        colorFn: (LinearSales sales, _) =>
            sales.year % 2 == 0 ? red[1] : red[0],
        dashPatternFn: (LinearSales sales, _) => sales.dashPattern,
        strokeWidthPxFn: (LinearSales sales, _) => sales.strokeWidthPx,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: dashPatternChangeData,
      ),
      new charts.Series<LinearSales, int>(
        id: 'Stroke Width Change',
        // Light shade for even years, dark shade for odd.
        colorFn: (LinearSales sales, _) =>
            sales.year % 2 == 0 ? green[1] : green[0],
        dashPatternFn: (LinearSales sales, _) => sales.dashPattern,
        strokeWidthPxFn: (LinearSales sales, _) => sales.strokeWidthPx,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: strokeWidthChangeData,
      ),
    ];
  }

  /// Create series list with multiple series
  static List<charts.Series<OrdinalSales, String>> _createSampleData() {
    final desktopSalesData = [
      new OrdinalSales('2018', 5),
      new OrdinalSales('2019', 25),
      new OrdinalSales('2020', 100),
      new OrdinalSales('2021', 75),
    ];

    final tabletSalesData = [
      new OrdinalSales('2018', 25),
      new OrdinalSales('2019', 50),
      // Purposely have a null data for 2016 to show the null value format.
      new OrdinalSales('2021', 20),
    ];

    final mobileSalesData = [
      new OrdinalSales('2018', 10),
      new OrdinalSales('2019', 15),
      new OrdinalSales('2020', 50),
      new OrdinalSales('2021', 45),
    ];

    final otherSalesData = [
      new OrdinalSales('2018', 20),
      new OrdinalSales('2019', 35),
      new OrdinalSales('2020', 15),
      new OrdinalSales('2021', 10),
    ];

    return [
      new charts.Series<OrdinalSales, String>(
        id: 'Ciencias de la Salud',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: desktopSalesData,
      ),
      new charts.Series<OrdinalSales, String>(
        id: 'Ciencias Informaticas',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: tabletSalesData,
      ),
      new charts.Series<OrdinalSales, String>(
        id: 'Ciencias Matematicas Fisicas y Q',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: mobileSalesData,
      ),
      new charts.Series<OrdinalSales, String>(
        id: 'Ciencias Basicas',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: otherSalesData,
      ),
    ];
  }

 

  @override
  void initState() {
    super.initState();
    _generateData();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(defaultPadding),
      child: Column(
        children: [
          Header(),
          SizedBox(height: defaultPadding),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                  width: MediaQuery.of(context).size.width * 20 / 100 -
                      defaultPadding,
                  child: MedicRecordsComponent()),
              // SizedBox(width: defaultPadding),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      LegendWithMeasures(
                        _createSampleData(),
                        animate: true,
                        h: MediaQuery.of(context).size.height * 35 / 100,
                        w: (MediaQuery.of(context).size.width * 50 / 100) -
                            defaultPadding,
                      ),
                      SizedBox(
                        width: defaultPadding,
                      ),
                      GaugeChart(),
                    ],
                  ),
                  SizedBox(
                    height: defaultPadding,
                  ),
                  SegmentsLineChart(
                    data,
                    animate: true,
                    h: MediaQuery.of(context).size.height * 40 / 100,
                    w: (MediaQuery.of(context).size.width * 75 / 100) -
                        defaultPadding,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Sample linear data type.
class LinearSales {
  final int year;
  final int sales;
  final List<int> dashPattern;
  final double strokeWidthPx;

  LinearSales(this.year, this.sales, this.dashPattern, this.strokeWidthPx);
}

/// Sample time series data type.
class TimeSeriesSales {
  final DateTime time;
  final int sales;

  TimeSeriesSales(this.time, this.sales);
}

/// Sample ordinal data type.
class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}

/// Sample linear data type.
class LinearSales2 {
  final int year;
  final int sales;

  LinearSales2(this.year, this.sales);
}
