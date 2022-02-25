import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class UIHelper {

  ///
  void showLateralSheet(BuildContext context, {required String title, required Widget content}) {
    
    final size = MediaQuery.of(context).size;
    
    // SmartDialog.show(      

    //   widget: Container(
    //     width: size.width * 0.8,
    //     height: size.height * 0.95,
    //     decoration: BoxDecoration(
    //       color: Colors.white,
    //       borderRadius: BorderRadius.only(
    //         topRight: Radius.circular(20.0),
    //         bottomRight: Radius.circular(20.0),
    //       )
    //     ),
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         Padding(
    //           padding: const EdgeInsets.all(10.0),
    //           child: content
    //         ),
    //       ],
    //     )
    //   )
    // );

    showGlobalDrawer(
      context: context, 
      barrierDismissible: true,
      builder: (context){
        return Container(
          alignment: Alignment.topLeft,
          width: size.width * 0.8,
          height: size.height,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),
            )
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
                trailing: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: ()=>Navigator.of(context).pop(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: content
              ),
            ],
          )
        );
      
      }
    );  
  }
}