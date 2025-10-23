

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ramzi_store/core/constant/routes.dart';

import '../../core/class/statusRequest.dart';

import '../../core/functions/handlingData.dart';
import '../../data/dataSource/remote/forgetPassword/verifyCodeData.dart';

abstract class VerifyCodeController  extends  GetxController{

  late TextEditingController verifyCode ;

  checkCode();
  goToResetPassword(String verificationCode);

}
class VerifyCodeControllerImp extends VerifyCodeController {

  VerifyCodeData verifyCodeData = VerifyCodeData(Get.find());
  String? email;
  StatusRequest? statusRequest;



  @override
  void onInit() {
    verifyCode = TextEditingController();

    email = Get.arguments['email'];
    super.onInit();
  }




  @override
  goToResetPassword(verificationCode) async {

    statusRequest = StatusRequest.none;

    statusRequest = StatusRequest.loading;
    update();

    try {
      var response = await verifyCodeData.postData(email!, verificationCode);
      print("API Response: $response");

      response.fold(
              (failure) {
            // This handles Left (error) case - network or server errors
            statusRequest = failure;
            print("verifiction failed with status: $failure");

            String errorMessage;
            switch (failure) {
              case StatusRequest.serverfailure:
                errorMessage = "Server error occurred. Please try again later.";
                break;
              case StatusRequest.offlinefailure:
                errorMessage = "Please check your internet connection.";
                break;
              case StatusRequest.serverException:
              default:
                errorMessage = "An unexpected error occurred.";
            }

            Get.defaultDialog(
                title: "Error",
                middleText: errorMessage
            );
          },
              (successResponse) {
            // This handles Right (success) case - API returned a response
            print("Raw success response: $successResponse");

            // Use handlingData to determine the status from the API response
            statusRequest = handlingData(successResponse);
            print("Status after handling: $statusRequest");

            if (statusRequest == StatusRequest.success) {
              Get.offNamed(AppRoute.resetPassword, arguments: {"email": email} );
              print("verifiction successful");
            } else {
              // Handle API-level failures (like invalid credentials)
              final errorMessage = successResponse['message'] ??
                  "verifiction failed";
              Get.defaultDialog(
                  title: "verifiction Failed",
                  middleText: errorMessage
              );
            }
          }
      );
    } catch (e) {
      print("Error in verifycode: $e");
      statusRequest = StatusRequest.serverfailure;
      Get.defaultDialog(
          title: "Error",
          middleText: "An unexpected error occurred"
      );
    }
    update();
  }





  @override
  checkCode() {

  }
}