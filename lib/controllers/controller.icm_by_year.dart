import 'package:admin/Repository/api.icm_by_year.dart';
import 'package:flutter/material.dart';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class ICMByYearController {

  
  /// singleton class, it means all the time I'll
  /// be using the same instance.
  static ICMByYearController? _instance;

  factory ICMByYearController(BuildContext context) {    
    _instance ??= ICMByYearController._(context);

    return _instance!;
  }
  
  
  /// Private constructor, the user is only able to create
  /// instances using the factory costructor
  ICMByYearController._(BuildContext context):_context=context;

  /// The context of the view
  BuildContext? _context;

  int? lowerICMByYearBound;
  int? upperICMByYearBound;

  /// Create series list with multiple series
  Future<List<charts.Series<Map<String, dynamic>, String>>> createICMPerFacultyData() async {
    late final Map<String, dynamic> data;

    try {
      data = await APIICMByYear().fetchICMPerFaculty();
    }catch(_) {
      SmartDialog.showToast("Error cargando datos, intente más tarde");
      return [];
    }

    List<charts.Series<Map<String, dynamic>, String>> response = [];

    int initialYear = int.parse(List<String>.from(data.keys).last) - 1;

    // getting all faculty names
    final facultyNames = List<String>.from((data[initialYear.toString()] as List).map((e) => e['nombre_facultad']));

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
                final faculty = (data['${initialYear + index}'] as List).firstWhere((element) {
                  return element['nombre_facultad'] == facultyName;
                });

                return {
                  'name': (initialYear + index).toString(),
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
  Future<List<charts.Series<Map<String, dynamic>, int>>> createICMPerYearData() async {
    late final Map<String, dynamic> data;

    try {
      data = await APIICMByYear().fetchICMPerYear();
    }catch(_) {
      SmartDialog.showToast("Error cargando datos, intente más tarde");
      return [];
    }

    List<charts.Series<Map<String, dynamic>, int>> response = [];

    // outer level is the faculty (each x-axis values) and year (x-axis value) is the inner level
    response.addAll(
      [
        charts.Series<Map<String, dynamic>, int>(
          id: 'ICM global por año',
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
        )
      ]
    );

    lowerICMByYearBound = int.parse(data.keys.first);
    upperICMByYearBound = int.parse(data.keys.last);

    return response;
  }
}