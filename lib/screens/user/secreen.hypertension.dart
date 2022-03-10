import 'package:admin/components/component.info_tile.dart';
import 'package:flutter/material.dart';

class HypertensionUser extends StatelessWidget {
  final Map<String, dynamic> user;
  const HypertensionUser({ Key? key, required this.user }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final parentsHistory = List<Map<String, dynamic>>.from(user['antecedentes']);
    final personalData = Map<String, dynamic>.from(user['datos_personales'][0]);
    final habits = List<Map<String, dynamic>>.from(user['habitos']);
    final size = MediaQuery.of(context).size;

    return Container(
      child: Row(
        children: [
          _getHistoryWidget(size, parentsHistory),
          SizedBox(width: 10.0,),
          _getHabitsWidget(size, habits),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  _personalInfoTile(personalData),
                  SizedBox(height: 10.0,),
                  Container(
                    height: size.height*0.6,
                    child: GridView(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                        childAspectRatio: 2
                      ),
                      children: [
                        InfoTile(
                          bgColor: Colors.blue,
                          fgColor: Colors.white,
                          icon: Icons.circle,
                          title: "IMC",
                          value: "${user['imc']}"
                        ),
                        InfoTile(
                          bgColor: Colors.red,
                          fgColor: Colors.white,
                          icon: Icons.warning,
                          title: "Alertas directas",
                          value: "${user['alertas_directas']}"
                        ),
                        InfoTile(
                          bgColor: Colors.red[800]!,
                          fgColor: Colors.white,
                          icon: Icons.dangerous_sharp,
                          title: "Alertas totales",
                          value: "${user['alertas_totales']}"
                        ),
                        InfoTile(
                          bgColor: Colors.indigo[900]!,
                          fgColor: Colors.white,
                          icon: Icons.medical_services,
                          title: "Diagnóstico",
                          value: "${user['diagnostico']}"
                        ),
                        InfoTile(
                          bgColor: Colors.orange[800]!,
                          fgColor: Colors.black,
                          icon: Icons.bubble_chart,
                          title: "Sistólica",
                          value: "${user['sistolica']}"
                        ),
                        InfoTile(
                          bgColor: Colors.orange[800]!,
                          fgColor: Colors.black,
                          icon: Icons.bubble_chart_outlined,
                          title: "Diastólica",
                          value: "${user['diastolica']}"
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }


  Container _personalInfoTile(Map<String, dynamic> personalData) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.amber[100],
        borderRadius: BorderRadius.circular(10.0)
      ),
      child: Row(
        children: [
          Icon(
            Icons.person,
            size: 60.0,
          ),
          SizedBox(width: 10.0,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                TextSpan(
                  text: "Paciente: ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: "${personalData['apellidos']} ${personalData['nombres']}", 
                      style: TextStyle(fontWeight: FontWeight.normal)
                    )
                  ]
                )
              ),
              Text.rich(
                TextSpan(
                  text: "Correo: ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: "${personalData['correo']}", 
                      style: TextStyle(fontWeight: FontWeight.normal)
                    )
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
                    TextSpan(
                      text: "${personalData['celular']}", 
                      style: TextStyle(fontWeight: FontWeight.normal)
                    )
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
                    TextSpan(
                      text: "${personalData['genero'] == 'F'?"Femenino":"Masculino"}", 
                      style: TextStyle(fontWeight: FontWeight.normal)
                    )
                  ]
                )
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container _getHabitsWidget(Size size, List<Map<String, dynamic>> habits) {
    return Container(
      width: size.width * 0.2,
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
              height: size.height * 0.8,
              padding: const EdgeInsets.all(5.0),
              child: SingleChildScrollView(
                child: Column(
                  children: List<Widget>.from(habits.map((hist){
                      return _getHabitTile(hist);
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
 
  Container _getHabitTile(Map<String, dynamic> hist) {
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
                TextSpan(text: hist['alcohol'] == '0'? 'No':'Sí', 
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
                TextSpan(text: hist['cigarrillo'] == '0'? 'No':'Sí',
                  style: TextStyle(fontWeight: FontWeight.normal)
                )
              ]
            )
          ),
        ],
      ),
    );
  }

  Container _getHistoryWidget(Size size, List<Map<String, dynamic>> parentsHistory) {
    return Container(
      width: size.width * 0.2,
      child: Column(
        children: [
          Text(
            "Antecedentes",
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
              height: size.height * 0.8,
              padding: const EdgeInsets.all(5.0),
              child: SingleChildScrollView(
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
                TextSpan(text: hist['parentezco'], 
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