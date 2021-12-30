/// Bar chart with example of a legend with customized position, justification,
/// desired max rows, and padding. These options are shown as an example of how
/// to use the customizations, they do not necessary have to be used together in
/// this way. Choosing [end] as the position does not require the justification
/// to also be [endDrawArea].
import 'package:admin/components/charts/chart.multibar.dart';
import 'package:admin/controllers/controller.icm_by_year.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:admin/constants.dart';

/// Example that shows how to build a series legend that shows measure values
/// when a datum is selected.
///
/// Also shows the option to provide a custom measure formatter.
class ICMByYearComponent extends StatelessWidget {

  final double h;
  // final double w;

  late final ICMByYearController _controller;

  ICMByYearComponent({required this.h});

  @override
  Widget build(BuildContext context) {

    _controller = ICMByYearController(context);

    return Container(
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
            "IMC por Facultad",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: defaultPadding,
          ),
          Container(
            height: h,
            // width: w,
            child: FutureBuilder<List<charts.Series<Map<String, dynamic>, String>>>(
              future: _controller.createICMPerFacultyData(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                
                if(!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator(),);
                }

                return CustomMultibarChart(
                  seriesList: snapshot.data!,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

