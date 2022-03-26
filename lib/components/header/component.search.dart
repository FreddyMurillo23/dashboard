import 'dart:async';

import 'package:admin/Repository/api.user.dart';
import 'package:admin/constants.dart';
import 'package:admin/controllers/controller.dashboardsearch.dart';
import 'package:admin/helpers/helper.ui.dart';
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
          _searchResultPanel(context, Size(size.width * 0.35, size.height))
      ),
    );
  }

  /// Creates a new custom input field according to defined
  /// interface styles
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

  /// Creates a panel that allows user to search for students according
  /// to a full name or an identification (cedula). You can't input a cedula and
  /// a full name at the same time. [size] referes to the size of this component,
  /// not the screen size.
  List<Widget> _getSearchPanel(Size size) {
    return <Widget>[
      _getInputField(true, "Cédula", "0000000000", size, ciController),
      _getInputField(!shouldBlockFields, "Nombres", "0000000000", size, nameController),
      _getInputField(!shouldBlockFields, "Apellidos", "0000000000", size, surnameController),
  
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MaterialButton(
              onPressed: ()async{

                if(!validateFields()) {
                  SmartDialog.showToast(
                    "Rellene los campos con la información solicitada",
                    time: Duration(seconds: 3)
                  );
                  return;
                }

		SmartDialog.showLoading(msg: 'Cargando datos, por favor espere');
                final queryUsers = await widget._controller.searchUser(
                  cedula: ciController.text,
                  fullName: nameController.text + " " + surnameController.text,
                );

		SmartDialog.dismiss();
                
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

            MaterialButton(
              color: Colors.green[900],
              onPressed: () => Navigator.of(context)
                                      .pushNamed('/Faculties'),
            child: Text('Facultades',style: TextStyle(color: secondaryColor),),
            ),
          ],
        ),
      )
    ];
  }

  List<Widget> _searchResultPanel(BuildContext mainContext, Size size) {


    List<Widget> content = [
      ListTile(
        title: Text("Mostrando resultados de búsqueda"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            setState(() {
              showSearchPanel = true;
            });
          }
        ),
      ),
      users.isEmpty?Container(
        width: size.width,
        height: size.height * 0.5,
	child: Center(
	    child: Text("Ningún usuario coincide con los criterios de búsqueda")
	)
      ):_getResultTable(users, size)
    ];

    return content;
  }

  Widget _getResultTable(List<Map<String, dynamic>> userRecords, Size size) {

    const header = [
      "Cédula",
      "Correo",
      "Nombre",
      "F. Nacimiento"
    ];

    return PaginatedDataTable(
	  columnSpacing: 10.0,
	  showCheckboxColumn: false,
	  rowsPerPage: 5,
	  source: _TalbeRow(context, userRecords, size),
	  horizontalMargin: 5.0,
	  
	  columns: List<DataColumn>.from(header.map((head){
	    return DataColumn(label: Text(head));
	  }))
    );
  }

  bool validateFields() {
    return ciController.text.trim().isNotEmpty
      || nameController.text.trim().isNotEmpty
      || surnameController.text.trim().isNotEmpty
    ;
  }

}

/// Creates a new row format for a PaginatedDataTable. In
/// this scenario [context] should be a MaterialPage context,
/// you can't use a context provided by, for example, FutureBuilder,
/// StreamBuilder, or any builder context that does not directly
/// belong to a material page.
/// 
class _TalbeRow extends DataTableSource {

  final List<Map<String, dynamic>> userRecords;
  final Size size;
  final BuildContext context;

  _TalbeRow(this.context, this.userRecords, this.size);

  @override
  DataRow? getRow(int index) {

    if(index > userRecords.length - 1) return null;

    return DataRow.byIndex(
      onSelectChanged: (_){
	UIHelper().showLateralSheet(
	  context, 
	  backgroundColor: Colors.green[900]!,
	  foregroundColor: Colors.white,
	  title: 'Mostrando datos de usuario', 
	  content: FutureBuilder<Map<String,dynamic>>(
	    future: APIUser().fetchUserData(userRecords[index]['id_paciente'].toString()),
	    builder: (context, snapshot) {

	      if(!snapshot.hasData) {
		return UserScreen(
		  user: {},
		  isLoading: !snapshot.hasData
		);
	      }

	      final Map<String, dynamic> data = snapshot.data!;
	      data.addAll({'cedula': userRecords[index]['cedula']});

	      return UserScreen(
		user: snapshot.data!
	      );
	    }
	  )
	);
      },
      index: index,
      cells: [
        DataCell(
          SizedBox(
            width: size.width*0.15,
            child: Text(
              userRecords[index]['cedula'] ?? "N/A",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            )
          )
        ),
        DataCell(
          SizedBox(
            width: size.width*0.3,
            child: Text(
              userRecords[index]['correo_institucional'] ?? "N/A",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            )
          )
        ),
        DataCell(
          SizedBox(
            width: size.width*0.35,
            child: Text(
              '${userRecords[index]['apellidos']} ${userRecords[index]['nombres']}',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            )
          )
        ),
        DataCell(
          SizedBox(
            width: size.width*0.2,
            child: Text(
              userRecords[index]['fecha_nacimiento'] ?? "N/A",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            )
          )
        ),


      ]
    );
  }

  @override
  bool get isRowCountApproximate => false;
  @override
  int get rowCount => userRecords.length;
  @override
  int get selectedRowCount => 0; // para no complicarse la existencia :)


}
