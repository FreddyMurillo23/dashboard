import 'package:admin/components/header/component.header.dart';
import 'package:admin/constants.dart';
import 'package:flutter/material.dart';

class UserScreen extends StatelessWidget {
  final Map<String, dynamic> user;
  final Function onPressed;

  const UserScreen({Key? key, required this.user, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Container(
              height: MediaQuery.of(context).size.height - (defaultPadding * 2),
              decoration: BoxDecoration(
                color: secondaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.red),
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
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.455,
                  decoration: BoxDecoration(color: secondaryColor),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Text('COMPLEXION FISICA:'),
                          Text('SOBREPESO')
                        ],
                      ),
                      Column(
                        children: [Text('SEXO:'), Text('MASCULINO')],
                      ),
                      Column(
                        children: [Text('DERIVACION:'), Text('INDEFINIDA')],
                      ),
                      Column(
                        children: [
                      Text('DISCAPACIDAD:'), Text('NO DEFINIDO')],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Padding(
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
          )
          // Text(user.toString()),
        ],
      ),
    );
  }
}
