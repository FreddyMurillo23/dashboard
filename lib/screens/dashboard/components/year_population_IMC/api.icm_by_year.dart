import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

/// This is a singleton class and will contains all the
/// necessary calls to fetch data into the left lateral
/// dashboard. All the filters calls should be placed here.
class APIICMByYear {

  /// singleton class, it means all the time I'll
  /// be using the same instance.
  static APIICMByYear? _instance;

  factory APIICMByYear() {
    _instance ??= APIICMByYear._();

    return _instance!;
  }

  /// Private constructor, the user is only able to create
  /// instances using the factory costructor
  APIICMByYear._();

  Future<List<Map<String, dynamic>>> fetchData() async {
    final isProduction = dotenv.env['IS_PRODUCTION'] == "true";

    late final rawResponse;

    // if it's not a production environment then I'll simulate the response
    if(!isProduction) {
      rawResponse = await rootBundle.loadString('data/Dat_nut_Facultades_general.json');
    }
    else {
      final url = Uri.parse("${dotenv.env['API_HOST']}salud/datos_nutricionales_facultades");
      final fetchedData = await http.get(url);

      if(fetchedData.statusCode != 200) {
        throw new ErrorDescription('Hubo un problema cargando los datos. Recargue');
      }

      rawResponse = fetchedData.body;
    }
    
    final decodedRespone = json.decode(rawResponse);

    // will store the real or simulated response
    final response = List<Map<String, dynamic>>.from(
      decodedRespone
    );

    return response;
  }
}