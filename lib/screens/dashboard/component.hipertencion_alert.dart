import 'package:admin/Repository/api.medic_records.dart';
import 'package:admin/components/LoadingWidget.dart';
import 'package:admin/constants.dart';
import 'package:admin/helpers/helper.ui.dart';
import 'package:admin/screens/user/secreen.hypertension.dart';
import 'package:flutter/material.dart';

class HypertensionAlert extends StatelessWidget {
  final Size size;
  const HypertensionAlert({ Key? key, required this.size }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: APIMedicRecords().fetchHypertensionAlertRecords(),
      builder: (context, snapshot) {

        if(!snapshot.hasData) {
          return LoadingWidget(size: size);
        } 

        final users = List<Map<String, dynamic>>.from(snapshot.data!["estudiantes"]);

        return Container(
          width: size.width,
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
                "Alertas de hipertensión",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: defaultPadding),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Container(
                  height: size.height,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List<Widget>.from(users.map((user){
                        return _hypertensionUserTile(context, user);
                      }))
                    ),
                  ),
                )
              ),
            ],
          ),
        );
      }
    );
  }

  Widget _hypertensionUserTile(BuildContext context, Map<String, dynamic> user) {

    final personalData = Map<String, dynamic>.from(user['datos_personales'][0]);

    return GestureDetector(
      onTap: ()=>UIHelper().showLateralSheet(
        context, 
        title: 'Usuario con peligro de hipertensión', 
        backgroundColor: Colors.green[900],
        foregroundColor: Colors.white,
        content: HypertensionUser(
          user: user
        )
      ),
      child: Container(
        margin: const EdgeInsets.all(5.0),
        width: double.infinity,
        padding: const EdgeInsets.all(defaultPadding),
        decoration: BoxDecoration(
          color: secondaryColor,
          border: Border.all(
            color: Colors.grey[350]!,
            width: 2.0
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text.rich(
              TextSpan(
                text: "Estudiante: ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(text: "${personalData['apellidos']} ${personalData['nombres']}", 
                    style: TextStyle(fontWeight: FontWeight.normal))
                ]
              )
            ),
            Text.rich(
              TextSpan(
                text: "Sexo: ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(text: "${personalData['genero'] == 'F'? 'Femenino':'Masculino'}", 
                    style: TextStyle(fontWeight: FontWeight.normal))
                ]
              )
            ),
            Text.rich(
              TextSpan(
                text: "Teléfono: ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(text: "${personalData['celular']}", 
                    style: TextStyle(fontWeight: FontWeight.normal))
                ]
              )
            ),
          ],
        ),
      ),
    );
  }
}