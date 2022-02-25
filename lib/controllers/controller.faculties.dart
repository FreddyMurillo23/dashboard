import 'package:admin/Repository/api.faculty.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class FacultiesController {

  final _api = APIFaculty();

  Future<List<Map<String, dynamic>>> fetchFaculties() async {
    return await _api.fetchData();
  }

  Future<Map<String, dynamic>> fetchSchoolData(int facId, int schId) async {
    return await _api.fetchSchoolData(facId, schId);
  }

  List<PieChartSectionData> buildSchoolImcDataset(Map<String, dynamic> data, List<Color> colors) {
    final List<PieChartSectionData> elements = [];

    // min max standarization
    double min = 0.0;
    double max = 100.0;
    double minSize = 15.0;
    double scaleFactor = 25.0;
      
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

    return elements;
    
  }
}