import 'package:flutter/material.dart';

class InfoTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color bgColor;
  final Color fgColor;
  final Size? size;
  final double titleSize;
  final double valueSize;
  final double iconSize;

  InfoTile({ 
    Key? key,
    required this.icon,
    required this.title,
    required this.value,
    this.size,
    this.bgColor = Colors.white,
    this.fgColor = Colors.black,
    this.iconSize = 20.0,
    this.titleSize = 18.0,
    this.valueSize = 40.0
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
  return Container(
      width: size?.width,
      height: size?.height,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10.0)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: fgColor,
                size: iconSize,
              ),
              SizedBox(width: 10.0,),
              Text(
                title,
                style: TextStyle(
                  fontSize: titleSize,
                  color: fgColor,
                  fontWeight: FontWeight.bold
                ),
              ),
            ],
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: valueSize,
              color: fgColor,
              fontWeight: FontWeight.bold
            ),
          ),
          Container()
        ],
      ),
    );

  }
}