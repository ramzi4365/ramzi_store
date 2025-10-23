import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ramzi_store/core/constant/routes.dart';
import 'package:ramzi_store/core/services/services.dart';

import '../../core/class/statusRequest.dart';

import '../../data/dataSource/remote/auth/loginData.dart';
import '../core/functions/handlingData.dart';
import '../data/dataSource/remote/addressData.dart';
import '../data/model/addressModel.dart';

abstract class AddressController extends GetxController {


  // Text editing controllers for add address form
  late TextEditingController addressNameController;
  late TextEditingController phoneController;
  late TextEditingController cityController;
  late TextEditingController streetController;
  late TextEditingController detailsController;
}



class AddressControllerImp extends AddressController {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  MyServices myServices = Get.find();
  List<AddressModel> addresses = [];
  StatusRequest? statusRequest;
  AddressData addressData = AddressData(Get.find());

  // API Methods
  @override
  addToAddress() async {
    statusRequest = StatusRequest.none;
    var formData = formState.currentState;
    if (formData!.validate()) {
      statusRequest = StatusRequest.loading;
      update();

      try {
        var response = await addressData.addressAdd(
          myServices.sharedPreferences.getInt("id").toString(),
          addressNameController.text,
          cityController.text,
          streetController.text,
          phoneController.text.toString(),
          detailsController.text,
        );
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
              middleText: errorMessage,
            );
          },
              (successResponse) {
            // This handles Right (success) case - API returned a response

            // Use handlingData to determine the status from the API response
            statusRequest = handlingData(successResponse);
            print("Status after handling: $statusRequest");

            if (statusRequest == StatusRequest.success) {
              viewAddress();
              print("add address successful");
              clearForm();
            }
          },
        );
      } catch (e) {
        print("Error addressView: $e");
        statusRequest = StatusRequest.serverfailure;
        Get.defaultDialog(
          title: "Error",
          middleText: "An unexpected error occurred",
        );
      }
    }
  }



  @override
  viewAddress() async {
    statusRequest = StatusRequest.none;
    update();

    try {
      var response = await addressData.addressView(
        myServices.sharedPreferences.getInt("id").toString(),
      );
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
            default:
              errorMessage = "An unexpected error occurred.";
          }

          Get.defaultDialog(
            title: "Error",
            middleText: errorMessage,
          );
        },
            (successResponse) {
          // This handles Right (success) case - API returned a respon

          // Use handlingData to determine the status from the API response
          statusRequest = handlingData(successResponse);

          if (statusRequest == StatusRequest.success) {
            addresses.clear();
            List responseList = successResponse['data'];
            addresses.addAll(responseList.map((e) => AddressModel.fromJson(e)));
            update();
          }
        },
      );
    } catch (e) {
      print("addressView Error: $e");
      statusRequest = StatusRequest.serverfailure;
      Get.defaultDialog(
        title: "Error",
        middleText: "An unexpected error occurred",
      );
    }
  }


  @override
  deleteAddress(String addressid) async {
    statusRequest = StatusRequest.loading;
    update();

    try {
      var response = await addressData.addressDelete(addressid);

      response.fold(
            (failure) {
          statusRequest = failure;

          String errorMessage;
          switch (failure) {
            case StatusRequest.serverfailure:
            default:
              errorMessage = "An unexpected error occurred.";
          }

          Get.defaultDialog(title: "Error", middleText: errorMessage);
        },
            (successResponse) {
          statusRequest = handlingData(successResponse);

          if (statusRequest == StatusRequest.success) {
            viewAddress();
            Get.rawSnackbar(title: 'Success', messageText: const Text("Address deleted successfully"));
            print("Address deleted successfully");
          } else {
            Get.defaultDialog(
              title: "Info",
              middleText: "Failed to delete address",
            );
          }
        },
      );
    } catch (e) {
      print("Error in getData: $e");
      statusRequest = StatusRequest.serverfailure;
      Get.defaultDialog(
        title: "Error",
        middleText: "An unexpected error occurred",
      );
    }
  }


  void saveAddress() {
    if (formState.currentState!.validate()) {
      addToAddress();
      viewAddress();


      Get.back();
    }
  }

  String? validateAddressName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an address name';
    }
    return null;
  }

  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter phone number';
    }
    if (value.length < 9) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  String? validateCity(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter city name';
    }
    return null;
  }

  String? validateStreet(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter street name';
    }
    return null;
  }







  void clearForm() {
    addressNameController.clear();
    phoneController.clear();
    cityController.clear();
    streetController.clear();
    detailsController.clear();
  }





  @override
  void onInit() {
    addressNameController = TextEditingController();
    phoneController = TextEditingController();
    cityController = TextEditingController();
    streetController = TextEditingController();
    detailsController = TextEditingController();

    // Load addresses on initialization
    viewAddress();

    super.onInit();
  }

  @override
  void onClose() {
    addressNameController.dispose();
    phoneController.dispose();
    cityController.dispose();
    streetController.dispose();
    detailsController.dispose();
    super.onClose();
  }
}