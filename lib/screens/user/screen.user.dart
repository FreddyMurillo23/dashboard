import 'package:admin/components/header/component.header.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final user = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final size = MediaQuery.of(context).size;

    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.expand,
      children: [
        SingleChildScrollView(
          padding: EdgeInsets.only(top: defaultPadding + size.height * 0.115),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(user.toString()),
            ],
          ),
        ),
        Header(size: Size(size.width, size.height * 0.115)),
      ],
    );
  }
}