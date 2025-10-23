import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ramzi_store/controller/auth/successResetPasswordController.dart';
import 'package:ramzi_store/view/widget/auth/customButtonAuth.dart';

import '../../../../core/constant/color.dart' show AppColor;

class SuccessResetPassword extends StatelessWidget {
  const SuccessResetPassword({super.key});



  @override
  Widget build(BuildContext context) {
    SuccessResetPasswordController controller = Get.put(SuccessResetPasswordControllerImp());
    return Scaffold(

      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.backGroundcolor,
        elevation: 0.0,

        title: Padding(
          padding: const EdgeInsets.only(top: 30.0), // Adjust this value as needed
          child: Text('Success',
              style: Theme.of(context)
                  .textTheme
                  .displayLarge?.copyWith(color: AppColor.grey)),
        ),
      ),


      body: Container(
        padding: EdgeInsets.all(20),

        child:Column(

          children: [
            const SizedBox(height: 40,),
            const Center( child: Icon(Icons.check_circle_outline,size: 200,
                color :AppColor.primaryColor )),
            Text("37".tr,style: Theme.of(context)
                .textTheme
                .displayLarge!
                .copyWith(fontSize: 32)),
            SizedBox(height: 12,),
            Text("36".tr, style: Theme.of(context)
                .textTheme
                .bodyMedium),
            const Spacer(),
            SizedBox(
                width: double.infinity,
                child: CustomButtonAuth(text: 'Go To Login', onPressed:() {
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
