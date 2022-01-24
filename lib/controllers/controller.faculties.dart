import 'package:admin/Repository/api.faculty.dart';

class FacultiesController {

  final _api = APIFaculty();

  Future<List<Map<String, dynamic>>> fetchFaculties() async {
    return await _api.fetchData();
  }
}