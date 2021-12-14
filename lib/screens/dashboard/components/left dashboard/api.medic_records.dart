import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

/// This is a singleton class and will contains all the
/// necessary calls to fetch data into the left lateral
/// dashboard. All the filters calls should be placed here.
class APIMedicRecords {

  /// singleton class, it means all the time I'll
  /// be using the same instance.
  static APIMedicRecords? _instance;

  factory APIMedicRecords() {
    _instance ??= APIMedicRecords._();

    return _instance!;
  }

  /// Private constructor, the user is only able to create
  /// instances using the factory costructor
  APIMedicRecords._();

  /// Fetchs a list of filters to show in the lateral dashboard. The
  /// response is something like:
  /// [
  ///     {
  ///         "cod_clasificacion": 1,
  ///         "nombre": "ESTUDIANTE"
  ///     },
  /// ]
  /// And you'll use the [cod_clasificacion] to fetch the data owned by
  /// that filter.
  Future<List<Map<String, dynamic>>> fetchFilters() async {
    final isProduction = dotenv.env['IS_PRODUCTION'] == "true";

    late final rawResponse;
    // if it's not a production environment then I'll simulate the response
    if(!isProduction) {
      rawResponse = await rootBundle.loadString('data/Clasificacion_de_Grupos_BD_salud.json');

    }
    else {
      final url = Uri.parse("${dotenv.env['API_HOST']}/salud/clasificacion_grupo");
      final fetchedData = await http.get(url);

      if(fetchedData.statusCode != 200) {
        throw new ErrorDescription('Hubo un problema cargando los datos. Recargue');
      }

      rawResponse = fetchedData.body;
    }
    
    final decodedRespone = json.decode(rawResponse);

    // will store the real or simulated response
    final response = List<Map<String, dynamic>>.from(
      decodedRespone['clasificacion_grupos']
    );

    return response;
  }
}