import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ramzi_store/controller/auth/seccessSignUpController.dart';
import 'package:ramzi_store/core/constant/color.dart';
import 'package:ramzi_store/view/widget/auth/customButtonAuth.dart';

class SuccessSignUp extends StatelessWidget {
  const SuccessSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    SuccessSignUpController controller = Get.put(SuccessSignUpControllerImp());
    return  Scaffold(

        appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppColor.backGroundcolor,
          elevation: 0.0,

          title: Padding(
            padding: const EdgeInsets.only(top: 30.0), // Adjust this value as needed
            child: Text("32".tr,
                style: Theme.of(context)
                    .textTheme
                    .displayLarge!
                    .copyWith(color: AppColor.grey)),
          ),
        ),


      body: Container(
          padding: EdgeInsets.all(20),

        child:Column(

          children: [
            const SizedBox(height: 40,),
            const Center( child: Icon(Icons.check_circle_outline,size: 200,
                  color :AppColor.primaryColor )),
            SizedBox(height: 14,),
            Text("37".tr,style: Theme.of(context)
                .textTheme
                .displayLarge!
                .copyWith(fontSize: 32)),
            SizedBox(height: 12,),
            Text("38".tr, style: Theme.of(context)
                .textTheme
                .bodyMedium),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: CustomButtonAuth(text: "31".tr, onPressed:() {
                    controller.goToPageLogin();
              })
            ),
            const SizedBox(height: 30,)

          ],
        ),

      ),
    );
  }
}
