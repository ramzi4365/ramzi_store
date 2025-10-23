
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ramzi_store/controller/onBoardingControlle.dart';
import 'package:ramzi_store/core/constant/color.dart';
import 'package:ramzi_store/data/dataSource/static/static.dart';

class CustomDotController extends StatelessWidget {
  const CustomDotController({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnBoardingControllerImp>(
      builder: (controller) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          onBoardingList.length,
              (index) => AnimatedContainer(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            duration: const Duration(milliseconds: 400),
            curve: Curves.fastOutSlowIn,
            width: controller.currentPage == index ? 24 : 8,
            height: controller.currentPage == index ? 8 : 8,
            decoration: BoxDecoration(
              color: controller.currentPage == index
                  ? AppColor.primaryColor
                  : AppColor.primaryColor.withOpacity(0.3),
              shape: BoxShape.circle,
              boxShadow: controller.currentPage == index
                  ? [
                BoxShadow(
                  color: AppColor.primaryColor.withOpacity(0.5),
                  blurRadius: 4,
                  spreadRadius: 1,
                  offset: const Offset(0, 1),
                )
              ]
                  : null,
            ),
          ),
        ),
      ),
    );
  }
}