import 'package:admin/components/header/component.header.dart';
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
                  children: [Text('COMPLEXION FISICA:'), Text('SOBREPESO')],
                ),
                Column(
                  children: [Text('SEXO:'), Text('MASCULINO')],
                ),
                Column(
                  children: [Text('DERIVACION:'), Text('INDEFINIDA')],
                ),
                Column(
                  children: [Text('DISCAPACIDAD:'), Text('NO DEFINIDO')],
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
                          'Freddy John Murillo Mendoza',
                          style: TextStyle(fontSize: 13),
                        ),
                        Text(
                          'Cedula: 1317054888',
                          style: TextStyle(fontSize: 13),
                        ),
                        Text(
                          'Ciudad: Manta',
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
                              Text('0956325896'),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Edad:'),
                              Text('23'),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Grupo Sanguineo:'),
                              Text('A+'),
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
            Container(
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
                  padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * 0.02),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image(
                          image:
                              AssetImage('assets/images/pt-dashboard-01.png')),
                      Text('Temperatura'),
                      Text('18 °C'),
                    ],
                  ),
                ),
              ),
            ),
            // Divider(),
            Container(
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
                  padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * 0.02),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image(
                          image:
                              AssetImage('assets/images/pt-dashboard-02.png')),
                      Text('Ritmo Cardiaco'),
                      Text('12bpm'),
                    ],
                  ),
                ),
              ),
            ),
            // Divider(),
            Container(
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
                  padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * 0.02),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image(
                          image:
                              AssetImage('assets/images/pt-dashboard-03.png')),
                      Text('IMC'),
                      Text('90'),
                    ],
                  ),
                ),
              ),
            ),
            // Divider(),
            Container(
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
                  padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * 0.02),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image(
                          image:
                              AssetImage('assets/images/pt-dashboard-04.png')),
                      Text('Presion Sanguinea'),
                      Text('202/90 mg/dl'),
                    ],
                  ),
                ),
              ),
            ),
          ],
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
