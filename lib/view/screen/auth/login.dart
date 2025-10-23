import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ramzi_store/controller/auth/loginController.dart';
import 'package:ramzi_store/controller/auth/signUpController.dart';
import 'package:ramzi_store/core/class/statusRequest.dart';
import 'package:ramzi_store/core/constant/color.dart';
import 'package:ramzi_store/core/functions/alertExitApp.dart';

import 'package:ramzi_store/view/widget/auth/customButtonAuth.dart';
import 'package:ramzi_store/view/widget/auth/customTextBodyAuth.dart';
import 'package:ramzi_store/view/widget/auth/customTextFormAuth.dart';
import 'package:ramzi_store/view/widget/auth/customTextTitleAuth.dart';
import 'package:ramzi_store/view/widget/auth/logoAuth.dart';
import 'package:ramzi_store/view/widget/auth/textSignUp.dart';

import '../../../core/functions/validInput.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(LoginControllerImp());

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.backGroundcolor,
        elevation: 0.0,
        title: Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: Text(
            "9".tr,
            style: Theme.of(context)
                .textTheme
                .displayLarge!
                .copyWith(color: AppColor.grey),
          ),
        ),
      ),
      body: WillPopScope(
        onWillPop: alertExitApp,
        child: GetBuilder<LoginControllerImp>(
          builder: (controller) => controller.statusRequest == StatusRequest.loading
              ? const Center(child: Text("loading"))
              : Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
            child: Form(
              key: controller.formState,
              child: ListView(
                children: [
                  const SizedBox(height: 20),
                  const LogoAuth(),
                  const SizedBox(height: 25),
                  CustomTextTitleAuth(text: "10".tr),
                  const SizedBox(height: 20),
                  CustomTextBodyAuth(text: "11".tr),
                  const SizedBox(height: 20),
                  CustomTextFormAuth(
                    isNumber: false,
                    valid: (val) {
                      return validInput(val!, 5, 100, "email");
                    },
                    myController: controller.email,
                    hintText: "12".tr,
                    iconData: Icons.email_outlined,
                    labeltext: "18".tr,
                  ),
                  GetBuilder<LoginControllerImp>(
                    builder: (loginController) => CustomTextFormAuth(
                      obscureText: loginController.isShowPassword,
                      isNumber: false,
                      onTapIcon: () {
                        loginController.showPassword();
                      },
                      valid: (val) {
                        return validInput(val!, 5, 100, "password");
                      },
                      hintText: "13".tr,
                      iconData: Icons.lock_outline,
                      labeltext: "19".tr,
                      myController: loginController.password,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      controller.goToForgetPassword();
                    },
                    child: Text(
                      "14".tr,
                      textAlign: TextAlign.end,
                    ),
                  ),
                  CustomButtonAuth(
                    text: "9".tr,
                    onPressed: () {
                      controller.login();
                    },
                  ),
                  const SizedBox(height: 30),
                  CustomTextSignUpOrSignIn(
                    textOne: "16".tr,
                    textTwo: "17".tr,
                    onTap: () {
                      controller.GoToSignUp();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}