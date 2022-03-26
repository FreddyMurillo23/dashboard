import 'package:admin/components/LoadingWidget.dart';
import 'package:admin/components/charts/chart.timeseries.dart';
import 'package:admin/components/component.info_tile.dart';
import 'package:admin/constants.dart';
import 'package:admin/controllers/controller.imc.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class UserHealthData extends StatelessWidget {
  final Map<String, dynamic> user;
  final bool isLoading;
  const UserHealthData({ 
    Key? key, 
    required this.user,
    this.isLoading = false 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: [
          isLoading? 
            LoadingWidget(size: Size(
              size.width * 0.58, size.height * 0.10
            )):
            _header(context, Size(
              size.width * 0.58, size.height * 0.12
            )),
          SizedBox(height: 10.0,),
          isLoading? 
            LoadingWidget(size: Size(
              size.width * 0.58, size.height * 0.2 
            )):
            _healtData(context, Size(
              size.width * 0.58, size.height * 0.2 
            )),
          SizedBox(height: 10.0,),
          isLoading?
            LoadingWidget(size: Size(
              size.width * 0.58, size.height * 0.35
            )):
            SizedBox(
              width: size.width * 0.58,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _getHistoryWidget(
                    Size(size.width * 0.28, size.height * 0.3),
                    List<Map<String, dynamic>>.from(user['antecedentes'])
                  ),
                  _getHabitsWidget(
                    Size(size.width * 0.28, size.height * 0.3),
                    List<Map<String, dynamic>>.from(user['datos_nutricionales'])
                  )
                ],
              ),
            ),
          SizedBox(height: 10.0,),
          isLoading?
            LoadingWidget(size: Size(size.width * 0.58, size.height *0.3))
            :_datagraph(context, Size(
              size.width * 0.58, size.height *0.45
            )),
          SizedBox(height: 10.0,),
          isLoading?
            LoadingWidget(size: Size(size.width * 0.58, size.height *0.5))
            :_getMedicRecords(Size(
              size.width * 0.58, size.height *0.45
            )),
        ],
      ),
    );
  }

  Widget _header(BuildContext context, Size size) {

    String complexion = "";
    double imc = user['enfermeria_actual'].isNotEmpty? user['enfermeria_actual'].last['imc']:-99.0;

    if(imc < 0) complexion = "DESCONOCIDA";
    else if(imc < 18.5) complexion = "DELGADEZ";
    else if(imc >= 25.0) complexion = "SOBREPESO";
    else complexion = "NORMAL";

    return Container(
      margin: const EdgeInsets.only(top: defaultPadding),
      // padding: const EdgeInsets.all(defaultPadding),
      width: size.width,
      // height: size.height,
      decoration: BoxDecoration(
        // color: secondaryColor, borderRadius: BorderRadius.circular(10)
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InfoTile(
            icon: Icons.person,
            title: "COMPLEXION FISICA",
            value: complexion,
            size: Size(size.width * 0.24, size.height),
            titleSize: 14.0,
            valueSize: 18.0,
            iconSize: 17.0,
          ),
          InfoTile(
            icon: Icons.circle_outlined,
            title: "SEXO",
            value: user['datos_personales'][0]['genero'] == 'M'? 'MASCULINO':'FEMENINO',
            size: Size(size.width * 0.24, size.height),
            titleSize: 14.0,
            valueSize: 18.0,
            iconSize: 17.0,
          ),
          InfoTile(
            icon: Icons.health_and_safety,
            title: "DISCAPACIDAD",
            value: user['datos_personales'][0]['discapacidad'] ?? 'NINGUNA',
            size: Size(size.width * 0.24, size.height),
            titleSize: 14.0,
            valueSize: 18.0,
            iconSize: 17.0,
          ),
          InfoTile(
            icon: Icons.medication_sharp,
            title: "RIESGO HIPERTENSION",
            value: user['alertas'][0]['propenso_hipertension'] == 1? 'Sí':'No',
            size: Size(size.width * 0.24, size.height),
            bgColor: user['alertas'][0]['propenso_hipertension'] == 1?Colors.red:Colors.white,
            fgColor: user['alertas'][0]['propenso_hipertension'] == 1?Colors.white:Colors.black,
            titleSize: 14.0,
            valueSize: 18.0,
            iconSize: 17.0,
          ),
        ],
      ),
    );
  }

  Container _getHabitsWidget(Size size, List<Map<String, dynamic>> habits) {

    return Container(
      width: size.width,
      child: Column(
        children: [
          Text(
            "Hábitos",
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.white,
              fontWeight: FontWeight.bold
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey[300]!,
                width: 2.0
              ),
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              height: size.height,
              padding: const EdgeInsets.all(5.0),
              child: habits.isEmpty?
              Center(child: Text("No hay datos")):
              _getHabitTile(habits.first)
            ),
          )
        ],
      ),
    );
  }
 
  Container _getHabitTile(Map<String, dynamic> hist) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey[300]!,
          width: 2.0
        ),
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.infinity,
      padding: const EdgeInsets.all(5.0),
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              text: "Actividad Física: ",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
              children: [
                TextSpan(text: hist['actividad_fisica'], 
                  style: TextStyle(fontWeight: FontWeight.normal)
                )
              ]
            )
          ),
          Text.rich(
            TextSpan(
              text: "Alcohol: ",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
              children: [
                TextSpan(text: hist['alcohol'] == '1'? 'Sí':'No',
                  style: TextStyle(fontWeight: FontWeight.normal)
                )
              ]
            )
          ),
          Text.rich(
            TextSpan(
              text: "Cigarrillo: ",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
              children: [
                TextSpan(text: hist['cigarrillo'] == '1'? 'Sí':'No',
                  style: TextStyle(fontWeight: FontWeight.normal)
                )
              ]
            )
          ),
          Text.rich(
            TextSpan(
              text: "Apetito: ",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
              children: [
                TextSpan(text: hist['apetito'],
                  style: TextStyle(fontWeight: FontWeight.normal)
                )
              ]
            )
          ),
          Text.rich(
            TextSpan(
              text: "Masticación: ",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
              children: [
                TextSpan(text: hist['masticacion'],
                  style: TextStyle(fontWeight: FontWeight.normal)
                )
              ]
            )
          ),
          Text.rich(
            TextSpan(
              text: "Hábito intestinal: ",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
              children: [
                TextSpan(text: hist['habito_intestinal'],
                  style: TextStyle(fontWeight: FontWeight.normal)
                )
              ]
            )
          ),
        ],
      ),
    );
  }

  Widget _healtData(BuildContext context, Size size) {
    
    return Container(
      width: size.width,
      padding: EdgeInsets.symmetric(horizontal: defaultPadding),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.white),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: defaultPadding),
        child: ClipRRect(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _healthDataCard(
                context,
                imgUrl: 'assets/images/pt-dashboard-01.png',
                label: 'Temperatura',
                value: user['enfermeria_actual'].isNotEmpty? '${user['enfermeria_actual'].last['temperatura']}':'No disponible'
              ),
              _healthDataCard(
                context,
                imgUrl: 'assets/images/pt-dashboard-02.png',
                label: 'Intolerancia',
                value: '${user['datos_nutricionales'].isNotEmpty? user['datos_nutricionales'][0]['intolerencia']:'No disponible'}'
              ),
              _healthDataCard(
                context,
                imgUrl: 'assets/images/pt-dashboard-03.png',
                label: 'IMC',
                value: user['enfermeria_actual'].isNotEmpty? '${user['enfermeria_actual'].last['imc']}':'No disponible'
              ),
              _healthDataCard(
                context,
                imgUrl: 'assets/images/pt-dashboard-04.png',
                label: 'P. Arterial',
                value:  user['enfermeria_actual'].isNotEmpty? '${user['enfermeria_actual'].last['presion_sistolica']}/${user['enfermeria_actual'].last['presion_diastolica']}':'No disponible'
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _healthDataCard(
    BuildContext context,
    {
      required String imgUrl,
      required String label,
      required String value
    }
  ) {

    final size = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
        color: secondaryColor,
        boxShadow: [
          BoxShadow(
              color: Colors.grey[350]!,
              offset: Offset(0.0, 2.0),
              spreadRadius: 1.0,
              blurRadius: 2.0)
        ],
      ),
      width: size.width * 12 / 100,
      height: MediaQuery.of(context).size.height * 17 / 100,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 5.0),
          child: Column( 
            
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image(
                image: AssetImage(imgUrl)
              ),
              Text(label),
              Text(value),
            ],
          ),
        ),
      ),
    );
  }

  Widget _datagraph(BuildContext context, Size size) {
    
    return FutureBuilder<List<charts.Series<Map<String, dynamic>, DateTime>>>(
      future: IMCController(context).createIMUserData(
        List<Map<String, dynamic>>.from(user['historico'])
      ),
      builder: (context, snapshot) {

        if(!snapshot.hasData) {
          return LoadingWidget(size: size);
        }

        if(snapshot.data![0].data.isEmpty) {
          return Container(
            width: size.width,
            padding: const EdgeInsets.all(defaultPadding),
            decoration: BoxDecoration(
              color: secondaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Text(
                  "IMC a través del tiempo",
                  style: TextStyle(
                    fontWeight: FontWeight.bold
                  ),
                ),
                Icon(Icons.info, size: 36,),
                Text("No hay registros de consultas"),
              ],
            ),
          );
        }

        return CustomTimeChart(
          title: "IMC a través del tiempo", 
          seriesList: snapshot.data!, 
          size: Size(size.width, size.height),
        );
      }
    );
  }

  Container _getHistoryWidget(Size size, List<Map<String, dynamic>> parentsHistory) {

    return Container(
      width: size.width,
      child: Column(
        children: [
          Text(
            "Antecedentes (${parentsHistory.length})",
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.white,
              fontWeight: FontWeight.bold
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey[300]!,
                width: 2.0
              ),
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              height: size.height,
              padding: const EdgeInsets.all(5.0),
              child: parentsHistory.isEmpty? 
              Center(child: Text("No hay datos")):
              SingleChildScrollView(
                child: Column(
                  children: List<Widget>.from(parentsHistory.map((hist){
                      return _getHistTile(hist);
                    }),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Container _getHistTile(Map<String, dynamic> hist) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(5.0),
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey[300]!,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              text: "Antecedente: ",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
              children: [
                TextSpan(text: hist['antecedente'], 
                  style: TextStyle(fontWeight: FontWeight.normal)
                )
              ]
            )
          ),
          Text.rich(
            TextSpan(
              text: "Descripción: ",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
              children: [
                TextSpan(text: hist['descripcion'], 
                  style: TextStyle(fontWeight: FontWeight.normal)
                )
              ]
            )
          ),
          Text.rich(
            TextSpan(
              text: "Parentezco: ",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
              children: [
                TextSpan(text: hist['nombre_parentesco'], 
                  style: TextStyle(fontWeight: FontWeight.normal)
                )
              ]
            )
          ),
        ],
      ),
    );
  }

  Widget _getMedicRecords(Size size) {

    final records = List<Map<String, dynamic>>.from(user['record_consultas']);

    if(records.isEmpty) {
      return Container(
        width: size.width,
        padding: const EdgeInsets.all(defaultPadding),
        decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Text(
              "Historial de consultas",
              style: TextStyle(
                fontWeight: FontWeight.bold
              ),
            ),
            Icon(Icons.info, size: 36,),
            Text("No hay registros de consultas"),
          ],
        ),
      );
    }

    const header = [
      "Motivo",
      "Fecha",
      "Enfermedad",
      "Observación",
      // "Enfermera",
      "Médico"
    ];

    return Container(
      width: size.width,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey[300]!,
          width: 2.0
        ),
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          width: size.width * 0.99,
          padding: const EdgeInsets.all(8.0),
          child: PaginatedDataTable(
            columnSpacing: 5.0,
            horizontalMargin: 5.0,
            columns: List<DataColumn>.from(header.map((e){
              return DataColumn(
                label: Text(
                  e
                )
              );
            })),
            showCheckboxColumn: false,
            header: Text("Historial de consultas"),
            // dataRowHeight: size.height * 0.2,
            source: _TalbeRow(records, size)
          ),
        ),
      ),
    );
  }

}

