import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:ramzi_store/controller/auth/verifyCodeSignUpController.dart';
import 'package:ramzi_store/core/class/statusRequest.dart';
import 'package:ramzi_store/core/constant/color.dart';
import 'package:flutter/material.dart';
import '../../../../controller/auth/verfiyCodeController.dart';
import '../../widget/auth/customTextBodyAuth.dart';
import '../../widget/auth/customTextTitleAuth.dart';


class VerifyCodeSignUp extends StatelessWidget {
  const VerifyCodeSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(VerifyCodeSignUpControllerImp());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.backGroundcolor,
        elevation: 0.0,

        title: Padding(
          padding: const EdgeInsets.only(top: 30.0), // Adjust this value as needed
          child: Text("43".tr,
              style: Theme.of(context)
                  .textTheme
                  .displayLarge?.copyWith(color: AppColor.grey)),
        ),
      ),
      body: GetBuilder<VerifyCodeSignUpControllerImp>(builder: (controller)=>
       controller.statusRequest == StatusRequest.loading?
       const Center(child: Text("loading"),):
        Container(
      padding: const EdgeInsets.symmetric(vertical: 15 , horizontal: 30),
      child: ListView(children: [
        const SizedBox(height: 20),


        CustomTextTitleAuth(text: "42".tr),
        const SizedBox(height: 20),
        CustomTextBodyAuth(text:"41".tr),
        const SizedBox(height: 20),

        OtpTextField(
          fieldWidth: 50.0,
          borderRadius: BorderRadius.circular(20),
          numberOfFields: 5,
          borderColor: Color(0xFF512DA8),
          //set to true to show as box or false to show as dash
          showFieldAsBox: true,
          //runs when a code is typed in
          onCodeChanged: (String code) {
            //handle validation or checks here
          },
          //runs when every textfield is filled
          onSubmit: (String verificationCode){
            controller.goToSuccessSignUp(verificationCode);

          },


        ),




        const SizedBox(height: 30,),

      ]
      ),

    ),
    ));
  }
}


