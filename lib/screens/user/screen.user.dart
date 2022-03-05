import 'package:admin/constants.dart';
import 'package:flutter/material.dart';

class UserScreen extends StatelessWidget {
  final Map<String, dynamic> user;
  final Function onPressed;
  final double w;

  const UserScreen(
      {Key? key, required this.user, required this.onPressed, required this.w})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [_user(context), _appointments(context)],
        ),
        Column(
          children: [
            _header(context),
            _healtData(context),
            _datagraph(context),
          ],
        ),
        _exit(),
        // Text(user.toString()),
      ],
    );
  }

  Widget _header(BuildContext context) {

    String complexion = "";
    double imc = user['enfermeria_actual'].isNotEmpty? user['enfermeria_actual'].last['imc']:-99.0;

    if(imc < 0) complexion = "DESCONOCIDA";
    else if(imc < 18.5) complexion = "DELGADEZ";
    else if(imc >= 25.0) complexion = "SOBREPESO";
    else complexion = "NORMAL";

    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        children: [
          Container(
            // padding: EdgeInsets.all(defaultPadding),
            width: w * 65 / 100,
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
          )
        ],
      ),
    );
  }

  Widget _exit() {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: InkWell(
        child: Icon(
          Icons.close,
          color: Colors.white,
        ),
        // color: Colors.white,
        onTap: () {
          onPressed();
        },
      ),
    );
  }

  Widget _user(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Container(
        width: w * 25 / 100,
        // height:
        //     MediaQuery.of(context).size.height / 2 - (defaultPadding * 2),
        decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Padding(
              // padding: EdgeInsets.symmetric(
              //     horizontal: MediaQuery.of(context).size.width * 0.03,
              //     vertical: MediaQuery.of(context).size.width * 0.005
              //     ),
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.width * 0.005,
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  // color: Colors.red
                ),
                height: MediaQuery.of(context).size.height * 15 / 100,
                width: MediaQuery.of(context).size.height * 15 / 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image(
                    image: NetworkImage(
                        'https://st4.depositphotos.com/9998432/24360/v/450/depositphotos_243600192-stock-illustration-person-gray-photo-placeholder-man.jpg'),
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
                          'Ciudad: xxxxxx',
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
                              Text('XXXXXXXXX'),
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
                              Text('Grupo Sanguineo:'),
                              Text('XXA+'),
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

  Widget _healtData(BuildContext context) {
    return Container(
      width: w * 65 / 100,
      height: MediaQuery.of(context).size.height * 20 / 100,
      // padding: EdgeInsets.symmetric(horizontal: defaultPadding),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.white),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: defaultPadding),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
              label: 'Presion Sanguinea',
              value: 'XXX202/90 mg/dl'
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
      width: w * 12 / 100,
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
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Container(
        width: w * 65 / 100,
        height: MediaQuery.of(context).size.height * 68 / 100,
        // padding: EdgeInsets.symmetric(horizontal: defaultPadding),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.white),
      ),
    );
  }

  Widget _appointments(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
      child: Container(
        width: w * 25 / 100,

        height: MediaQuery.of(context).size.height * 50 / 100,
        // padding: EdgeInsets.symmetric(horizontal: defaultPadding),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.white),
      ),
    );
  }
}
