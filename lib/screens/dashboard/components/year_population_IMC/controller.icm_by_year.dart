import 'package:admin/screens/dashboard/components/year_population_IMC/api.icm_by_year.dart';
import 'package:admin/screens/dashboard/dashboard_screen.dart';
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
    late final data;

    try {
      data = await APIICMByYear().fetchData();
    }catch(_) {
      SmartDialog.showToast("Error cargando datos, intente más tarde");
    }

    List<charts.Series<Map<String, dynamic>, String>> response = [];

    // storing all the features data
    final List<Map<String, dynamic>> delgadez = [];
    final List<Map<String, dynamic>> pesonormal = [];
    final List<Map<String, dynamic>> sobrepeso = [];

    int initialYear = 2010;

    data.forEach((element) {


      delgadez.add({
        'name': "$initialYear", // element["nombre_facultad"],
        'value': element['valores_netos'][0]['delgadez']
      });
      pesonormal.add({
        'name': "$initialYear", // element["nombre_facultad"],
        'value': element['valores_netos'][0]['pesonormal']
      });
      sobrepeso.add({
        'name': "${initialYear++}", // element["nombre_facultad"],
        'value': element['valores_netos'][0]['sobrepeso']
      });
    });

    response.addAll([
      charts.Series<Map<String, dynamic>, String>(
        id: 'Delgadez',
        domainFn: (Map<String, dynamic> data, _) => (data['name'] ?? ""),
        measureFn: (Map<String, dynamic> data, _) => data['value'],
        data: delgadez,
      ),
      charts.Series<Map<String, dynamic>, String>(
        id: 'Sobrepeso',
        domainFn: (Map<String, dynamic> data, _) => (data['name'] ?? ""),
        measureFn: (Map<String, dynamic> data, _) => data['value'],
        data: sobrepeso,
      ),
      charts.Series<Map<String, dynamic>, String>(
        id: 'Peso normal',
        domainFn: (Map<String, dynamic> data, _) => (data['name'] ?? ""),
        measureFn: (Map<String, dynamic> data, _) => data['value'],
        data: pesonormal,
      ),
    ]);

    return response;
  }

}