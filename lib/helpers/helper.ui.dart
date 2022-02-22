import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class UIHelper {

  void showLateralSheet(BuildContext context, {required String title, required Widget content}) {
    
    final size = MediaQuery.of(context).size;
    
    SmartDialog.show(
      alignmentTemp: Alignment.centerLeft,
      backDismiss: true,
      clickBgDismissTemp: true,
      widget: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: size.height * 0.95,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          )
        ),
        child: Column(
          children: [
            ListTile(
              title: Text(title),
              trailing: IconButton(
                icon: Icon(Icons.close),
                onPressed: ()=>SmartDialog.dismiss()
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: content,
            )
          ],
        ),
      )
    );
  }
}