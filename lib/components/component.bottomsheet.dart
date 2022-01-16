import 'package:admin/components/header/component.search.dart';
import 'package:flutter/material.dart';

class LateralExpansionSheet extends StatelessWidget {

  final bool isExpanded;
  final double maxWidth;
  final double screenWidth;
  final double height;
  final double screenHeight;
  final Widget? child;

  const LateralExpansionSheet({ 
    Key? key,
    required this.isExpanded, 
    required this.maxWidth, 
    required this.height, 
    required this.screenWidth, 
    required this.screenHeight, 
    this.child 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 250),
      width: isExpanded? screenWidth:0,
      height: screenHeight,
      color: Colors.black.withOpacity(0.4),
      child: Row(
        children: [
          AnimatedContainer(
            width: isExpanded? maxWidth:0,
            duration: Duration(milliseconds: 250),
            height: height,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0),
              )
            ),
            child: !isExpanded?null:Column(
              children: [
                ListTile(
                  trailing: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: (){
                      // Returning the search state to false to hidde the expansion sheet
                      SearchField.isSearchingStream.sink.add({
                        "is_searching": false
                      });
                    },
                  ),
                ),
                child ?? Container()
              ],
            ),
          ),
        ],
      ),
    );
  }
}