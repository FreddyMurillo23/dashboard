import 'package:flutter/material.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final user = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    return Container(
      child: Text(user.toString()),
    );
  }
}