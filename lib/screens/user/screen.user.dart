import 'package:admin/components/header/component.header.dart';
import 'package:flutter/material.dart';

class UserScreen extends StatelessWidget {

  final Map<String, dynamic> user;

  const UserScreen({ Key? key, required this.user }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(user.toString()),
        ],
      ),
    );
  }
}