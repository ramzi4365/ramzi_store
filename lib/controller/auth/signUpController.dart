

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ramzi_store/core/constant/routes.dart';

import '../../core/class/statusRequest.dart';

import '../../core/functions/handlingData.dart';
import '../../data/dataSource/remote/auth/signUpData.dart';





abstract class SignUpController  extends  GetxController{

  late TextEditingController email ;
  late TextEditingController password ;
  late TextEditingController username ;
  late TextEditingController phone ;
   StatusRequest? statusRequest ;


  List data = [];

  SignUpData signUpData = SignUpData(Get.find());



  signUp();

  goToCheckEmail();
  goToSignIn();

}

class SignUpControllerImp extends SignUpController{
  GlobalKey<FormState> formState = GlobalKey<FormState>();


  @override
  signUp() async {
    statusRequest = StatusRequest.none;
    var formData = formState.currentState;
    if (formData!.validate()) {
      statusRequest = StatusRequest.loading;
      update();

      try {
        var response = await signUpData.postData(username.text, password.text, email.text, phone.text);
        print("API Response: $response");

        // Handle the Either response properly
        response.fold(
                (failure) {
              // This handles Left (error) case - network or server errors
              statusRequest = failure;
              print("Sign up failed with status: $failure");

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
                Get.offNamed(AppRoute.verifyCodeSignUp,arguments: {"email": email.text});
                print("Sign Up successful");
              } else {
                // Handle API-level failures (like invalid credentials)
                final errorMessage = successResponse['message'] ?? "Invalid email or password";
                Get.defaultDialog(
                    title: "Sign Up Failed",
                    middleText: errorMessage
                );
              }
            }
        );
      } catch (e) {
        print("Error in signUp: $e");
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
    username = TextEditingController();
    email = TextEditingController();
    phone = TextEditingController();
    password = TextEditingController();


    super.onInit();

  }

  void dispose(){
    username.dispose();
    email.dispose();
    password.dispose();
    phone.dispose();

    super.dispose();
  }

  @override
  goToSignIn() {
    Get.offNamed(AppRoute.login);

  }

  @override
  goToCheckEmail() {


  }



}
