import 'package:admin/screens/dashboard/components/storage_info_card.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart' as pie;
import 'package:fl_chart/fl_chart.dart';

import '../../../constants.dart';

class GaugeChart extends StatefulWidget {
  const GaugeChart({Key? key}) : super(key: key);

  @override
  State<GaugeChart> createState() => _GaugeChartState();
}

class _GaugeChartState extends State<GaugeChart> {
  List<PieChartSectionData> paiChartSelectionDatas = [
    PieChartSectionData(
      color: primaryColor,
      value: 25,
      showTitle: false,
      radius: 25,
    ),
    PieChartSectionData(
      color: primaryColor.withOpacity(0.8),
      value: 20,
      showTitle: false,
      radius: 22,
    ),
    PieChartSectionData(
      color: primaryColor.withOpacity(0.5),
      value: 10,
      showTitle: false,
      radius: 19,
    ),
    PieChartSectionData(
      color: primaryColor.withOpacity(0.3),
      value: 15,
      showTitle: false,
      radius: 16,
    ),
    PieChartSectionData(
      color: primaryColor.withOpacity(0.1),
      value: 25,
      showTitle: false,
      radius: 13,
    ),
  ];

  @override
  Widget build(BuildContext context) {
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
            "Facultades con mayor sobrepeso.",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: defaultPadding),
          Container(
            width: MediaQuery.of(context).size.width * 22.5 / 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 35 / 100,
                  width: MediaQuery.of(context).size.width * 10 / 100,
                  child: pie.PieChart(
                    pie.PieChartData(
                      sectionsSpace: 0,
                      centerSpaceRadius: 70,
                      startDegreeOffset: -90,
                      sections: paiChartSelectionDatas,
                    ),
                  ),
                ),
        // SizedBox(height:defaultPadding),

                infoCards(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget infoCards() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(defaultPadding / 2),
          decoration: BoxDecoration(
            border: Border.all(width: 2, color: primaryColor.withOpacity(0.15)),
            borderRadius: const BorderRadius.all(
              Radius.circular(defaultPadding),
            ),
          ),
          child: Row(
            children: [
              Icon(
                Icons.android,
                color: primaryColor,
              ),
              SizedBox(width: defaultPadding / 2),
              Text('Ciencias de la salud')
            ],
          ),
        ),
        SizedBox(height:defaultPadding/2),
        Container(
          padding: EdgeInsets.all(defaultPadding / 2),
          decoration: BoxDecoration(
            border: Border.all(width: 2, color: primaryColor.withOpacity(0.15)),
            borderRadius: const BorderRadius.all(
              Radius.circular(defaultPadding),
            ),
          ),
          child: Row(
            children: [
              Icon(
                Icons.android,
                color: primaryColor,
              ),
              SizedBox(width: defaultPadding / 2),
              Text('CPAI')
            ],
          ),
        ),
        SizedBox(height:defaultPadding/2),

        Container(
          padding: EdgeInsets.all(defaultPadding / 2),
          decoration: BoxDecoration(
            border: Border.all(width: 2, color: primaryColor.withOpacity(0.15)),
            borderRadius: const BorderRadius.all(
              Radius.circular(defaultPadding),
            ),
          ),
          child: Row(
            children: [
              Icon(
                Icons.android,
                color: primaryColor,
              ),
              SizedBox(width: defaultPadding / 2),
            Text('CMFQ')
            ],
          ),
        ),
        SizedBox(height:defaultPadding/2),

        Container(
          padding: EdgeInsets.all(defaultPadding / 2),
          decoration: BoxDecoration(
            border: Border.all(width: 2, color: primaryColor.withOpacity(0.15)),
            borderRadius: const BorderRadius.all(
              Radius.circular(defaultPadding),
            ),
          ),
          child: Row(
            children: [
              Icon(
                Icons.android,
                color: primaryColor,
              ),
              SizedBox(width: defaultPadding / 2),
              Text('Ciencias humanisticas')
            ],
          ),
        ),
        SizedBox(height:defaultPadding/2),

        Container(
          padding: EdgeInsets.all(defaultPadding / 2),
          decoration: BoxDecoration(
            border: Border.all(width: 2, color: primaryColor.withOpacity(0.15)),
            borderRadius: const BorderRadius.all(
              Radius.circular(defaultPadding),
            ),
          ),
          child: Row(
            children: [
              Icon(
                Icons.android,
                color: primaryColor,
              ),
              SizedBox(width: defaultPadding / 2),
              Text('Ciencias administrativas')
            ],
          ),
        )
      ],
    );
  }
}
