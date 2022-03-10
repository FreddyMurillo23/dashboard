import 'package:admin/screens/user/component.basic_info.dart';
import 'package:admin/screens/user/component.health_data.dart';
import 'package:flutter/material.dart';

class UserScreen extends StatelessWidget {
  final Map<String, dynamic> user;
  final bool isLoading;

  const UserScreen({
    Key? key, 
    required this.user, 
    this.isLoading = false
  }):super(key: key);

  @override
  Widget build(BuildContext context) {
    
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height*0.9,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 25, 
            child: UserBasicInfo(
              user: user, 
              isLoading: isLoading
            )
          ),
          Expanded(
            flex: 75, 
            child: UserHealthData(
              user: user,
              isLoading: isLoading
            )
          )
        ],
      ),
    );
  }

}
