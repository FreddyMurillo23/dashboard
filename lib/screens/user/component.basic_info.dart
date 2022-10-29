import 'package:admin/components/LoadingWidget.dart';
import 'package:admin/constants.dart';
import 'package:flutter/material.dart';

class UserBasicInfo extends StatelessWidget {
  final Map<String, dynamic> user;
  final bool isLoading;
  UserBasicInfo({ 
    Key? key, required this.user,
    this.isLoading = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        isLoading? 
          LoadingWidget(size: Size(size.width * 0.18, size.height * 0.3))
          :_basicInfor(size, context),
        SizedBox(height: 10.0,),
        isLoading? 
          LoadingWidget(size: Size(size.width * 0.18, size.height * 0.3))
          :_history(
            context,
            Size(size.width * 0.18, size.height * 0.4),
          )
      ],
    );
  }

  
  // Widget _appointments(BuildContext context) {

  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
  //     child: Container(
  //       // padding: EdgeInsets.symmetric(horizontal: defaultPadding),
  //       decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(10), color: Colors.white),
  //     ),
  //   );
  // }

  Padding _basicInfor(Size size, BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Container(
          decoration: BoxDecoration(
            color: secondaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.width * 0.005,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  height: MediaQuery.of(context).size.height * 8 / 100,
                  width: MediaQuery.of(context).size.height * 8 / 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image(
                      image: NetworkImage(
                        'https://st4.depositphotos.com/9998432/24360/v/450/'
                        'depositphotos_243600192-stock-illustration-person-'
                        'gray-photo-placeholder-man.jpg'
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Container(
                  height: MediaQuery.of(context).size.height * 25 / 100,
                  // color: Colors.blue,
                  padding: EdgeInsets.all(defaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            '${user['datos_personales'][0]['apellidos']} '
                            '${user['datos_personales'][0]['nombres']}',
                            style: TextStyle(fontSize: 13),
                          ),
                          Text(
                            'Cedula: ${user['cedula']}',
                            style: TextStyle(fontSize: 13),
                          ),
                          Text(
                            'Ciudad: ${user['datos_personales'][0]['canton_residencia']}',
                            style: TextStyle(fontSize: 13),
                          ),
                        ],
                      ),
                      Divider(
                        color: Colors.grey,
                        thickness: 5,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('Telefono:'),
                                SizedBox(),
                                Text('${user['datos_personales'][0]['celular']}'),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Edad:'),
                                Text(
                                  "${DateTime.now().difference(DateTime.parse(user['datos_personales'][0]['fecha_nacimiento'])).inDays ~/ 365}"
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Grupo Sanguíneo:'),
                                Text('${user['datos_personales'][0]['tipo_sangre']}'),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
  }

  Widget _history(BuildContext context, Size size) {

    final hist = List<Map<String, dynamic>>.from(user['historico']);

    return Container(
      width: size.width,
      height: size.height,
      padding: const EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text("Historial", style: TextStyle(fontWeight: FontWeight.bold),),
          hist.isEmpty?
          Column(
            children: [
              Icon(Icons.info, size: 36,),
              Text("No hay registros de consultas"),
            ],
          ):
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...List<Widget>.from(hist.map((hist){
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        _userHistTile(hist),
                        Divider()
                      ],
                    );
                  })),
                ]
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _userHistTile(Map<String, dynamic> hist) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 3.0),
      // elevation: 2.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              text: 'Fecha: ',
              style: TextStyle(fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                  text: '${hist['fecha_consulta']}',
                  style: TextStyle(fontWeight: FontWeight.normal) 
                )
              ]
            )
          ),
          Text.rich(
            TextSpan(
              text: 'Motivo: ',
              style: TextStyle(fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                  text: '${hist['motivo_consulta']}',
                  style: TextStyle(fontWeight: FontWeight.normal) 
                )
              ]
            )
          ),
          Text.rich(
            TextSpan(
              text: 'Detalles: ',
              style: TextStyle(fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                  text: '${hist['enfermedad_actual']}',
                  style: TextStyle(fontWeight: FontWeight.normal) 
                )
              ]
            )
          ),
        ],
      ),
    );
  }
}