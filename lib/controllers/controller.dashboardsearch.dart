import 'package:admin/Repository/api.user.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

/// This controller is only with the responsability of controll the 
/// behavior of the search bar in the next screens:
///   1. Main dashboard screen
/// And cannot be a singleton since every screen could try to search
/// different data and you probably wanna keep the state of every screen.
class DashBoardSearchController {

  final _searchAPI = APIUser();

  /// Searchs an user based on cedula, full name, faculty or school but
  /// you can just pass some of the next parameters. If you use [cedula]
  /// then all the other fields are gonna be ignored.
  Future<List<Map<String, dynamic>>> searchUser({
    String? cedula, String? fullName, 
    String? facultyId, String? schoolId
  }) async {

    if(cedula != null && cedula.trim().isNotEmpty) {
      return await _searchUserByCedula(cedula.trim());
    }
    else if(fullName != null){
      return await _searchUserByName(fullName);
    }

    return [];
  }

  /// Well, it doesn't need any description I think...
  Future<List<Map<String, dynamic>>> _searchUserByCedula(String cedula) async {
    try {
      return await _searchAPI.searchUserByCedula(cedula);
    }catch(_) {
      SmartDialog.showToast("No se pudo encontrar al usuario");
      return [];
    }
  }

  /// Well, it doesn't need any description I think...
  Future<List<Map<String, dynamic>>> _searchUserByName(String name) async {
    try {
      return await _searchAPI.searchUserByName(name);
    }catch(_) {
      SmartDialog.showToast("No se pudo encontrar al usuario");
      return [];
    }
  }

}