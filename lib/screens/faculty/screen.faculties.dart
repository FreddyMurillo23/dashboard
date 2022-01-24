import 'package:admin/controllers/controller.faculties.dart';
import 'package:flutter/material.dart';

class FacultiesScreen extends StatelessWidget {
  FacultiesScreen({ Key? key }) : super(key: key);

  final _controller = FacultiesController();

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Container(
      child: FutureBuilder(
        future: _controller.fetchFaculties(),
        builder: (BuildContext context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          
          if(!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          return GridView.count(
            crossAxisCount: 7,
            padding: const EdgeInsets.all(8.0),
            children: List<Widget>.from(
              snapshot.data!.map((map) {
                return Card(
                  elevation: 3.0,
                  child: Column(
                    children: [
                      ListTile(
                        title: Text("${map['nombre']}"),
                      )
                    ],
                  ),
                );
              })
            ),
          );
        },
      ),
    );
  }
}