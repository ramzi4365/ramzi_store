import 'package:get/get.dart';
import 'package:ramzi_store/controller/auth/forgetPasswordController.dart';
import 'package:ramzi_store/core/constant/color.dart';
import 'package:flutter/material.dart';

import 'package:ramzi_store/view/widget/auth/customButtonAuth.dart';
import 'package:ramzi_store/view/widget/auth/customTextFormAuth.dart';
import '../../../../core/class/statusRequest.dart';
import '../../../../core/functions/validInput.dart';
import '../../../widget/auth/customTextBodyAuth.dart';
import '../../../widget/auth/customTextTitleAuth.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ForgetPasswordControllerImp());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.backGroundcolor,
        elevation: 0.0,

        title: Padding(
          padding: const EdgeInsets.only(top: 30.0), // Adjust this value as needed
          child: Text("39".tr,
              style: Theme.of(context)
                  .textTheme
                  .displayLarge?.copyWith(color: AppColor.grey)),
        ),
      ),
      body:Form(child: GetBuilder<ForgetPasswordControllerImp>(
        builder: (controller) => controller.statusRequest == StatusRequest.loading
        ? const Center(child: Text("loading"))
        :Container(
      padding: const EdgeInsets.symmetric(vertical: 15 , horizontal: 30),
      child: Form(
        key: controller.formState,
        child: ListView(children: [
          const SizedBox(height: 20),


          CustomTextTitleAuth(text: "27".tr),
          const SizedBox(height: 20),
          CustomTextBodyAuth(text:"29".tr),
          const SizedBox(height: 20),

          CustomTextFormAuth(
            isNumber: false,
            valid: (val){
              return validInput(val!,5,100,"email");

            },
            hintText: "12".tr,
            iconData: Icons.email_outlined,
            labeltext: "18".tr,
            myController: controller.email,
          ),







          CustomButtonAuth(text: "30".tr, onPressed:() {
            controller.goToVerifyCode();
          }),


          const SizedBox(height: 30,),


        ]
        ),
      ),
        )
    ),
    )

    );
  }
}


