import 'package:flutter/material.dart';

import '../../../core/constant/color.dart';

class CustomBouttonAppBar extends StatelessWidget {
  final void Function() onPressed;
  final String textBotton;
  final IconData  iconData;
  final bool? active ;
   const CustomBouttonAppBar({super.key,
    required this.onPressed,
    required this.textBotton,
    required this.iconData,
    required this.active,});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [Icon(iconData,color: active==true?AppColor.primaryColor:Colors.black,),
          Text(textBotton,style: TextStyle(color: active==true?AppColor.primaryColor:Colors.black),)
        ],
      ),

    );

  }
}
