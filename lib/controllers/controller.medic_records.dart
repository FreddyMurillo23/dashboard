import 'dart:async';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import '../Repository/api.medic_records.dart';

/// Singleton controller for the left lateral dashboard
/// named as medic records dashboard
class MedicRecordsController {

  
  /// singleton class, it means all the time I'll
  /// be using the same instance.
  static MedicRecordsController? _instance;

  factory MedicRecordsController(BuildContext context) {    
    _instance ??= MedicRecordsController._(context);

    return _instance!;
  }
  
  /// Private constructor, the user is only able to create
  /// instances using the factory costructor
  MedicRecordsController._(BuildContext context):_context=context;

  /// The context of the view
  BuildContext? _context;

  /// This could return a [List<Map<String, dynamic>>] or just a [Map<String, dynamic>]
  /// so you should validate the datatype in runtime in order to cast the stream data
  /// into a list or a map.
  final _medicRecordsOpt = StreamController.broadcast();

  /// The last data sinked in the stream. It's useful 'cause a stream can only be
  /// aware of events happening after it's subscribed, so if a stream is created
  /// after the sink is working, you should use this as the [initialData] parameter.
  /// 
  /// Since it's a list, it will stack all the options in order to create a menu, for
  /// example, if I fetch a list of options for the filter 'estudiantes', then I'll
  /// stack that data, but the previous one (the list of main filters) will still be
  /// able so if I wanna go back I can just remove the last item and get the last 
  /// element in the list.
  List<dynamic> medicRecordsDataStack = [];

  Stream get medicRecordsStrm => _medicRecordsOpt.stream;
  set medicRecordsSink(dynamic data) {

    /// If it's a map, then I just need to replace the second position
    /// of the list, because the first position is a List (list of filters).
    if(data is Map) {
      if(medicRecordsDataStack.length > 1) medicRecordsDataStack[1] = data;
      else medicRecordsDataStack.add(data);
    }
    else {
      // All the data should be cleaned up if the user tries to go back to
      // the main filter options
      if(medicRecordsDataStack.isNotEmpty) medicRecordsDataStack.clear();
      medicRecordsDataStack.add(data);
    }
    
    // Sinking always the last position of the stack because that's gonna be
    // the option the user will be.
    _medicRecordsOpt.sink.add(medicRecordsDataStack.last);
  }

  /// In the submenu created when you clik on any filter an arrow will be
  /// created at the top left, so when you click on it you should be
  /// redirected to the main filter page. That's what this method does.
  void goBackRecordPanel() {
    print(medicRecordsDataStack);
    final filters = medicRecordsDataStack[0];
    medicRecordsDataStack.clear();
    medicRecordsDataStack.add(filters);

    _medicRecordsOpt.sink.add(medicRecordsDataStack.last);
  }

  dispose() {
    _medicRecordsOpt.close();
  }

  Future<List<Map<String, dynamic>>> loadFilters() async {
    SmartDialog.showLoading();

    List<Map<String, dynamic>>? filters;
    
    try {
      filters = await APIMedicRecords().fetchFilters();
      medicRecordsSink = filters;
    }catch(e) {
      SmartDialog.showToast(e.toString());
    }finally {
      SmartDialog.dismiss();
    }
    
    medicRecordsSink = filters;
    return filters ?? [];
  }

  Future<Map<String, dynamic>> loadFilterValues(int id, String name) async {
    SmartDialog.showLoading();

    Map<String, dynamic>? filterOpts;
    
    try {
      filterOpts = await APIMedicRecords().fetchGroupValues(id);
      filterOpts.addAll({"name": name});
      medicRecordsSink = filterOpts;
    }catch(e) {
      SmartDialog.showToast(e.toString());
    }finally {
      SmartDialog.dismiss();
    }
    
    return filterOpts ?? <String, dynamic>{};
  }

  
  /// builds a dataset for the pie chart. [data] size needs to be equal to
  /// [colors] length if [data] is a List, otherwise, the length of [colors]
  /// should be 3.
  List<PieChartSectionData> buildDataset(dynamic data, List<Color> colors) {

    final List<PieChartSectionData> elements = [];

    // min max standarization
    double min = 0.0;
    double max = 100.0;
    double minSize = 15.0;
    double scaleFactor = 25.0;

    if(data is Map<String, dynamic>) {
      
      elements.add(PieChartSectionData(
        color: colors[0],
        value: data["valores_porcentuales"][0]['p_delgadez'],
        title: 'Delgadez',
        radius: minSize + scaleFactor * (data["valores_porcentuales"][0]['p_delgadez'] - min) / (max - min),
        showTitle: false,
      ));
      elements.add(PieChartSectionData(
        color: colors[1],
        value: data["valores_porcentuales"][0]['p_pesonormal'],
        title: 'Peso Normal',
        radius:  minSize + scaleFactor * (data["valores_porcentuales"][0]['p_pesonormal'] - min) / (max - min),
        showTitle: false,
      ));
      elements.add(PieChartSectionData(
        color: colors[2],
        value: data["valores_porcentuales"][0]['p_sobrepeso'],
        title: 'Sobrepeso',
        radius:  minSize + scaleFactor * (data["valores_porcentuales"][0]['p_sobrepeso'] - min) / (max - min),
        showTitle: false,
      ));
    }
    else if(data is List<Map<String, dynamic>>){ // if data is a list
      
      int idx = 0;

      data.forEach((item) {
        
        elements.add(PieChartSectionData(
          color: colors[idx++],
          value: 10.0,
          title: item['nombre'],
          showTitle: false,
          radius: minSize + scaleFactor * ((item["porcentaje"] ?? 1) - min) / (max - min),
        ));

      });
      
    }

    return elements;

  }

}