import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ramzi_store/controller/onBoardingControlle.dart';
import 'package:ramzi_store/core/constant/color.dart';
import 'package:ramzi_store/data/dataSource/static/static.dart';

class CustomSliderOnboarding extends GetView<OnBoardingControllerImp> {
  const CustomSliderOnboarding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: controller.pageController,
      onPageChanged: (index) {
        controller.OnPageChanged(index); // Connect to controller
      },
      itemCount: onBoardingList.length,
      itemBuilder: (context, index) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 120),

              // Image
              Image.asset(
                onBoardingList[index].image!,
                width: MediaQuery.of(context).size.width * 0.7,
                height: 300,
                fit: BoxFit.contain,
              ),

              const SizedBox(height: 40),

              // Title
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  onBoardingList[index].title!,
                  style:
                      TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: AppColor.black),
                  textAlign: TextAlign.center
                ),
              ),

              const SizedBox(height: 20),

              // Description
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Text(
                  onBoardingList[index].body!,
                  style: TextStyle(
                      height: 2,
                      color: AppColor.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                    textAlign: TextAlign.center
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}