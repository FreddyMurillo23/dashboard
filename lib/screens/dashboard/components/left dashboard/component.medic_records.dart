import 'package:admin/helpers/helper.icons.dart';
import 'package:admin/screens/dashboard/components/left%20dashboard/controller.medic_records.dart';
import 'package:admin/screens/dashboard/components/storage_info_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import '../../../../constants.dart';
import '../chart.dart';
import 'component.filter_card.dart';

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
          "Registros Medicos",
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
    return <Widget>[
      Center(child: Chart()),

      StorageInfoCard(
        title: "Delgadez",
        numOfFiles: data["valores_netos"][0]["delgadez"],
        amountOfFiles: '${data["valores_porcentuales"][0]["p_delgadez"]}',
        onPress: (){},
        svgSrc: Icon(Icons.info),
      ),
      StorageInfoCard(
        title: "Peso normal",
        numOfFiles: data["valores_netos"][0]["pesonormal"],
        amountOfFiles: '${data["valores_porcentuales"][0]["p_pesonormal"]}',
        onPress: (){},
        svgSrc: Icon(Icons.info),
      ),
      StorageInfoCard(
        title: "Delgadez",
        numOfFiles: data["valores_netos"][0]["sobrepeso"],
        amountOfFiles: '${data["valores_porcentuales"][0]["p_sobrepeso"]}',
        onPress: (){},
        svgSrc: Icon(Icons.info),
      ),
    ];
  }

  /// Returns a list of elements based on the filter the user choose
  List<Widget> _getFilters(MedicRecordsController controller, List<Map<String, dynamic>> data) {
    return <Widget>[
      Center(child: Chart()),

      ...List<Widget>.from(data.map((filter) {
        return FilterCardComponent(
          title: filter["nombre"] ?? "No name", 
          svgSrc: Icon(
            IconHelper().iconFromString(filter["nombre"]),
            color: Color(0xFF26E5FF)
          ), 
          onPress: () async {
            SmartDialog.showLoading();

            await controller.loadFilterValues(filter["cod_clasificacion"]);

            SmartDialog.dismiss();
          }
        );
      }))
    ];
  }


}
