import 'package:admin/components/charts/chart.pie.dart';
import 'package:admin/components/storage_info_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import 'package:admin/helpers/helper.colors.dart';
import 'package:admin/helpers/helper.icons.dart';

import '../../constants.dart';
import '../../controllers/controller.medic_records.dart';

/// This is the lateral board bar in the main dashboard screen.
/// This will change dinamically based on some filters defined
/// later.
class MedicRecordsComponent extends StatelessWidget {

  final Size size;

  const MedicRecordsComponent({
    Key? key,
    required this.size
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    
    final _controller = MedicRecordsController(context);
    
    // fetching filters from API
    _controller.loadFilters();

    return Container(
      width: size.width,
      height: size.height,
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
      child: StreamBuilder<dynamic>(
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
            elements = _getFilterOpt(_controller, snapshot.data!);
          }


          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _lateralDashboardHeader(_controller, snapshot),
                SizedBox(height: defaultPadding),
                ...elements
              ]
            ),
          );
        },
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
  List<Widget> _getFilterOpt(MedicRecordsController controller, Map<String, dynamic> data) {

        // How many colors I should generate for the chart
    final howManyColors = 3;

    final colors = ColorHelpers().generateColors(howManyColors);

    return <Widget>[
      Center(
        child: CustomPieChart(
          paiChartSelectionDatas: controller.buildDataset(data, colors),
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

    List<Color> colors = ColorHelpers().generateColors(howManyColors);

    // Since I cannot get an index in the next map process, I'll
    // be using this index
    int index = 0;

    print(data);

    return <Widget>[
      Center(child: CustomPieChart(
        paiChartSelectionDatas: controller.buildDataset(data, colors),
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
}
