import 'package:admin/components/header/component.header.dart';
import 'package:admin/components/patterns/component.random_pattern.dart';
import 'package:admin/controllers/controller.faculties.dart';
import 'package:admin/helpers/helper.ui.dart';
import 'package:admin/screens/faculty/component.facdetail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import '../../constants.dart';

class FacultiesScreen extends StatelessWidget {
  FacultiesScreen({ Key? key }) : super(key: key);

  final _controller = FacultiesController();

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        Padding(
          padding:  EdgeInsets.all(defaultPadding),
          child: Header(size: Size(size.width, size.height * 0.115)),
        ),
        Expanded(
          child: FutureBuilder(
            future: _controller.fetchFaculties(),
            builder: (BuildContext context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
              
              if(!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }

              return GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 5/2,
                padding: const EdgeInsets.all(8.0),
                children: List<Widget>.from(
                  snapshot.data!.map((map) {
                    return GestureDetector(
                      onTap: (){
                        // this will show a lateral dialog
                        UIHelper().showLateralSheet(
                          context, 
                          title: 'FACULTAD DE ${map['nombre'].toUpperCase()}',
                          content: FacultyDetail(faculty: map)
                        );
                      },
                      child: Card(
                        elevation: 3.0,
                        child: Column(
                          children: [
                            Expanded(
                              flex: 6,
                              child: ClipRRect(
                                child: RandomPatternComponent(seed: map['id']),
                              ),
                            ),
                            ListTile(
                              title: Text("${map['nombre']}"),
                              subtitle: Text("Número de escuelas: ${(map['escuelas'] as List).length}"),
                            )
                          ],
                        ),
                      ),
                    );
                  })
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}