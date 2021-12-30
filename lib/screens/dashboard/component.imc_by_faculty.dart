/// Bar chart with example of a legend with customized position, justification,
/// desired max rows, and padding. These options are shown as an example of how
/// to use the customizations, they do not necessary have to be used together in
/// this way. Choosing [end] as the position does not require the justification
/// to also be [endDrawArea].
import 'package:admin/components/charts/chart.multibar.dart';
import 'package:admin/controllers/controller.imc.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

/// Example that shows how to build a series legend that shows measure values
/// when a datum is selected.
///
/// Also shows the option to provide a custom measure formatter.
class IMCByFacultyComponent extends StatelessWidget {

  final Size size;

  late final IMCController _controller;

  IMCByFacultyComponent({required this.size});

  @override
  Widget build(BuildContext context) {

    _controller = IMCController(context);

    return FutureBuilder<List<charts.Series<Map<String, dynamic>, String>>>(
      future: _controller.createIMCPerFacultyData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        
        if(!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator(),);
        }

        return CustomMultibarChart(
          size: size,
          title: "IMC por facultad en los últimos dos años",
          seriesList: snapshot.data!,
        );
      },
    );
  }
}