class _TalbeRow extends DataTableSource {

  final List<Map<String, dynamic>> userRecords;
  final Size size;

  _TalbeRow(this.userRecords, this.size);

  @override
  DataRow? getRow(int index) {

    if(index > userRecords.length - 1) return null;

    return DataRow.byIndex(
      onSelectChanged: (_){
        SmartDialog.show(
          widget: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Container(
              width: size.width / 2,
              height: size.height * 2,
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ListTile(
                      title: Text("Detalles de la consulta"),
                      trailing: IconButton(
                        icon: Icon(Icons.close),
                        onPressed: ()=>SmartDialog.dismiss(),
                      ),
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.info),
                      title: Text("Motivo"),
                      subtitle: Text(userRecords[index]['motivo_consulta']),
                    ),
                    ListTile(
                      leading: Icon(Icons.date_range),
                      title: Text("Fecha"),
                      subtitle: Text(userRecords[index]['fecha']),
                    ),
                    ListTile(
                      leading: Icon(Icons.local_hospital),
                      title: Text("Enfermera"),
                      subtitle: Text(userRecords[index]['nombre_enfermera']),
                    ),
                    ListTile(
                      leading: Icon(Icons.medical_services_rounded),
                      title: Text("Médico"),
                      subtitle: Text(userRecords[index]['nombre_medico']),
                    ),
                    ListTile(
                      leading: Icon(Icons.height),
                      title: Text("Talla"),
                      subtitle: Text('${userRecords[index]['talla']} cm'),
                    ),
                    ListTile(
                      leading: Icon(Icons.circle),
                      title: Text("Peso"),
                      subtitle: Text('${userRecords[index]['peso']} kg'),
                    ),
                    ListTile(
                      leading: Icon(Icons.healing),
                      title: Text("Presión arterial"),
                      subtitle: Text("${userRecords[index]['presion_sistolica']}/${userRecords[index]['presion_diastolica']}"),
                    ),
                    ListTile(
                      leading: Icon(Icons.thermostat),
                      title: Text("Temperatura"),
                      subtitle: Text("${userRecords[index]['temperatura']} °C"),
                    ),
                    ListTile(
                      leading: Icon(Icons.text_fields_outlined),
                      title: Text("Enfermedad"),
                      subtitle: Text(userRecords[index]['enfermedad_actual']),
                    ),
                    ListTile(
                      leading: Icon(Icons.album_outlined),
                      title: Text("Observación"),
                      subtitle: Text(
                        userRecords[index]['observacion'].isEmpty?
                          "Sin datos":
                          userRecords[index]['observacion'],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        );
      },
      index: index,
      cells: [
        DataCell(
          SizedBox(
            width: size.width*0.2,
            child: Text(
              userRecords[index]['motivo_consulta'],
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            )
          )
        ),
        DataCell(
          SizedBox(
            width: size.width*0.1,
            child: Text(
              userRecords[index]['fecha'],
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            )
          )
        ),
        DataCell(
          SizedBox(
            width: size.width*0.2,
            child: Text(
              userRecords[index]['enfermedad_actual'],
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            )
          )
        ),
        DataCell(
          SizedBox(
            width: size.width*0.15,
            child: Text(
              userRecords[index]['observacion'].isEmpty?
              "Sin datos":
              userRecords[index]['observacion'],
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            )
          )
        ),
        // DataCell(
        //   SizedBox(
        //     width: size.width*0.1,
        //     child: Text(
        //       userRecords[index]['nombre_enfermera'],
        //       maxLines: 2,
        //       overflow: TextOverflow.ellipsis,
        //     )
        //   )
        // ),
        DataCell(
          SizedBox(
            width: size.width*0.2,
            child: Text(
              userRecords[index]['nombre_medico'],
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            )
          )
        ),
      ]
    );
  }

  @override
  bool get isRowCountApproximate => false;
  @override
  int get rowCount => userRecords.length;
  @override
  int get selectedRowCount => 0; // para no complicarse la existencia :)


}
