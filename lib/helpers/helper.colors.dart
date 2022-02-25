import 'package:admin/helpers/helper.math.dart' as mathHelper;
import 'package:flutter/material.dart';

class ColorHelpers {
  
  /// Generates a list of colors based on [color]. The generated palette
  /// will be scaled using minmax standardizer with [howMany] as the
  /// max value and 0 as the min one
  List<Color> generateColors(int howMany, [Color color = Colors.blue]) {
    return List.generate(howMany, (index) {
      return color.withOpacity(1 - mathHelper.minmax(index * 1.0, 0, howMany * 1.0));
    });
  }
}