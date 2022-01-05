
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

/// Manages all the flow of searched data on any screen of the project
class APISearch {

  Future<List<Map<String, dynamic>>> searchUserByCedula(String cedula) async {
    
    final isProduction = dotenv.env['IS_PRODUCTION'] == "true";

    late final rawResponse;

    // if it's not a production environment then I'll simulate the response
    if(!isProduction) {
      rawResponse = await rootBundle.loadString('data/Persona_por_cedula.json');
    }
    else {
      final url = Uri.parse("${dotenv.env['API_HOST']}salud/datos_nutricionales_paciente_cedula/$cedula");
      final fetchedData = await http.get(url);

      if(fetchedData.statusCode != 200) {
        throw new ErrorDescription('Hubo un problema cargando los datos. Recargue');
      }

      rawResponse = fetchedData.body;
    }
    
    final decodedRespone = json.decode(rawResponse);

    return List<Map<String, dynamic>>.from(decodedRespone);
  }

  

  Future<List<Map<String, dynamic>>> searchUserByName(String name) async {
    
    final isProduction = dotenv.env['IS_PRODUCTION'] == "true";

    late final rawResponse;

    // if it's not a production environment then I'll simulate the response
    if(!isProduction) {
      rawResponse = await rootBundle.loadString('data/Persona_por_nombre.json');
    }
    else {
      final url = Uri.parse("${dotenv.env['API_HOST']}salud/datos_nutricionales_paciente_nombres/$name");
      final fetchedData = await http.get(url);

      if(fetchedData.statusCode != 200) {
        throw new ErrorDescription('Hubo un problema cargando los datos. Recargue');
      }

      rawResponse = fetchedData.body;
    }
    
    final decodedRespone = json.decode(rawResponse);

    return List<Map<String, dynamic>>.from(decodedRespone);
  }

}