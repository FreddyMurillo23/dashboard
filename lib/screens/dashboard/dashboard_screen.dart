import 'package:admin/components/charts/chart.line.dart';
import 'package:admin/components/header.dart';
import 'package:admin/screens/dashboard/component.overweight.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import 'component.overweight.dart';

import '../../../constants.dart';
import 'component.medic_records.dart';
import 'component.icm_by_year.dart';

class DashboardScreen extends StatefulWidget {
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(defaultPadding),
      child: Column(
        children: [
          Header(),
          SizedBox(height: defaultPadding),
          SizedBox(
            height: MediaQuery.of(context).size.height * 1.0,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: MedicRecordsComponent()
                ),
                SizedBox(
                  width: defaultPadding,
                ),
                Expanded(
                  flex: 6,
                  child: ICMByYearComponent(
                    h: MediaQuery.of(context).size.height * 0.4
                  ),
                ),
                SizedBox(
                  width: defaultPadding,
                ),
                Expanded(
                  flex: 2,
                  child: GaugeChart()
                ),
              ],
            ),
          ),
          SizedBox(
            height: defaultPadding,
          ),
          CustomLineChart(
            title: "Porcentaje de Obesidad en la poblacion por semestres",
            size: Size(
              MediaQuery.of(context).size.width * 0.75 - defaultPadding,
              MediaQuery.of(context).size.height * 0.4,
            ),
            seriesList: []
          )
        ],
      ),
    );
  }
}