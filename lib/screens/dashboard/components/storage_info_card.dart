import 'package:flutter/material.dart';

import '../../../constants.dart';

class StorageInfoCard extends StatelessWidget {
  const StorageInfoCard({
    Key? key,
    required this.title,
    required this.svgSrc,
    required this.amountOfFiles,
    required this.numOfFiles,
    required this.onPress,
  }) : super(key: key);

  final Function() onPress;
  final String title, amountOfFiles;
  final Icon svgSrc;
  final int numOfFiles;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onPress,
        child: Container(
          margin: EdgeInsets.only(top: defaultPadding),
          padding: EdgeInsets.all(defaultPadding),
          decoration: BoxDecoration(
            border: Border.all(width: 2, color: primaryColor.withOpacity(0.15)),
            borderRadius: const BorderRadius.all(
              Radius.circular(defaultPadding),
            ),
          ),
          child: Row(
            children: [
              SizedBox(
                height: 20,
                width: 20,
                child: svgSrc,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        "$numOfFiles Registros",
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
              Text("$amountOfFiles %")
            ],
          ),
        ),
      ),
    );
  }
}
