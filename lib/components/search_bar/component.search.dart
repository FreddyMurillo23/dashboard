import 'package:admin/Repository/api.faculty.dart';
import 'package:admin/constants.dart';
import 'package:flutter/material.dart';

class SearchField extends StatefulWidget {
  SearchField({
    Key? key,
  }) : super(key: key);

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {

  // Block non cedula fields
  late bool shouldBlockFields;

  late final TextEditingController ciController;
  late final TextEditingController nameController;
  late final TextEditingController surnameController;
  late Map<String, dynamic> selectedFaculty;
  late Map<String, dynamic> selectedCareer;

  // a list of all the careers of the selected faculty
  late List<Map<String, dynamic>> careers;

  @override
  void initState() {

    careers = [];
    shouldBlockFields = false;

    ciController = TextEditingController();
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
    return Positioned(
      right: size.width * 0.2,
      top: defaultPadding * 1.5,
      child: Container(
        width: size.width * 0.35,
        padding: const EdgeInsets.symmetric(
          horizontal: defaultPadding, 
          vertical: defaultPadding / 4
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0)
        ),
        child: ExpansionTile(
          title: const Text("Search"),
          trailing: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.grey[200]!,
              borderRadius: BorderRadius.circular(10.0)
            ),
            child: const Icon(Icons.search)
          ),
          children: [
            _getInputField(true, "Cédula", "0000000000", size, ciController),
            _getInputField(!shouldBlockFields, "Nombres", "0000000000", size, nameController),
            _getInputField(!shouldBlockFields, "Apellidos", "0000000000", size, surnameController),
            
            FutureBuilder(
              future: APIFaculty().fetchData(),
              builder: (BuildContext context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                
                if(!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator(),);
                }

                final facultyData = List<Map<String, dynamic>>.from(snapshot.data!.map((faculty) {
                  return {
                    "id": faculty["id"],
                    "name": faculty["nombre"],
                    "schools": faculty["escuelas"]
                  };
                }));

                if(careers.isEmpty) {

                  selectedFaculty = facultyData[0];

                  careers.clear();
                  careers.addAll(
                    List<Map<String, dynamic>>.from(
                      snapshot.data![0]["escuelas"]
                    )
                  );

                  selectedCareer = careers[0];

                }
                
                // Ok, this is raising an error if I don't reasign the [selectedFaculty]
                // variable, and idk why exactly but it looks like a reference problem, 
                // I mean, probably the [selectedFaculty] is not a reference, so I use 
                // this code to handle the problem, why? i have no clue since the setState 
                // in the onChange should handle it...
                selectedFaculty = facultyData.firstWhere((fac)=>fac['id'] == selectedFaculty['id']);

                // Yeah, as you can guess, [selectedCareer] has the same problem...
                selectedCareer = careers.firstWhere(
                  (cac)=>cac['id'] == selectedCareer['id'],
                  orElse: ()=>careers[0]
                );

                // You will see that onChange is defined here, well, that's because of the
                // previous problem with references, so, it's better to define that method
                // here in order to not loose the reference
                return Column(
                  children: [
                    _getInputDorpDownField(
                      isEnable: !shouldBlockFields, 
                      title: "Facultad",
                      data: facultyData,
                      size: size, 
                      controller: selectedFaculty,
                      onChange: (value) {
                        selectedFaculty = value;
                        careers = List<Map<String, dynamic>>.from(selectedFaculty['schools']);
                        setState(() {});
                      }
                    ),
                    _getInputDorpDownField(
                      isEnable: !shouldBlockFields, 
                      title: "Carrera",
                      data: careers,
                      size: size,
                      onChange: (value) {
                        selectedCareer = value;
                        setState(() {});
                      },
                      controller: selectedCareer
                    ),
                  ],
                );
              },
            ),
            
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MaterialButton(
                onPressed: (){},
                child: Text("Buscar"),
                color: Colors.green[900],
                textColor: Colors.white,
              ),
            )
          ],
        ),
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

    return SizedBox(
      // width: size.width * 0.5,
      height: size.height * 0.1,
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
              enabled: isEnable,
              onChanged: (value) {
                controller.text = value;
              },
              decoration: InputDecoration(
                fillColor: secondaryColor,
                filled: true,
                border: OutlineInputBorder(
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

  Widget _getInputDorpDownField({
    required bool isEnable, 
    required String title, 
    required List<Map<String, dynamic>> data, 
    required Size size, 
    required Map<String, dynamic> controller,
    Function(dynamic value)? onChange
  }) {
    return SizedBox(
      // width: size.width * 0.5,
      height: size.height * 0.1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Text("$title: ")
          ),
          Expanded(
            flex: 6,
            child: DropdownButton(
              onChanged: onChange,
              value: controller,
              items: List<DropdownMenuItem<Map<String, dynamic>>>.from(data.map((item) {
                return DropdownMenuItem<Map<String, dynamic>>(
                  value: item,
                  enabled: isEnable,
                  child: Text(
                    item["name"] ?? item["nombre"],
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              }))
            )
          )
        ],
      ),
    );
  }
}