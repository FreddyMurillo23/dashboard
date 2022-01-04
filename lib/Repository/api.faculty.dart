import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

/// This is a singleton class and will contains all the
/// necessary calls to fetch data into the left lateral
/// dashboard. All the filters calls should be placed here.
class APIFaculty {

  /// singleton class, it means all the time I'll
  /// be using the same instance.
  static APIFaculty? _instance;

  factory APIFaculty() {
    _instance ??= APIFaculty._();

    return _instance!;
  }

  List<Map<String, dynamic>> _facultyList = [];

  /// Private constructor, the user is only able to create
  /// instances using the factory costructor
  APIFaculty._();

  Future<List<Map<String, dynamic>>> fetchData() async {

    // If there is already data prefetched then just return it
    if(_facultyList.isNotEmpty) return _facultyList;

    final isProduction = dotenv.env['IS_PRODUCTION'] == "true";

    late final rawResponse;

    // if it's not a production environment then I'll simulate the response
    if(!isProduction) {
      rawResponse = await rootBundle.loadString('data/Listar_Facultades.json');
    }
    else {
      final url = Uri.parse("${dotenv.env['API_HOST']}general/facultades");
      final fetchedData = await http.get(url);

      if(fetchedData.statusCode != 200) {
        throw new ErrorDescription('Hubo un problema cargando los datos. Recargue');
      }

      rawResponse = fetchedData.body;
    }
    
    final decodedRespone = json.decode(rawResponse);

    // will store the real or simulated response
    _facultyList.clear();
    _facultyList.addAll(List<Map<String, dynamic>>.from( decodedRespone ));

    return _facultyList;
  }
}