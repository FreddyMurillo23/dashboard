import 'package:admin/Repository/api.faculty.dart';
import 'package:admin/components/charts/chart.pie.dart';
import 'package:admin/components/storage_info_card.dart';
import 'package:admin/controllers/controller.faculties.dart';
import 'package:flutter/material.dart';

class FacultyDetail extends StatefulWidget {
  final Map<String, dynamic> faculty;
  FacultyDetail({Key? key, required this.faculty}) : super(key: key);

  @override
  _FacultyDetailState createState() => _FacultyDetailState();
}

class _FacultyDetailState extends State<FacultyDetail> {
  late int value;

  @override
  void initState() {
    value = int.parse(widget.faculty['escuelas'][0]['id'].toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        _header(),
        FutureBuilder(
          future: APIFaculty().fetchSchoolData(widget.faculty['id'], value),
          builder: (BuildContext context,
              AsyncSnapshot<Map<String, dynamic>> snapshot) {
            if (!snapshot.hasData) {
              print(
                  "Showing results for faculty ${widget.faculty['id']} and school $value");
              return Center(child: CircularProgressIndicator());
            }

            final data = snapshot.data!;
            final colors = [
              Colors.blue[400]!,
              Colors.blue[300]!,
              Colors.blue[200]!
            ];

            return Container(
              child: Row(
                children: [
                  Expanded(flex: 25, child: _getPieIMCWidget(data, colors)),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  /// Shows a pie chart with tiles as a legend
  Widget _getPieIMCWidget(Map<String, dynamic> data, List<Color> colors) {
    final delgadez = data["valores_netos"][0]["delgadez"];
    final pesonormal = data["valores_netos"][0]["pesonormal"];
    final sobrepeso = data["valores_netos"][0]["sobrepeso"];

    // It's necessary to avoid layout errors
    if (delgadez + pesonormal + sobrepeso == 0) {
      return Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.info_outline,
            size: 50,
          ),
          Text(
            "No hay datos",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      );
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Center(
              child: CustomPieChart(
            paiChartSelectionDatas:
                FacultiesController().buildSchoolImcDataset(data, colors),
          )),
          StorageInfoCard(
            title: "Delgadez",
            numOfFiles: delgadez,
            amountOfFiles: '${data["valores_porcentuales"][0]["p_delgadez"]}',
            onPress: () {},
            svgSrc: Icon(Icons.person, color: colors[0]),
          ),
          StorageInfoCard(
            title: "Peso normal",
            numOfFiles: pesonormal,
            amountOfFiles: '${data["valores_porcentuales"][0]["p_pesonormal"]}',
            onPress: () {},
            svgSrc: Icon(Icons.person, color: colors[1]),
          ),
          StorageInfoCard(
            title: "Sobrepeso",
            numOfFiles: sobrepeso,
            amountOfFiles: '${data["valores_porcentuales"][0]["p_sobrepeso"]}',
            onPress: () {},
            svgSrc: Icon(Icons.person, color: colors[2]),
          ),
        ],
      ),
    );
  }

  Row _header() {
    return Row(
      children: [
        Text("Seleccione escuela:\t", style: TextStyle(fontSize: 18.0)),
        DropdownButton<int>(
          itemHeight: null, // it's necessary to avoid overflow on small screens
          alignment: Alignment.centerLeft,
          onChanged: (item) {
            setState(() {
              value = item ?? value;
            });
          },
          value: value,
          items: List<DropdownMenuItem<int>>.from(
              List<Map<String, dynamic>>.from(widget.faculty['escuelas'])
                  .map((school) {
            return DropdownMenuItem<int>(
                value: int.parse(school['id'].toString()),
                child: Text(school["nombre"]));
          })),
        ),
      ],
    );
  }
}
