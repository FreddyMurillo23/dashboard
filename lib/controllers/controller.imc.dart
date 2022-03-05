import 'package:admin/Repository/api.imc.dart';
import 'package:admin/helpers/helper.colors.dart';
import 'package:admin/helpers/helper.ui.dart';
import 'package:flutter/material.dart';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class IMCController {

  
  /// Private constructor, the user is only able to create
  /// instances using the factory costructor
  IMCController(BuildContext context):context=context;

  /// The context of the view
  BuildContext? context;

  int? lowerIMCByYearBound;
  int? upperIMCByYearBound;

  /// Create series list with multiple series
  Future<List<charts.Series<Map<String, dynamic>, String>>> createIMCPerFacultyData(int yr1, int yr2) async {
    
    print("Fetching new data for years $yr1 $yr2");
    
    late final Map<String, dynamic> data;

    try {
      data = await APIIMCB().fetchIMCPerFaculty(yr1, yr2);
    }catch(_) {
      SmartDialog.showToast("Error cargando datos, intente más tarde");
      return [];
    }

    List<charts.Series<Map<String, dynamic>, String>> response = [];

    final years = [
      int.parse(List<String>.from(data.keys).first),
      int.parse(List<String>.from(data.keys).last)
    ];

    // getting all faculty names
    final facultyNames = List<String>.from((data[years.first.toString()] as List).map((e) {
      return e['nombre_facultad'];
    }));

    // outer level is the faculty (each x-axis values) and year (x-axis value) is the inner level
    response.addAll(
      List<charts.Series<Map<String, dynamic>, String>>.from(
        facultyNames.map((facultyName){
          return charts.Series<Map<String, dynamic>, String>(
            id: facultyName,
            domainFn: (data, _) => data['name'],
            measureFn: (data, _) => data['value'],
            data: List<Map<String, dynamic>>.from(
              List.generate(2, (index) {
                final faculty = (data['${years[index]}'] as List).firstWhere((element) {
                  return element['nombre_facultad'] == facultyName;
                });

                return {
                  'name': (years[index]).toString(),
                  'value': faculty['promedio_imc']
                };
              })
            )
          );
        })
      )
    );

    return response;
  }

  /// generate line chart data
  Future<List<charts.Series<Map<String, dynamic>, int>>> createIMCPerYearData() async {
    late final Map<String, dynamic> data;

    try {
      data = await APIIMCB().fetchIMCPerYear();
    }catch(_) {
      SmartDialog.showToast("Error cargando datos, intente más tarde");
      return [];
    }

    List<charts.Series<Map<String, dynamic>, int>> response = [];

    // outer level is the faculty (each x-axis values) and year (x-axis value) is the inner level
    response.addAll(
      [
        charts.Series<Map<String, dynamic>, int>(
          id: 'Promedio',
          domainFn: (data, _) => int.parse(data['name']),
          measureFn: (data, _) => data['value'],
          data: List<Map<String, dynamic>>.from(
            data.keys.map((year){
              return {
                'name': year,
                'value': data['$year'][0]['promedio_imc']
              };
            })
          )
        ),
        charts.Series<Map<String, dynamic>, int>(
          id: 'Delgadez',
          domainFn: (data, _) => int.parse(data['name']),
          measureFn: (data, _) => data['value'],
          dashPatternFn: (data, _) => [2, 2],
          data: List<Map<String, dynamic>>.from(
            data.keys.map((year){
              return {
                'name': year,
                'value': data['$year'][0]['valores_porcentuales'][0]['p_delgadez']
              };
            })
          )
        ),
        charts.Series<Map<String, dynamic>, int>(
          id: 'Normal',
          domainFn: (data, _) => int.parse(data['name']),
          measureFn: (data, _) => data['value'],
          dashPatternFn: (data, _) => [1, 1],
          data: List<Map<String, dynamic>>.from(
            data.keys.map((year){
              return {
                'name': year,
                'value': data['$year'][0]['valores_porcentuales'][0]['p_pesonormal']
              };
            })
          )
        ),
        charts.Series<Map<String, dynamic>, int>(
          id: 'Sobrepeso',
          domainFn: (data, _) => int.parse(data['name']),
          measureFn: (data, _) => data['value'],
          dashPatternFn: (data, _) => [2, 2],
          data: List<Map<String, dynamic>>.from(
            data.keys.map((year){
              return {
                'name': year,
                'value': data['$year'][0]['valores_porcentuales'][0]['p_sobrepeso']
              };
            })
          )
        )
      ]
    );

    lowerIMCByYearBound = int.parse(data.keys.first);
    upperIMCByYearBound = int.parse(data.keys.last);

    return response;
  }

  /// This will create a dataset to be used in [CustomStackedBar] component. If you don't
  /// define any [customData] then new data will be fetched (global records of UTM).
  Future<List<charts.Series<Map<String, dynamic>, String>>> createIMCPerGenderData([
    Map<String, dynamic>? customData
  ]) async {
    late final Map<String, dynamic> data;

    try {
      data = customData ?? await APIIMCB().fetchIMCPerGender();
    }catch(_) {
      SmartDialog.showToast("Error cargando datos, intente más tarde");
      return [];
    }

    List<charts.Series<Map<String, dynamic>, String>> response = [];
    // final colorList = ColorHelpers().generateColors(3);

    response.addAll(
      [
        charts.Series<Map<String, dynamic>, String>(
          id: 'Delgadéz',
          domainFn: (data, _) => data['name'],
          measureFn: (data, _) => data['value'],
          colorFn: (_, __)=> charts.MaterialPalette.blue.shadeDefault.lighter,
          data: [
            {
                'name': 'Masculino',
                'value': data['valores_netos_masculinos'][0]['delgadez_masculino']
            },
            {
                'name': 'Femenino',
                'value': data['valores_netos_femeninos'][0]['delgadez_femenino']
            },
          ]
        ),
        charts.Series<Map<String, dynamic>, String>(
          id: 'Peson normal',
          domainFn: (data, _) => data['name'],
          measureFn: (data, _) => data['value'],
          colorFn: (_, __)=> charts.MaterialPalette.blue.shadeDefault,
          data: [
            {
                'name': 'Masculino',
                'value': data['valores_netos_masculinos'][0]['pesonormal_masculino']
            },
            {
                'name': 'Femenino',
                'value': data['valores_netos_femeninos'][0]['pesonormal_femenino']
            },
          ]
        ),
        charts.Series<Map<String, dynamic>, String>(
          id: 'Sobrepeso',
          domainFn: (data, _) => data['name'],
          measureFn: (data, _) => data['value'],
          colorFn: (_, __)=> charts.MaterialPalette.blue.shadeDefault.darker,
          data: [
            {
                'name': 'Masculino',
                'value': data['valores_netos_masculinos'][0]['sobrepeso_masculino']
            },
            {
                'name': 'Femenino',
                'value': data['valores_netos_femeninos'][0]['sobrepeso_femenino']
            },
          ]
        ),
      ]
    );

    return response;

  }
}