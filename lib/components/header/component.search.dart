import 'dart:async';

import 'package:admin/constants.dart';
import 'package:admin/controllers/controller.dashboardsearch.dart';
import 'package:admin/screens/user/screen.user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class SearchField extends StatelessWidget {

  // This stream will activate the lateral expansion sheet that will show for example
  // the user data when you search for him
  static final StreamController<Map<String, dynamic>> isSearchingStream = StreamController.broadcast();

  SearchField({
    Key? key,
  }) : super(key: key);

  dispose() {
    isSearchingStream.close();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      margin: const EdgeInsets.symmetric(vertical: defaultPadding, horizontal: defaultPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.white
      ),
      child: DropdownButton<String>(
        // elevation: 1,
        underline: Container(),
        itemHeight: null,
        onChanged: (x){},
        hint: Text(
          "Search", 
          maxLines: 1,
          overflow: TextOverflow.clip,
        ),
        alignment: Alignment.center,
        icon: Icon(Icons.search),
        value: null,
        items: [
          DropdownMenuItem(
            enabled: false,
            value: "",
            child: _SearchAndResultsPanel(),
          )
        ],
      ),
    );
  }
}


/// Idk why but the DropDownButton isn't recognizing the setState call, so, the inner
/// component is never updated. The solution for the problem was to create a new class
/// with its own state, so it's independent of the DropDownButton.
class _SearchAndResultsPanel extends StatefulWidget {
  
  final _controller = DashBoardSearchController();

  _SearchAndResultsPanel({ Key? key }) : super(key: key);

  @override
  State<_SearchAndResultsPanel> createState() => _SearchAndResultsPanelState();
}

class _SearchAndResultsPanelState extends State<_SearchAndResultsPanel> {

  late final TextEditingController ciController;
  late final TextEditingController nameController;
  late final TextEditingController surnameController;
  late final List<Map<String, dynamic>> users; // List of searched users
  
  late List<Map<String, dynamic>> careers; // a list of all the careers of the selected faculty
  late Map<String, dynamic> selectedCareer;
  late Map<String, dynamic> selectedFaculty;
  late bool shouldBlockFields; // Block non cedula fields

  // Since search results are gonna be showed here, this variable
  // will control when to show the search panel or the results
  late bool showSearchPanel;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {

    users = [];
    careers = [];
    shouldBlockFields = false;
    showSearchPanel = true;

    ciController = TextEditingController(); // cedula de identidad
    nameController = TextEditingController();
    surnameController = TextEditingController();
    selectedFaculty = Map<String, dynamic>();
    selectedCareer = Map<String, dynamic>();

    // if cedula is registered then it's not necessary to input the name
    // or career of the student, so let's block them.
    ciController.addListener((){
      setState(() {
        shouldBlockFields = ciController.text.trim().isNotEmpty;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    final size = MediaQuery.of(context).size;
    
    // This is positioned relative to screen size, so other components should do the
    // same or this will case overlaps
    return Container(
      child: Column(
        children: showSearchPanel? 
          _getSearchPanel(Size(size.width * 0.35, size.height)):
          _searchResultPanel(Size(size.width * 0.35, size.height))
      ),
    );
  }

  Widget _getInputField(
    bool isEnable, 
    String title, 
    String placeholder, 
    Size size, 
    TextEditingController controller
  ) {

    return AnimatedContainer(
      duration: Duration(milliseconds: 250),
      width: size.width,
      height: isEnable? size.height * 0.1:0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Text("$title: ")
          ),
          Expanded(
            flex: 7,
            child: TextField(
              style: TextStyle(color: isEnable? null: Colors.transparent),
              enabled: isEnable,
              controller: controller,
              decoration: InputDecoration(
                fillColor: secondaryColor,
                filled: true,
                border: !isEnable? InputBorder.none: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey[300]!
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
              )
            ),
          )
        ],
      ),
    );
  }

  List<Widget> _getSearchPanel(Size size) {
    return <Widget>[
      _getInputField(true, "Cédula", "0000000000", size, ciController),
      _getInputField(!shouldBlockFields, "Nombres", "0000000000", size, nameController),
      _getInputField(!shouldBlockFields, "Apellidos", "0000000000", size, surnameController),
  
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: MaterialButton(
          onPressed: ()async{

            if(!validateFields()) {
              SmartDialog.showToast(
                "Rellene los campos con la información solicitada",
                time: Duration(seconds: 3)
              );
              return;
            }

            final queryUsers = await widget._controller.searchUser(
              cedula: ciController.text,
              fullName: surnameController.text + " " + nameController.text,
            );
            
            // Cleaning up previous results
            users.clear();
            users.addAll(queryUsers);

            // if(queryUsers.length == 1 && ciController.text.isNotEmpty) {
            //   Navigator.pushNamed(context, '/User', arguments: users.first);
            // }

            setState(() {
              showSearchPanel = false;
            });
          },
          child: Text("Buscar"),
          color: Colors.green[900],
          textColor: Colors.white,
        ),
      )
    ];
  }

  List<Widget> _searchResultPanel(Size size) {
    return <Widget>[
      ListTile(
        title: Text("Resultados de la búsqueda"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // SmartDialog.show(
            //   alignmentTemp: Alignment.centerLeft,
            //   widget: Text("Hola")
            // );
            setState(() {
              showSearchPanel = true;
            });
          }
        ),
      ),
      Container(
        width: size.width,
        height: size.height * 0.5,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: users.length,
          itemBuilder: (context, index) {

            return GestureDetector(
              onTap: (){
                
                // this will show a lateral dialog
                SmartDialog.show(
                  alignmentTemp: Alignment.centerLeft,
                  backDismiss: false,
                  clickBgDismissTemp: false,
                  widget: Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        height: size.height,
                    decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10.0),
                              bottomRight: Radius.circular(10.0),
                      )
                    ),
                        child: UserScreen(
                            user: users[index], onPressed: SmartDialog.dismiss),
                  )
                );
                // SearchField.isSearchingStream.sink.add({
                //   "is_searching": true,
                //   "user": users[index]
                // });
                // Navigator.pushNamed(context, '/User', arguments: users.first);
              },
              child: _getResultCard(index),
            );
          }
        ),
      )
    ];
  }

  Container _getResultCard(int index) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[350]!, 
            offset: Offset(2.0, 2.0), 
            spreadRadius: 1.0,
            blurRadius: 2.0
          )
        ]
      ),
      child: Column(
        children: [
          Center(
            child: Text(
              "${users[index]['apellidos']} ${users[index]['nombres']}",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            children: [
              Text(
                "Cédula: ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text("${users[index]['cedula']}")
            ],
          ),
          Row(
            children: [
              Text(
                "Fecha de nacimiento: ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text("${users[index]['fecha_nacimiento']}")
            ],
          ),
          Row(
            children: [
              Text(
                "Correo: ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text("${users[index]['correo_institucional']}")
            ],
          ),
        ],
      )
    );
  }

  bool validateFields() {
    return ciController.text.trim().isNotEmpty
      || nameController.text.trim().isNotEmpty
      || surnameController.text.trim().isNotEmpty
    ;
  }

}