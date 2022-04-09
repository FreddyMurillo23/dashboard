import 'package:admin/components/charts/chart.stacked_bar.dart';
import 'package:admin/controllers/controller.imc.dart';
import 'package:flutter/material.dart';

import 'package:charts_flutter/flutter.dart' as charts;

import '../../components/LoadingWidget.dart';

class GenderIMCComponent extends StatefulWidget {
  final Size size;
  const GenderIMCComponent({Key? key, required this.size}) : super(key: key);

  @override
  State<GenderIMCComponent> createState() => _GenderIMCComponentState();
}

class _GenderIMCComponentState extends State<GenderIMCComponent> {
  late int year; // this is the year to look for data
  late List<int> listOfYears; // years available for selection

  @override
  void initState() {
    year = DateTime.now().year;
    listOfYears =
        List<int>.generate(DateTime.now().year - 2015, (index) => 2016 + index);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _controller = IMCController(context);

    return FutureBuilder<List<charts.Series<Map<String, dynamic>, String>>>(
      future: _controller.createIMCPerGenderData(year),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
	switch(snapshot.connectionState) {
	  case ConnectionState.none:
	    return LoadingWidget(size: widget.size);
	  case ConnectionState.waiting:
	    return LoadingWidget(size: widget.size);
	  case ConnectionState.active:
	    return LoadingWidget(size: widget.size);
	  case ConnectionState.done: break;
	}
        if (!snapshot.hasData) {
	    return LoadingWidget(size: widget.size);
        }

        return CustomStackedBar(
          size: widget.size,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "IMC global por género",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Row(
                children: [
		  const Text("Seleccione un año: "),
                  DropdownButton<int>(
                      value: year,
                      onChanged: (value) {
                        year = value ?? year;
                        setState(() {});
                      },
                      items: List<DropdownMenuItem<int>>.from(
                          listOfYears.map((year) {
                        return DropdownMenuItem<int>(
                          value: year,
                          child: Text(year.toString()),
                        );
                      }))),
                ],
              )
            ],
          ),
          seriesList: snapshot.data!,
        );
      },
    );
  }
}
