import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:flutter/material.dart';
class UIHelper {

  ///
  void showLateralSheet(
    BuildContext context, 
    {
      required String title,
      required Widget content,
      Color? backgroundColor,
      Color? foregroundColor
    }
  ) {
    
    final size = MediaQuery.of(context).size;

    showGlobalDrawer(
      context: context, 
      barrierDismissible: true,
      builder: (context){
        return Container(
          alignment: Alignment.topLeft,
          width: size.width * 0.8,
          height: size.height,
          decoration: BoxDecoration(
            color: backgroundColor ?? Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),
            )
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: foregroundColor ?? Colors.black
                  )
                ),
                trailing: IconButton(
                  icon: Icon(Icons.close, color: foregroundColor,),
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