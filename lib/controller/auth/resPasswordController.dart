

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ramzi_store/core/constant/routes.dart';

import '../../core/class/statusRequest.dart';

import '../../core/functions/handlingData.dart';
import '../../data/dataSource/remote/forgetPassword/resetPasswordData.dart';

abstract class ResetPasswordController  extends  GetxController{

  late TextEditingController password ;
  late TextEditingController repassword  ;



  resetPassword();
  goToSuccessResetPassword();

}
class ResetPasswordControllerImp extends ResetPasswordController{

  GlobalKey<FormState> formState = GlobalKey<FormState>();




  StatusRequest? statusRequest ;
  String? email;
  ResetPasswordData resetPasswordData = ResetPasswordData(Get.find());

  @override
  resetPassword() async {
    if (password.text != repassword.text) {
      return Get.defaultDialog(title: "Error", middleText: "Passwords do not match");
    }
    var formData = formState.currentState;
    if (formData!.validate()) {
      statusRequest = StatusRequest.none;

      statusRequest = StatusRequest.loading;
      update();

      try {
        var response = await resetPasswordData.postData(email!,password.text);
        print("API Response: $response");

        response.fold(
                (failure) {
              // This handles Left (error) case - network or server errors
              statusRequest = failure;
              print("verifiction failed with status: $failure");

              String errorMessage;
              switch (failure) {
                case StatusRequest.serverfailure:
                  errorMessage =
                  "Server error occurred. Please try again later.";
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
                Get.offNamed(AppRoute.successResetPassword);
                print("reset password successful");
              } else {
                // Handle API-level failures (like invalid credentials)
                final errorMessage = successResponse['message'] ??
                    "reset password failed";
                Get.defaultDialog(
                    title: "reset password Failed",
                    middleText: errorMessage
                );
              }
            }
        );
      } catch (e) {
        print("Error in reset password: $e");
        statusRequest = StatusRequest.serverfailure;
        Get.defaultDialog(
            title: "Error",
            middleText: "An unexpected error occurred"
        );
      }
      update();
    }
  }





  @override
  void onInit(){

    password = TextEditingController();
    repassword = TextEditingController();
    email = Get.arguments['email'];
    super.onInit();
  }



  void dispose(){

    password.dispose();
    repassword.dispose();
    super.dispose();
  }

  @override
  goToSuccessResetPassword() {
    // TODO: implement goToSuccessResetPassword
    throw UnimplementedError();
  }














}
