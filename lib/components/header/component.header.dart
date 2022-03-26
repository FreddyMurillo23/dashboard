// import 'package:admin/controllers/MenuController.dart';
import 'package:flutter/material.dart';

import '../../../../constants.dart';
import 'component.search.dart';
class Header extends StatelessWidget {
  static Header? _instance;

  factory Header({required Size size}) {
    _instance ??= Header._(
      size: size,
    );

    return _instance!;
  }

  final Size size;

  const Header._({
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
          color: primaryColor, borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pushNamed('/Splash'),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: defaultPadding*2),
                    child: Text(
                      "Dashboard Bienestar Estudiantil",
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .merge(TextStyle(color: Colors.white)),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SearchField(),
        ],
      ),
    );
  }
}
