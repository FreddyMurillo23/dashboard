import 'package:admin/components/user_profile.dart';
import 'package:admin/screens/dashboard/dashboard_screen.dart';
import 'package:admin/screens/user/screen.user.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    switch (settings.name) {
      case '/Splash':
        return MaterialPageRoute(builder: (_) => DashboardScreen(), settings: settings);
      case '/UserProfile':
        return MaterialPageRoute( builder: (_) => UserProfile(), settings: settings);
      case '/User':
        return MaterialPageRoute(builder: (_)=>UserScreen(), settings: settings);
      default:
        // If there is no such named route in the switch statement, e.g. /third
        return MaterialPageRoute(
            builder: (_) =>
                Scaffold(body: SafeArea(child: Text('404 Page not found'))));
    }
  }
}
