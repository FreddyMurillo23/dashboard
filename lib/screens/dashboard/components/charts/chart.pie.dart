import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../constants.dart';

class CustomPieChart extends StatelessWidget {
  const CustomPieChart({
    Key? key,
    required this.paiChartSelectionDatas
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: defaultPadding),
                  Text(
                    "6598",
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          height: 0.5,
                        ),
                  ),
                  Text("de 8502")
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
