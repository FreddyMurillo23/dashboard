import 'package:admin/components/charts/chart.timeseries.dart';
import 'package:admin/constants.dart';
import 'package:admin/controllers/controller.imc.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class UserHealthData extends StatelessWidget {
  final Map<String, dynamic> user;
  const UserHealthData({ Key? key, required this.user }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _header(context),
        _healtData(context),
        SizedBox(height: 10.0,),
        _datagraph(context),
      ],
    );
  }

  Widget _header(BuildContext context) {

    final size = MediaQuery.of(context).size;
    String complexion = "";
    double imc = user['enfermeria_actual'].isNotEmpty? user['enfermeria_actual'].last['imc']:-99.0;

    if(imc < 0) complexion = "DESCONOCIDA";
    else if(imc < 18.5) complexion = "DELGADEZ";
    else if(imc >= 25.0) complexion = "SOBREPESO";
    else complexion = "NORMAL";

    return Container(
      margin: const EdgeInsets.symmetric(vertical: defaultPadding),
      padding: const EdgeInsets.all(defaultPadding),
      width: size.width * 55 / 100,
      decoration: BoxDecoration(
          color: secondaryColor, borderRadius: BorderRadius.circular(10)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Text('COMPLEXION FISICA:'), 
              Text('$complexion')
            ],
          ),
          Column(
            children: [
              Text('SEXO:'), 
              Text(user['datos_personales'][0]['genero'] == 'M'? 'MASCULINO':'FEMENINO')
            ],
          ),
          Column(
            children: [Text('DERIVACION:'), Text('XXX')],
          ),
          Column(
            children: [
              Text('DISCAPACIDAD:'), 
              Text(user['datos_personales'][0]['discapacidad'] ?? 'NINGUNA')
            ],
          )
        ],
      ),
    );
  }

  
  Widget _healtData(BuildContext context) {
    
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width * 55 / 100,
      // padding: EdgeInsets.symmetric(horizontal: defaultPadding),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.white),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: defaultPadding),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _healthDataCard(
              context,
              imgUrl: 'assets/images/pt-dashboard-01.png',
              label: 'Temperatura',
              value: user['enfermeria_actual'].isNotEmpty? '${user['enfermeria_actual'].last['temperatura']}':'NA'
            ),
            _healthDataCard(
              context,
              imgUrl: 'assets/images/pt-dashboard-02.png',
              label: 'Ritmo cardiaco',
              value: 'XXX'
            ),
            _healthDataCard(
              context,
              imgUrl: 'assets/images/pt-dashboard-03.png',
              label: 'IMC',
              value: user['enfermeria_actual'].isNotEmpty? '${user['enfermeria_actual'].last['imc']}':'NA'
            ),
            _healthDataCard(
              context,
              imgUrl: 'assets/images/pt-dashboard-04.png',
              label: 'P. Sanguinea',
              value: 'XXX2'
            )
          ],
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

  Widget _datagraph(BuildContext context) {
    
    final size = MediaQuery.of(context).size;

    return FutureBuilder<List<charts.Series<Map<String, dynamic>, DateTime>>>(
          future: IMCController(context).createIMUserData(
            List<Map<String, dynamic>>.from(user['historico'])
          ),
          builder: (context, snapshot) {

            if(!snapshot.hasData) {
              return Center(child: CircularProgressIndicator(),);
            }

            if(snapshot.data![0].data.isEmpty) {
              return Container(
                width: size.width * 0.55,
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

            print(snapshot.data![0].data);

            return CustomTimeChart(
              title: "IMC a través del tiempo", 
              seriesList: snapshot.data!, 
              size: Size(size.width*0.55, size.height*0.45),
            );
          }
        );
  }

}

