import 'package:get/get.dart';

import 'package:ramzi_store/core/constant/color.dart';
import 'package:flutter/material.dart';


import 'package:ramzi_store/view/widget/auth/customButtonAuth.dart';
import 'package:ramzi_store/view/widget/auth/customTextFormAuth.dart';


import '../../../../controller/auth/resPasswordController.dart' show ResetPasswordControllerImp;
import '../../../../core/class/statusRequest.dart';
import '../../../../core/functions/validInput.dart';
import '../../../widget/auth/customTextBodyAuth.dart';
import '../../../widget/auth/customTextTitleAuth.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ResetPasswordControllerImp());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.backGroundcolor,
        elevation: 0.0,

        title: Padding(
          padding: const EdgeInsets.only(top: 30.0), // Adjust this value as needed
          child: Text("39".tr,
              style:Theme.of(context)
                  .textTheme
                  .displayLarge?.copyWith(color: AppColor.grey)),
        ),
      ),
      body:GetBuilder<ResetPasswordControllerImp>(builder: (controller)=>
        controller.statusRequest == StatusRequest.loading?
        const Center(child: Text("loading"),):
          Container(
            padding: const EdgeInsets.symmetric(vertical: 15 , horizontal: 30),
            child: Form(
              key: controller.formState,
              child: ListView(children: [
                const SizedBox(height: 20),


                 CustomTextTitleAuth(text: "35".tr),
                const SizedBox(height: 20),
                CustomTextBodyAuth(text:"34".tr),
                const SizedBox(height: 20),

                CustomTextFormAuth(
                  isNumber: false,
                  valid: (val){
                    return validInput(val!,5,100,"password");

                  },
                  hintText: "13".tr,
                  iconData: Icons.lock_outline,
                  labeltext: "19".tr,
                  myController: controller.password,
                ),

                CustomTextFormAuth(
                  isNumber: false,
                  valid: (val){
                    return validInput(val!,5,100,"password");

                  },
                  hintText: "34".tr,
                  iconData: Icons.lock_outline,
                  labeltext: "40".tr,
                  myController: controller.repassword,
                ),



                CustomButtonAuth(text: "33".tr, onPressed:() {
                  controller.resetPassword();
                }),


                const SizedBox(height: 30,),


              ]
              ),
            ),

          ),
    )
    );
  }
}


