import 'dart:async';

import 'package:admin/screens/dashboard/components/left%20dashboard/api.medic_records.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

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



}