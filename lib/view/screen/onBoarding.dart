import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ramzi_store/controller/onBoardingControlle.dart';
import 'package:ramzi_store/view/widget/onBoarding/customButton.dart';
import 'package:ramzi_store/view/widget/onBoarding/customSlider.dart';
import 'package:ramzi_store/view/widget/onBoarding/dotOnboarding.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(OnBoardingControllerImp());
    return const Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: CustomSliderOnboarding(),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  CustomDotController(),
                  Spacer(flex: 2,),
                  CustomButtonOnboarding()
                ],

              ),
            ),
          ],
        ),
      ),
    );
  }
}
