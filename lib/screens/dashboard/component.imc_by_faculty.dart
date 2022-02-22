/// Bar chart with example of a legend with customized position, justification,
/// desired max rows, and padding. These options are shown as an example of how
/// to use the customizations, they do not necessary have to be used together in
/// this way. Choosing [end] as the position does not require the justification
/// to also be [endDrawArea].
import 'package:admin/components/charts/chart.multibar.dart';
import 'package:admin/controllers/controller.imc.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

/// Example that shows how to build a series legend that shows measure values
/// when a datum is selected.
///
/// Also shows the option to provide a custom measure formatter.
class IMCByFacultyComponent extends StatefulWidget {

  final Size size;  

  IMCByFacultyComponent({required this.size});

  @override
  State<IMCByFacultyComponent> createState() => _IMCByFacultyComponentState();
}

class _IMCByFacultyComponentState extends State<IMCByFacultyComponent> {
  late IMCController _controller;
  late int year1;
  late int year2;

  @override
  void initState() {
    super.initState();

    year1 = DateTime.now().year - 1;
    year2 = DateTime.now().year;
  }

  @override
  Widget build(BuildContext context) {
    
    _controller = IMCController(context);

    return FutureBuilder<List<charts.Series<Map<String, dynamic>, String>>>(
      future: _controller.createIMCPerFacultyData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        
        if(!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator(),);
        }

        return CustomMultibarChart(
          size: widget.size,
          title: Row(
            children: [
              Text(
                "IMC por facultad",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Expanded(child: Container()),
              Text("Comparando "),
              DropdownButton<int>(
                hint: Text("Seleccione primer año"),
                value: year1,
                onChanged: (x) => setState(() {
                  year1 = x!;
                }),
                items:
                  List.generate(5, (index) {
                    final year = DateTime.now().year - 4 + index;

                    return DropdownMenuItem<int>(
                      value: year,
                      child: Text("Año $year"),
                    );
                  }),
              ),
              Text(" con el año "),
              DropdownButton<int>(
                value: year2,
                hint: Text("Seleccione segundo año"),
                onChanged: (x)=>setState(() {
                  year2 = x!;
                }),
                items: 
                  List.generate(5, (index) {
                    final year = DateTime.now().year - 4 + index;

                    return DropdownMenuItem<int>(
                      value: year,
                      child: Text("Año $year"),
                    );
                  }),
              ),
            ],
          ),
          seriesList: snapshot.data!,
        );
      },
    );
  }
}

