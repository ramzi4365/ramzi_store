import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/homePageController.dart';
import '../../../core/constant/color.dart';

class CustomCardHomePage extends GetView<HomePageControllerImp> {

  final String title ;
  final String body;
  const CustomCardHomePage({super.key, required this.title, required this.body,});

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: Stack(
        children: [
          Container(
            alignment: Alignment.center,
            height: 140,
            decoration: BoxDecoration(
              color: AppColor.primaryColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child:  ListTile(
              title: Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.normal,
                ),
              ),
              subtitle:  Text(
                body,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
          Positioned(
            top: -20,
            right:controller.lang == "en" ? -20 : null,
            left: controller.lang == "ar" ? -20 : null,
            child: Container(
              height: 160,
              width: 160,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(150),
                color: AppColor.secondaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
