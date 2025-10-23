import 'package:flutter/material.dart';

import '../../../core/constant/color.dart';

class CustomTitleHomePage extends StatelessWidget {
  final String title;
  const CustomTitleHomePage( this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
        margin: const EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.centerLeft,

        child: Text(title,
          style: const TextStyle(
              fontSize: 23,
              color:AppColor.primaryColor,
              fontWeight: FontWeight.bold),)
    );
  }
}
