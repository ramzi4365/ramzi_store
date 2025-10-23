import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ramzi_store/core/constant/routes.dart';
import 'package:ramzi_store/core/localization/chageLocal.dart';
import 'package:ramzi_store/view/widget/language/customButtonLang.dart';


class Language extends GetView<LocaleController> {
  const Language({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "1".tr,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          CustomButtonLang(
            textButton: "Ar",
            onPressed: () {
              controller.changeLang('ar');
              Get.toNamed(AppRoute.onBoarding);
            },
          ),
          CustomButtonLang(
            textButton: "En",
            onPressed: () {
              controller.changeLang('en');
              Get.toNamed(AppRoute.onBoarding);
            },
          ),
        ],
      ),
    );
  }
}