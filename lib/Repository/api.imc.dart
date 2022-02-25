import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

/// This is a singleton class and will contains all the
/// necessary calls to fetch data into the left lateral
/// dashboard. All the filters calls should be placed here.
class APIIMCB {

  /// singleton class, it means all the time I'll
  /// be using the same instance.
  static APIIMCB? _instance;

  factory APIIMCB() {
    _instance ??= APIIMCB._();

    return _instance!;
  }

  /// Private constructor, the user is only able to create
  /// instances using the factory costructor
  APIIMCB._();

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
      decodedRespone['faculades_sobrepeso']
    );

    return response;
  }

  /// Returns a map of faculty data from last 10 years. The data contains
  /// "delgadez", "pesonormal", "sobrepeso", and the average IMC for every
  /// year of the faculty.
  Future<Map<String, dynamic>> fetchIMCPerFaculty() async {
    final isProduction = dotenv.env['IS_PRODUCTION'] == "true";

    late final rawResponse;

    // if it's not a production environment then I'll simulate the response
    if(!isProduction) {
      rawResponse = await rootBundle.loadString('data/estadisticasFacultades.json');
    }
    else {
      final url = Uri.parse("${dotenv.env['API_HOST']}salud/estadisticasFacultades");
      final fetchedData = await http.get(url);

      if(fetchedData.statusCode != 200) {
        throw new ErrorDescription('Hubo un problema cargando los datos. Recargue');
      }

      rawResponse = fetchedData.body;
    }
    
    final decodedRespone = Map<String, dynamic>.from(json.decode(rawResponse));

    return decodedRespone;
  }

  /// Returns the global IMC of all the faculties per year since 10 years ago.
  Future<Map<String, dynamic>> fetchIMCPerYear() async {
    final isProduction = dotenv.env['IS_PRODUCTION'] == "true";

    late final rawResponse;

    // if it's not a production environment then I'll simulate the response
    if(!isProduction) {
      rawResponse = await rootBundle.loadString('data/estadisticasUtmGeneral.json');
    }
    else {
      final url = Uri.parse("${dotenv.env['API_HOST']}salud/estadisticasUtmGeneral");
      final fetchedData = await http.get(url);

      if(fetchedData.statusCode != 200) {
        throw new ErrorDescription('Hubo un problema cargando los datos. Recargue');
      }

      rawResponse = fetchedData.body;
    }
    
    final decodedRespone = Map<String, dynamic>.from(json.decode(rawResponse));

    return decodedRespone;
  }

  Future<Map<String, dynamic>> fetchIMCPerGender() async {
    final isProduction = dotenv.env['IS_PRODUCTION'] == "true";

    late final rawResponse;

    // if it's not a production environment then I'll simulate the response
    if(!isProduction) {
      rawResponse = await rootBundle.loadString('data/estadisticasUtmGenero.json');
    }
    else {
      final url = Uri.parse("${dotenv.env['API_HOST']}salud/estadisticasUtmGenero");
      final fetchedData = await http.get(url);

      if(fetchedData.statusCode != 200) {
        throw new ErrorDescription('Hubo un problema cargando los datos. Recargue');
      }

      rawResponse = fetchedData.body;
    }
    
    final decodedRespone = Map<String, dynamic>.from(json.decode(rawResponse));

    return decodedRespone;
  }
}