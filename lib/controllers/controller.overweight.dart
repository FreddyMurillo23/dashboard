import 'package:admin/Repository/api.imc.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class OverweightController {

  
  /// singleton class, it means all the time I'll
  /// be using the same instance.
  static OverweightController? _instance;

  factory OverweightController(BuildContext context) {    
    _instance ??= OverweightController._(context);

    return _instance!;
  }
  
  
  /// Private constructor, the user is only able to create
  /// instances using the factory costructor
  OverweightController._(BuildContext context):_context=context;

  /// The context of the view
  BuildContext? _context;

  /// Create series list with multiple series
  Future<List<Map<String, dynamic>>> createSampleData() async {
    late final data;

    try {
      data = await APIIMCB().fetchData();
    }catch(_) {
      SmartDialog.showToast("Error cargando datos, intente más tarde");
      return [];
    }

    return data;
  }

   
  /// builds a dataset for the pie chart. [data] size needs to be equal to
  /// [colors] length if [data] is a List, otherwise, the length of [colors]
  /// should be 3.
  List<PieChartSectionData> buildDataset(List<Map<String, dynamic>> data, List<Color> colors) {

    final List<PieChartSectionData> elements = [];

    // min max standarization
    double min = 0.0;
    double max = 100.0;
    double minSize = 15.0;
    double scaleFactor = 15.0;

    int idx = 0;

    data.forEach((item) {
      
      elements.add(PieChartSectionData(
        color: colors[idx++],
        value: item['porcentaje_sobrepeso'],
        title: item["facultad"],
        showTitle: false,
        radius: minSize + scaleFactor * ((item["porcentaje_sobrepeso"] ?? 1) - min) / (max - min),
      ));
    });

    return elements;

  }


}