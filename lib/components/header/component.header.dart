// import 'package:admin/controllers/MenuController.dart';
import 'package:admin/responsive.dart';
import 'package:flutter/material.dart';

import '../../../../constants.dart';
import 'component.search.dart';

/// This is a singleton class so you can use the same instance all
/// around the applicatino without any problem keeping the state
class Header extends StatelessWidget {

  static Header? _instance;

  factory Header({required Size size}){
    _instance ??= Header._(size: size,);

    return _instance!;
  }

  final Size size;

  const Header._({
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    // It's necessary to be a stack in order to place the search box with the panel,
    // otherwise you'll be not able to expand the search filters without increasing
    // this component height what looks hugly
    return Container(
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
        color: primaryColor, 
        borderRadius: BorderRadius.circular(10)
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: defaultPadding),
                child: Text(
                  "Dashboard Bienestar Estudiantil",
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .merge(TextStyle(color: Colors.white)),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                margin: const EdgeInsets.symmetric(vertical: defaultPadding),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.white
                ),
                child: DropdownButton<String>(
                  underline: Container(),
                  itemHeight: null,
                  alignment: Alignment.center,
                  onChanged: (item){},
                  hint: Icon(Icons.auto_stories_sharp),
                  items: [
                    DropdownMenuItem(
                      enabled: false,
                      value: "",
                      child: Container(
                        width: size.width * 0.2,
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: CustomScrollView(
                          slivers: [
                            SliverToBoxAdapter(
                              child: MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: ListTile(
                                  onTap: ()=>Navigator.of(context).pushNamed('/Faculties'),
                                  title: Text("Facultades"),
                                  leading: Icon(Icons.school),
                                ),
                              )
                              
                            ),
                            SliverToBoxAdapter(
                              child: MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: ListTile(
                                  title: Text("Personal"),
                                  leading: Icon(Icons.work)
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    )
                    
                  ],
                ),
              ),
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: defaultPadding),
              //   child: InkWell(
              //     onTap: () {
              //       Navigator.of(context)
              //           .pushNamed('/UserProfile');
              //     },
              //     child: Container(
              //       padding: const EdgeInsets.all(8.0),
              //       decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(80),
              //         color: Colors.white,
              //         boxShadow: [
              //           BoxShadow(
              //               color: Theme.of(context).focusColor.withOpacity(0.15),
              //               blurRadius: 5,
              //               offset: Offset(0, 2)),
              //         ],
              //       ),
              //       // color: Colors.white,
              //       child: Text(
              //         "Perfil estudiante",
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
          // if (!Responsive.isMobile(context))
          // Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
          
          SearchField(),
          // SizedBox(width: size.width*0.1,)
          // ProfileCard()
        ],
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: defaultPadding, vertical: defaultPadding / 2),
      child: Container(
        margin: EdgeInsets.only(left: defaultPadding),
        padding: EdgeInsets.symmetric(
          horizontal: defaultPadding / 2,
          vertical: defaultPadding / 2,
        ),
        decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: Colors.white10),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.asset(
              "assets/images/profile_pic.png",
              height: 38,
            ),
            if (!Responsive.isMobile(context))
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
                child: Text("Angelina Joli"),
              ),
            Icon(Icons.keyboard_arrow_down),
          ],
        ),
      ),
    );
  }
}
