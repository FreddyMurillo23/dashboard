import 'package:admin/helpers/helper.colors.dart';
import 'package:admin/screens/dashboard/components/charts/chart.pie.dart';
import 'package:admin/screens/dashboard/components/overweight_faculties/controller.overweight.dart';
import 'package:admin/screens/dashboard/components/storage_info_card.dart';
import 'package:flutter/material.dart';

import '../../../../constants.dart';

class GaugeChart extends StatelessWidget {
  
  late final OverweightController _controller;

  @override
  Widget build(BuildContext context) {

    _controller = OverweightController(context);

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
      child: SingleChildScrollView(
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
            SizedBox(
              width: MediaQuery.of(context).size.width * 22.5 / 100,
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: _controller.createSampleData(),
                builder: (context, snapshot) {
      
                  if(!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator(),);
                  }
      
                     // sorting elements to get the top 7
                  var data = snapshot.data!;
                  data.sort((a, b) {
      
                    int valueA = a["valores_netos"][0]["sobrepeso"];
                    int valueB = b["valores_netos"][0]["sobrepeso"];
      
                    return valueA > valueB? 1:(valueA == valueB?0:-1);
                  });
      
                  // only consider top 5
                  data = data.getRange(0, 5).toList();
                  final colors = ColorHelpers().generateColors(data.length);
      
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 35 / 100,
                        width: MediaQuery.of(context).size.width * 10 / 100,
                        child: CustomPieChart(
                          paiChartSelectionDatas: _controller.buildDataset(
                            data, 
                            colors
                          ),
                        )
                      ),
                      infoCards(data, colors),
                    ],
                  );
                }
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget infoCards(List<Map<String, dynamic>> data, List<Color> colors) {

    int colorIdx = 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List<Widget>.from(data.map((element) {
        return StorageInfoCard(
          title: element['nombre_facultad'],
          svgSrc: Icon(
            Icons.android,
            color: colors[colorIdx++],
          ), 
          amountOfFiles: "${element['valores_porcentuales'][0]['p_sobrepeso']}", 
          numOfFiles: element['valores_netos'][0]['sobrepeso'], 
          onPress: (){},
        );
      }))
    );
  }
}
