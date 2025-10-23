import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ramzi_store/core/constant/routes.dart';
import 'package:ramzi_store/core/services/services.dart';

import '../../core/class/statusRequest.dart';

import '../../core/functions/handlingData.dart';
import '../../data/dataSource/remote/auth/loginData.dart';

abstract class LoginController  extends  GetxController{

  late TextEditingController email ;
  late TextEditingController password ;

  login();
  GoToSignUp();
  goToForgetPassword();

}
class LoginControllerImp extends LoginController{
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  MyServices myServices = Get.find();


  bool  isShowPassword =true;
  StatusRequest? statusRequest ;
  LoginData loginData = LoginData(Get.find());

  showPassword(){
    isShowPassword = isShowPassword == true? false :true;
    update();
  }



  @override
  Future<void> login() async {
    statusRequest = StatusRequest.none;
    final formData = formState.currentState;

    if (formData!.validate()) {
      statusRequest = StatusRequest.loading;
      update();

      try {
        final response = await loginData.postData(email.text, password.text);
        print("API Response: $response");

        response.fold(
                (failure) {
              statusRequest = failure;
              String errorMessage;

              switch (failure) {
                case StatusRequest.serverfailure:
                  errorMessage = "Server error occurred. Please try again later.";
                  break;
                case StatusRequest.offlinefailure:
                  errorMessage = "Please check your internet connection.";
                  break;
                default:
                  errorMessage = "An unexpected error occurred.";
              }

              Get.defaultDialog(title: "Error",
                  middleText: errorMessage);
            },
                (successResponse) {
              statusRequest = handlingData(successResponse);

              if (statusRequest == StatusRequest.success) {
                // ✅ CORRECTED: Use the actual response structure from PHP
                final userData = successResponse['user'];

                // ✅ CORRECTED: Use proper SharedPreferences methods
                myServices.sharedPreferences.setInt("id", userData['id']);
                myServices.sharedPreferences.setString("email", userData['email']);
                myServices.sharedPreferences.setString("name", userData['name']);
                myServices.sharedPreferences.setString("phone", userData['phone']); // ✅ ADD THIS LINE
                myServices.sharedPreferences.setString("step", "2");

                Get.offNamed(AppRoute.mainScreen);
                print("Login successful");
              } else {
                final errorMessage = successResponse['message'] ?? "Invalid email or password";
                Get.defaultDialog(title: "Login Failed", middleText: errorMessage);
              }
            }
        );
      } catch (e) {
        print("Error in login: $e");
        statusRequest = StatusRequest.serverfailure;
        Get.defaultDialog(title: "Error", middleText: "An unexpected error occurred during login");
      }
      update();
    }
  }





  @override
  GoToSignUp(){
    Get.offNamed(AppRoute.signUp);

  }


  @override
  void onInit(){
    FirebaseMessaging.instance.getToken().then((value) {
      print(value);
      String? token = value;
    });
    email = TextEditingController();
    password = TextEditingController();

  }


  void dispose(){
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  goToForgetPassword() {
    Get.offNamed(AppRoute.forgetPassword);
  }



}
