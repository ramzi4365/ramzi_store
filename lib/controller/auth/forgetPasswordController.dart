

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ramzi_store/core/constant/routes.dart';
import '../../core/class/statusRequest.dart';

import '../../core/functions/handlingData.dart';
import '../../data/dataSource/remote/forgetPassword/checkEmailData.dart';

abstract class ForgetPasswordController  extends  GetxController{

  late TextEditingController email ;

  checkEmail();
  goToVerifyCode();

}
class ForgetPasswordControllerImp extends ForgetPasswordController {

  GlobalKey<FormState> formState = GlobalKey<FormState>();

  StatusRequest? statusRequest;

  CheckEmailData checkEmailData = CheckEmailData(Get.find());


  @override
  Future<void> goToVerifyCode() async {
    // Reset status request
    statusRequest = StatusRequest.none;
    var formData = formState.currentState;
    if (formData!.validate()) {
      statusRequest = StatusRequest.loading;
      update();

      try {
        final response = await checkEmailData.postData(email.text);
        print("API Response: $response");

        // Handle the Either response properly
        response.fold(
                (failure) {
              // This handles Left (error) case - network or server errors
              statusRequest = failure;
              print("Email check failed with status: $failure");

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
                // Email found, navigate to verify code screen
                Get.offNamed(AppRoute.verifyCode,arguments: {"email": email.text});
                print("Email check successful");
              } else {
                // Handle API-level failures (email not found)
                final errorMessage = successResponse['message'] ??
                    "Email not found";
                Get.defaultDialog(
                    title: "Email Check Failed",
                    middleText: errorMessage
                );
              }
            }
        );
      } catch (e) {
        print("Error in email check: $e");
        statusRequest = StatusRequest.serverfailure;
        Get.defaultDialog(
            title: "Error",
            middleText: "An unexpected error occurred during email check"
        );
      }

      update();
    }
  }


  @override
  void onInit() {
    email = TextEditingController();


    super.onInit();
  }

  void dispose() {
    email.dispose();


    super.dispose();
  }

  @override
  checkEmail() {
    // TODO: implement checkEmail
    throw UnimplementedError();
  }


}





