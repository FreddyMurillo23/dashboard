import 'dart:math';

import 'package:admin/helpers/helper.icons.dart';
import 'package:admin/screens/dashboard/components/left%20dashboard/controller.medic_records.dart';
import 'package:admin/screens/dashboard/components/storage_info_card.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import '../../../../constants.dart';
import '../chart.dart';

/// This is the lateral board bar in the main dashboard screen.
/// This will change dinamically based on some filters defined
/// later.
class MedicRecordsComponent extends StatelessWidget {
  const MedicRecordsComponent({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    
    final _controller = MedicRecordsController(context);
    
    // fetching filters from API
    _controller.loadFilters();

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
          // This content is what I'll change based on the filter
          // the user choose
          StreamBuilder<dynamic>(
            stream: _controller.medicRecordsStrm,
            // initialData: _controller.medicRecordsDataStack.last,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if(!snapshot.hasData || snapshot.data == null) {
                return Center(child: CircularProgressIndicator(),);
              }

              late final List<Widget> elements;

              if(snapshot.data! is List<Map<String, dynamic>>) {
                elements = _getFilters(_controller, snapshot.data!);
              }
              else {
                elements = _getFilterOpt(snapshot.data!);
              }


              return Column(
                children: [
                  _lateralDashboardHeader(_controller, snapshot),
                  SizedBox(height: defaultPadding),
                  ...elements
                ]
              );
            },
          ),
        ],
      ),
    );
  }

  Row _lateralDashboardHeader(MedicRecordsController controller, AsyncSnapshot<dynamic> snapshot) {
    return Row(
      children: [
        snapshot.data! is List<Map<String, dynamic>>?
          Container():IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: (){
              controller.goBackRecordPanel();
              print(controller.medicRecordsDataStack);
            },
          ),
        Text(
          "Registros Medicos${
            (snapshot.data is Map<String, dynamic>)?
             "\nde " + snapshot.data['name']:""
          }",
          maxLines: 2,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  /// Returns a list of elements based on the filter the user choose
  List<Widget> _getFilterOpt(Map<String, dynamic> data) {

        // How many colors I should generate for the chart
    final howManyColors = 3;

    List<Color> colors = List.generate(howManyColors, (index) {
      return Color.fromRGBO(
        30 + Random().nextInt(200 - 30), 
        50 + Random().nextInt(100 - 50), 
        Random().nextInt(50),
        1.0
      );
    });

    return <Widget>[
      Center(
        child: CustomPieChart(
          paiChartSelectionDatas: buildDataset(data, colors),
        )
      ),

      StorageInfoCard(
        title: "Delgadez",
        numOfFiles: data["valores_netos"][0]["delgadez"],
        amountOfFiles: '${data["valores_porcentuales"][0]["p_delgadez"]}',
        onPress: (){},
        svgSrc: Icon(Icons.person, color: colors[0]),
      ),
      StorageInfoCard(
        title: "Peso normal",
        numOfFiles: data["valores_netos"][0]["pesonormal"],
        amountOfFiles: '${data["valores_porcentuales"][0]["p_pesonormal"]}',
        onPress: (){},
        svgSrc: Icon(Icons.person, color: colors[1]),
      ),
      StorageInfoCard(
        title: "Delgadez",
        numOfFiles: data["valores_netos"][0]["sobrepeso"],
        amountOfFiles: '${data["valores_porcentuales"][0]["p_sobrepeso"]}',
        onPress: (){},
        svgSrc: Icon(Icons.person, color: colors[2]),
      ),
    ];
  }

  /// Returns a list of elements based on the filter the user choose
  List<Widget> _getFilters(MedicRecordsController controller, List<Map<String, dynamic>> data) {

    // How many colors I should generate for the chart
    final howManyColors = data.length;

    List<Color> colors = List.generate(howManyColors, (index) {
      return Color.fromRGBO(
        Random().nextInt(200), 
        Random().nextInt(150), 
        Random().nextInt(100),
        1.0
      );
    });

    // Since I cannot get an index in the next map process, I'll
    // be using this index
    int index = 0;

    print(data);

    return <Widget>[
      Center(child: CustomPieChart(
        paiChartSelectionDatas: buildDataset(data, colors),
      )),
      
      ...List<Widget>.from(data.map((filter) {
        return StorageInfoCard(
          amountOfFiles: ((filter["porcentaje"] ?? 10.0) as double).toStringAsFixed(2),
          numOfFiles: filter["cantidad_registros"] ?? 1,
          title: filter["nombre"] ?? "No name", 
          svgSrc: Icon(
            IconHelper().iconFromString(filter["nombre"]),
            color: colors[index++]
          ), 
          onPress: () async {
            SmartDialog.showLoading();

            await controller.loadFilterValues(filter["cod_clasificacion"], filter["nombre"]);

            SmartDialog.dismiss();
          }
        );
      }))
    ];
  }

  /// builds a dataset for the pie chart. [data] size needs to be equal to
  /// [colors] length if [data] is a List, otherwise, the length of [colors]
  /// should be 3.
  List<PieChartSectionData> buildDataset(dynamic data, List<Color> colors) {

    final List<PieChartSectionData> elements = [];

    // min max standarization
    double min = 0.0;
    double max = 100.0;
    double minSize = 15.0;
    double scaleFactor = 25.0;

    if(data is Map<String, dynamic>) {
      
      elements.add(PieChartSectionData(
        color: colors[0],
        value: data["valores_porcentuales"][0]['p_delgadez'],
        title: 'Delgadez',
        radius: minSize + scaleFactor * (data["valores_porcentuales"][0]['p_delgadez'] - min) / (max - min),
        showTitle: false,
      ));
      elements.add(PieChartSectionData(
        color: colors[1],
        value: data["valores_porcentuales"][0]['p_pesonormal'],
        title: 'Peso Normal',
        radius:  minSize + scaleFactor * (data["valores_porcentuales"][0]['p_pesonormal'] - min) / (max - min),
        showTitle: false,
      ));
      elements.add(PieChartSectionData(
        color: colors[2],
        value: data["valores_porcentuales"][0]['p_sobrepeso'],
        title: 'Sobrepeso',
        radius:  minSize + scaleFactor * (data["valores_porcentuales"][0]['p_sobrepeso'] - min) / (max - min),
        showTitle: false,
      ));
    }
    else if(data is List<Map<String, dynamic>>){ // if data is a list
      
      int idx = 0;

      data.forEach((item) {
        
        elements.add(PieChartSectionData(
          color: colors[idx++],
          value: 10.0,
          title: item['nombre'],
          showTitle: false,
          radius: minSize + scaleFactor * ((item["porcentaje"] ?? 1) - min) / (max - min),
        ));

      });
      
    }

    return elements;

  }

}
