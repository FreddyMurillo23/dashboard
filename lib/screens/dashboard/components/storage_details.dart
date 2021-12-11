import 'package:flutter/material.dart';

import '../../../constants.dart';
import 'chart.dart';
import 'storage_info_card.dart';

class StarageDetails extends StatelessWidget {
  const StarageDetails({
    Key? key,
  }) : super(key: key);

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
            "Registros Medicos",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: defaultPadding),
          Center(child: Chart()),
          StorageInfoCard(
            svgSrc: Icon(Icons.person,color: primaryColor),
            title: "Estudiantes",
            amountOfFiles: "26 %",
            numOfFiles: 1328, 
          ),
          StorageInfoCard(
            svgSrc: Icon(Icons.person,color: Color(0xFF26E5FF),),
            title: "Empleado",
            amountOfFiles: "25 %",
            numOfFiles: 1328,
          ),
          StorageInfoCard(
            svgSrc: Icon(Icons.person,color: Color(0xFFFFCF26),),
            title: "Docentes",
            amountOfFiles: "15%",
            numOfFiles: 1328,
          ),
          StorageInfoCard(
            svgSrc: Icon(Icons.person,color:Colors.brown ),
            title: "Jubilado",
            amountOfFiles: "10%",
            numOfFiles: 140,
          ),
          StorageInfoCard(
            svgSrc: Icon(Icons.person,color:Colors.lightGreen),
            title: "Obrero",
            amountOfFiles: "28%",
            numOfFiles: 1650,
          ),
          StorageInfoCard(
            svgSrc: Icon(Icons.person,color:Color(0xFFEE2727),),
            title: "Otros",
            amountOfFiles: "28%",
            numOfFiles: 1650,
          ),
        ],
      ),
    );
  }
}
