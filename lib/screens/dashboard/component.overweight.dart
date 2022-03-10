import 'package:admin/components/charts/chart.pie.dart';
import 'package:admin/components/storage_info_card.dart';
import 'package:admin/helpers/helper.colors.dart';
import 'package:admin/controllers/controller.overweight.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class GaugeChart extends StatelessWidget {
  final Size size;

  late final OverweightController _controller;

  GaugeChart({Key? key, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _controller = OverweightController(context);

    return Container(
      width: size.width,
      // height: size.height,
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
            "Facultades con mayor sobrepeso",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: defaultPadding),
          SizedBox(
            // width: MediaQuery.of(context).size.width * 22.5 / 100,
            child: FutureBuilder<List<Map<String, dynamic>>>(
                future: _controller.createSampleData(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  // sorting elements to get the top 7
                  var data = snapshot.data!;
                  data.sort((a, b) {
                    final valueA = a["porcentaje_sobrepeso"];
                    final valueB = b["porcentaje_sobrepeso"];

                    return valueA < valueB ? 1 : (valueA == valueB ? 0 : -1);
                  });

                  // only consider top 5
                  // data = data.getRange(0, 5).toList();
                  final colors = ColorHelpers().generateColors(data.length);

                  return Container(
                    height: size.height,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          infoCards(data, colors),
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }

  Widget infoCards(List<Map<String, dynamic>> data, List<Color> colors) {
    int colorIdx = 0;

    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List<Widget>.from(data.map((element) {
          return StorageInfoCard(
            title: element['facultad'],
            svgSrc: Icon(
              Icons.school,
              color: colors[colorIdx++],
            ),
            amountOfFiles: "${element['porcentaje_sobrepeso']}",
            numOfFiles: element['total_poblacion'],
            onPress: () {},
          );
        })));
  }
}
