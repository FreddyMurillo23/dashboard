import 'package:admin/screens/dashboard/components/left%20dashboard/controller.medic_records.dart';
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
            "Registros Medicos",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: defaultPadding),

          // This content is what I'll change based on the filter
          // the user choose
          FutureBuilder<List<Map<String, dynamic>>>(
            future: _controller.loadFilters(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if(!snapshot.hasData) {
                return Center(child: CircularProgressIndicator(),);
              }

              return Column(
                children: _getContent(snapshot.data!),
              );
            },
          ),
        ],
      ),
    );
  }

  /// Returns a list of elements based on the filter the user choose
  List<Widget> _getContent(List<Map<String, dynamic>> data) {
    return <Widget>[
      Center(child: Chart()),

      ...List<Widget>.from(data.map((filter) {
        return FilterCardComponent(
          title: filter["nombre"] ?? "No name", 
          svgSrc: Icon(Icons.filter_alt_rounded, color: Color(0xFF26E5FF)), 
          onPress: (){
            SmartDialog.showToast('Hola');
          }
        );
      }))
    ];
  }
}
