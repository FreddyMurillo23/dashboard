import 'package:admin/models/route_argument.dart';
import 'package:admin/screens/dashboard/components/header.dart';
import 'package:admin/screens/dashboard/components/year_population_IMC/view.icm_by_year.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../../constants.dart';

class UserProfile extends StatefulWidget {
  final RouteArgument? routeArgument;

  UserProfile({Key? key, this.routeArgument}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        scrollDirection: Axis.horizontal,
        slivers: [
          _header(),
          _content(),
        ],
      ),
    );
  }

  Widget _header() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.all(defaultPadding),
        child: Header(),
      ),
    );
  }

  _content() {
    return SliverToBoxAdapter(
      child: Column(
        children: [],
      ),
    );
  }
}
