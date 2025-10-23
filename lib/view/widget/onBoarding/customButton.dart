import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ramzi_store/controller/onBoardingControlle.dart';
import 'package:ramzi_store/core/constant/color.dart';

class CustomButtonOnboarding extends GetView<OnBoardingControllerImp> {
  const CustomButtonOnboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 65),
      child: Material(
        borderRadius: BorderRadius.circular(12),
        elevation: 3,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () => controller.next(),
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width * 0.85, // 80% of screen width
            padding: const EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
              color: AppColor.primaryColor,
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                colors: [
                  AppColor.primaryColor,
                  AppColor.primaryColor.withOpacity(0.9),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            alignment: Alignment.center,
            child:  Text(
              "8".tr,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.8,
              ),
            ),
          ),
        ),
      ),
    );
  }
}