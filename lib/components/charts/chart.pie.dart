import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../constants.dart';

class CustomPieChart extends StatelessWidget {
  final int? validRecords;
  final int? totalRecords;
  const CustomPieChart({
    Key? key,
    required this.paiChartSelectionDatas, 
    this.validRecords, 
    this.totalRecords
  }) : super(key: key);

  final List<PieChartSectionData> paiChartSelectionDatas;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Center(
        child: Stack(
          children: [
            PieChart(
              PieChartData(
                sectionsSpace: 0,
                centerSpaceRadius: 70,
                startDegreeOffset: -90,
                sections: paiChartSelectionDatas,
              ),
            ),
            Positioned.fill(
              child: totalRecords == null?Container():Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: defaultPadding),
                  Text(
                    "$totalRecords",
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      height: 0.5,
                    ),
                  ),
                  Text("REGISTROS", textAlign: TextAlign.center,)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
