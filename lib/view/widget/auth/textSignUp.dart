

import 'package:flutter/material.dart';
import 'package:ramzi_store/core/constant/color.dart';

class CustomTextSignUpOrSignIn extends StatelessWidget {
  final String textOne;
  final String textTwo;
  final void Function() onTap;

  const CustomTextSignUpOrSignIn({super.key,
    required this.textOne,
    required this.textTwo,
    required this.onTap});




  @override
  Widget build(BuildContext context) {
    return Row(
    mainAxisAlignment: MainAxisAlignment.center, // Center the row
    children: [
    Text(textOne),
    InkWell(
    onTap: onTap,
    child:  Text(textTwo,
    style: TextStyle(
    color: AppColor.primaryColor,
        fontWeight: FontWeight.bold)),

    )
    ]
    );

        }
}