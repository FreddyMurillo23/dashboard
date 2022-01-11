import 'package:admin/components/header/component.header.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class UserProfile extends StatefulWidget {

  UserProfile({Key? key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    
    /// You need to pass the user in the route arguments
    final user = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

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
        child: Header(size: Size(double.infinity, 150),),
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
