import 'package:admin/components/charts/chart.stacked_bar.dart';
import 'package:admin/controllers/controller.imc.dart';
import 'package:flutter/material.dart';

import 'package:charts_flutter/flutter.dart' as charts;

class GenderIMCComponent extends StatelessWidget {

  final Size size;
  const GenderIMCComponent({ Key? key, required this.size }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final _controller = IMCController(context);

    return FutureBuilder<List<charts.Series<Map<String, dynamic>, String>>>(
      future: _controller.createIMCPerGenderData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        
        if(!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator(),);
        }

        return CustomStackedBar(
          size: size,
          title: "IMC global por género",
          seriesList: snapshot.data!,
        );
      },
    );
  }
}