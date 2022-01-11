import 'package:admin/components/header/component.header.dart';
import 'package:admin/components/header/component.search.dart';
import 'package:admin/screens/dashboard/component.gender_imc.dart';
import 'package:admin/screens/dashboard/component.imc_by_year.dart';
import 'package:admin/screens/dashboard/component.overweight.dart';
import 'package:flutter/material.dart';
import 'package:indexed/indexed.dart';

import '../../constants.dart';
import 'component.overweight.dart';

import '../../../constants.dart';
import 'component.medic_records.dart';
import 'component.imc_by_faculty.dart';

class DashboardScreen extends StatefulWidget {
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Indexer(
      children: [
        Indexed(
          child: Header(size: Size(size.width, size.height * 0.115)),
          index: 1,
        ),
        Indexed(
          index: 0,
          child: Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                vertical: defaultPadding + size.height * 0.115, 
                horizontal: defaultPadding
              ),
              child: Column(
                children: [
                  SizedBox(height: defaultPadding),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 1.0,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MedicRecordsComponent(
                          size: Size(size.width * 0.2, size.height),
                        ),
                        SizedBox(
                          width: defaultPadding,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            IMCByYearComponent(
                              size: Size(size.width * 0.55, size.height * 0.35),
                            ),
                            GenderIMCComponent(
                              size: Size(
                                MediaQuery.of(context).size.width * 0.55,
                                MediaQuery.of(context).size.height * 0.35
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: defaultPadding,
                        ),
                        GaugeChart(
                          size: Size(size.width * 0.2, size.height),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: defaultPadding,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IMCByFacultyComponent(
                        size: Size(
                          MediaQuery.of(context).size.width * 0.9,
                          MediaQuery.of(context).size.height * 0.5
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}