import 'package:get/get.dart';
import 'package:ramzi_store/controller/auth/signUpController.dart';
import 'package:ramzi_store/core/class/statusRequest.dart';
import 'package:ramzi_store/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:ramzi_store/core/functions/alertExitApp.dart';


import 'package:ramzi_store/view/widget/auth/textSignUp.dart';
import 'package:ramzi_store/view/widget/auth/customButtonAuth.dart';
import 'package:ramzi_store/view/widget/auth/customTextFormAuth.dart';


import '../../../core/functions/validInput.dart';
import '../../widget/auth/customTextBodyAuth.dart';
import '../../widget/auth/customTextTitleAuth.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     Get.put(SignUpControllerImp());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.backGroundcolor,
        elevation: 0.0,

        title: Padding(
          padding: const EdgeInsets.only(top: 30.0), // Adjust this value as needed
          child: Text('Sign Up',
              style: Theme.of(context)
                  .textTheme
                  .displayLarge?.copyWith(color: AppColor.grey)),
        ),
      ),


      body: WillPopScope(

        onWillPop: alertExitApp,
        child:
        GetBuilder<SignUpControllerImp>(
        builder: (controller)=>
          controller.statusRequest == StatusRequest.loading?
            const Center(child: Text("loading"),):
        Container(
        padding: const EdgeInsets.symmetric(vertical: 15 , horizontal: 30),
        child: Form(
          key: controller.formState,
          child: ListView(children: [
            const SizedBox(height: 20),


            CustomTextTitleAuth(text: "10".tr),
            const SizedBox(height: 20),
            CustomTextBodyAuth(text:"24".tr),
            const SizedBox(height: 20),
            CustomTextFormAuth(
              isNumber: false,
              valid: (val){
                return validInput(val!,5,10,"username");

              },
              hintText: "23".tr,
              iconData: Icons.person_outlined,
              labeltext: "20".tr,
              myController: controller.username,
            ),
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

            CustomTextFormAuth(
              isNumber: true,
              valid: (val){
                return validInput(val!,5,100,"phone");
              },
              hintText: "22".tr,
              iconData: Icons.phone_outlined,
              labeltext: "21".tr,
              myController: controller.phone,
            ),

            CustomTextFormAuth(
              obscureText: true,
              isNumber: false,
              valid: (val){
                return validInput(val!,5,100,"password");

              },
              hintText: "13".tr,
              iconData: Icons.lock_outline,
              labeltext: "19".tr,
              myController: controller.password,
            ),



            CustomButtonAuth(text: "17".tr, onPressed:() {
              controller.signUp();


            }

            ),




            const SizedBox(height: 30,),
            CustomTextSignUpOrSignIn(

              textOne: "25".tr,
              textTwo: "9".tr,
              onTap:() {
                controller.goToSignIn();},
            )

                    ]
           ),
          ),

        ),
        )
      )
    );
  }
}


