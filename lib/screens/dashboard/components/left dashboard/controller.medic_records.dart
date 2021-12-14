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

  Future<List<Map<String, dynamic>>> loadFilters() async {
    SmartDialog.showLoading();

    List<Map<String, dynamic>>? filters;
    
    try {
      filters = await APIMedicRecords().fetchFilters();
    }catch(e) {
      SmartDialog.showToast(e.toString());
    }finally {
      SmartDialog.dismiss();
    }

    return filters ?? [];
  }

}