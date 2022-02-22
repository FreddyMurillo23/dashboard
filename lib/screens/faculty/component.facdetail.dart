import 'package:flutter/material.dart';

class FacultyDetail extends StatefulWidget {
  final Map<String, dynamic> faculty;
  FacultyDetail({ Key? key, required this.faculty }) : super(key: key);

  @override
  _FacultyDetailState createState() => _FacultyDetailState();
}

class _FacultyDetailState extends State<FacultyDetail> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownButton<Map<String, dynamic>>(
          value: Map<String, dynamic>.from(widget.faculty['escuelas'][0]),
          items: List<DropdownMenuItem<Map<String, dynamic>>>.from(
            List<Map<String, dynamic>>.from(
              widget.faculty['escuelas']
            ).map((school) {
              print("hoooola "+widget.faculty['escuelas'][0].toString());
              print(school);
              return DropdownMenuItem<Map<String, dynamic>>(
                value: Map<String, dynamic>.from(school),
                child: Text(school["nombre"])
              );
            })
          ),
          onChanged: (x){}
        )
      ]
    );
  }
}