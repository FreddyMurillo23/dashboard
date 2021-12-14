import 'package:flutter/material.dart';

class IconHelper {

  IconData iconFromString(String name) {
    switch(name.toLowerCase()) {
      case "estudiante": return Icons.person;
      case "obrero": return Icons.manage_accounts;
      case "docente": return Icons.wallet_travel;
      case "jubilado": return Icons.wb_sunny;
      case "empleado": return Icons.engineering_sharp;
      default: return Icons.filter_alt_rounded;
    }
  }

}