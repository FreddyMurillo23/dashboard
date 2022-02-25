import 'package:admin/screens/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';

import '../../components/side_menu.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: context.read<MenuController>().scaffoldKey,
      drawer: SideMenu(),
      body: DashboardScreen(),
    );
  }
}
