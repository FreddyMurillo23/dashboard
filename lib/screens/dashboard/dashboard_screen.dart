import 'package:admin/components/header.dart';
import 'package:admin/components/search_bar/component.search.dart';
import 'package:admin/screens/dashboard/component.gender_imc.dart';
import 'package:admin/screens/dashboard/component.imc_by_year.dart';
import 'package:admin/screens/dashboard/component.overweight.dart';
import 'package:flutter/material.dart';

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

    return Stack(
      children: [
        SingleChildScrollView(
          padding: EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              Header(),
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
                    IMCByFacultyComponent(
                      size: Size(size.width * 0.55, size.height * 0.7),
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
                  GenderIMCComponent(
                    size: Size(
                      MediaQuery.of(context).size.width * 0.35,
                      MediaQuery.of(context).size.height * 0.5
                    ),
                  ),
                  IMCByYearComponent(
                    size: Size(
                      MediaQuery.of(context).size.width * 0.6,
                      MediaQuery.of(context).size.height * 0.5
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        
        SearchField(),
      ],
    );
  }
}