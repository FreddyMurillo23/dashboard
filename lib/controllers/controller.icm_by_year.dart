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

  /// Create series list with multiple series
  Future<List<charts.Series<Map<String, dynamic>, String>>> createSampleData() async {
    late final Map<String, dynamic> data;

    try {
      data = await APIICMByYear().fetchICMPerYear();
    }catch(_) {
      SmartDialog.showToast("Error cargando datos, intente más tarde");
      return [];
    }

    List<charts.Series<Map<String, dynamic>, String>> response = [];

    int initialYear = int.parse(List<String>.from(data.keys).last) - 1;

    // outer level is the year (x-axis value) and inner level is the faculty (each x-axis values)
    response.addAll(
      List<charts.Series<Map<String, dynamic>, String>>.from(List<String>.generate(2, (index) {
        return (initialYear + index).toString();
      }).map((year) {
        print(List<Map<String, dynamic>>.from(data[year].forEach(print)));
        return charts.Series<Map<String, dynamic>, String>(
          id: '$year',
          domainFn: (Map<String, dynamic> data, _) => data['name'],
          measureFn: (Map<String, dynamic> data, _) => data['value'],
          data: List<Map<String, dynamic>>.from(data[year].map((Map<String, dynamic> faculty) {
            print(double.parse(faculty['promedio_imc']));
            return {
              'name': year + 'jr',
              'value': double.parse(faculty['promedio_imc'])
            };
          }))
        );
      }))  
      
    //   [
    //   charts.Series<Map<String, dynamic>, String>(
    //     id: '$initialYear',
    //     domainFn: (Map<String, dynamic> data, _) => (data['name'] ?? ""),
    //     measureFn: (Map<String, dynamic> data, _) => data['value'],
    //     data: List<Map<String, dynamic>>.from(data[initialYear.toString()].map((item) {
    //       return {
    //         'name': item['nombre_facultad'] ?? 'No name',
    //         'value': item['promedio_imc'] ?? 0.0
    //       };
    //     })),
    //   ),
    //   charts.Series<Map<String, dynamic>, String>(
    //     id: '${initialYear + 1}',
    //     domainFn: (Map<String, dynamic> data, _) => (data['name'] ?? ""),
    //     measureFn: (Map<String, dynamic> data, _) => data['value'],
    //      data: List<Map<String, dynamic>>.from(data[(initialYear + 1).toString()].map((item) {
    //       return {
    //         'name': item['nombre_facultad'] ?? 'No name',
    //         'value': item['promedio_imc'] ?? 0.0
    //       };
    //     })),
    //   ),
    // ]
    );

    return response;
  }

}