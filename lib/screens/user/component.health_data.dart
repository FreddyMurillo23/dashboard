import 'package:admin/components/LoadingWidget.dart';
import 'package:admin/components/charts/chart.timeseries.dart';
import 'package:admin/components/component.info_tile.dart';
import 'package:admin/constants.dart';
import 'package:admin/controllers/controller.imc.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

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

    return Column(
      children: [
        isLoading? 
          LoadingWidget(size: Size(
            size.width * 0.55, size.height * 0.10
          )):
          _header(context, Size(
            size.width * 0.55, size.height * 0.12
          )),
        SizedBox(height: 10.0,),
        isLoading? 
          LoadingWidget(size: Size(
            size.width * 0.55, size.height * 0.2 
          )):
          _healtData(context, Size(
            size.width * 0.55, size.height * 0.2 
          )),
        SizedBox(height: 10.0,),
        isLoading?
          LoadingWidget(size: Size(size.width * 0.55, size.height *0.3))
          :_datagraph(context, Size(
            size.width * 0.55, size.height *0.45
          )),
      ],
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

}

