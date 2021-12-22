import 'dart:math';

import 'package:flutter/material.dart';

class ColorHelpers {
  
  List<Color> generateColors(int howMany) {
    return List.generate(howMany, (index) {
      return Color.fromRGBO(
        30 + Random().nextInt(200 - 30), 
        50 + Random().nextInt(100 - 50), 
        Random().nextInt(50),
        1.0
      );
    });
  }
}