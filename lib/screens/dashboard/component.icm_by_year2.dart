/// Bar chart with example of a legend with customized position, justification,
/// desired max rows, and padding. These options are shown as an example of how
/// to use the customizations, they do not necessary have to be used together in
/// this way. Choosing [end] as the position does not require the justification
/// to also be [endDrawArea].
import 'package:admin/components/charts/chart.line.dart';
import 'package:admin/components/charts/chart.multibar.dart';
import 'package:admin/controllers/controller.icm_by_year.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:admin/constants.dart';

/// Example that shows how to build a series legend that shows measure values
/// when a datum is selected.
///
/// Also shows the option to provide a custom measure formatter.
class ICMByYear2Component extends StatelessWidget {

  final Size size;
  // final double w;

  late final ICMByYearController _controller;

  ICMByYear2Component({required this.size});

  @override
  Widget build(BuildContext context) {

    _controller = ICMByYearController(context);

    return FutureBuilder<List<charts.Series<Map<String, dynamic>, int>>>(
      future: _controller.createICMPerYearData(),
      builder: (context, snapshot) {

        if(!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator(),);
        }

        return CustomLineChart(
          lowerBound: _controller.lowerICMByYearBound!,
          upperBound: _controller.upperICMByYearBound!,
          size: Size(double.infinity, size.height),
          title: "Porcentaje de Obesidad en la poblacion por semestres",
          seriesList: snapshot.data!
        );
      }
    );
  }
}

