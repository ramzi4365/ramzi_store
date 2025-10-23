
import 'package:get/get.dart';

import '../../core/class/statusRequest.dart';

import '../../core/functions/handlingData.dart';
import '../../core/services/services.dart';
import '../../data/dataSource/remote/addRemoveFavorite.dart';
import 'package:flutter/material.dart';


abstract class AddRemoveFavoriteController extends GetxController {

  setFavorite(String id, String val);
  addFavorite( String itemsid);
  removeFavorite(String itemsid);

}

class AddRemoveFavoriteControllerImp extends AddRemoveFavoriteController {

  Map isfavorite = {};
  AddRemoveFavoriteData addRemoveFavoriteData = AddRemoveFavoriteData(Get.find());
  StatusRequest? statusRequest;
  MyServices myServices = Get.find();





  @override
  setFavorite(String id, String val) {
    isfavorite[id] = val;
    print(isfavorite);
    update();
  }



  @override
  addFavorite(itemsid) async {
    print("ramzi $itemsid");
    print("ramzi ${myServices.sharedPreferences.getInt("id")}");
    statusRequest = StatusRequest.loading;
    update();

    try {
      var response = await addRemoveFavoriteData.addFavorite(
          myServices.sharedPreferences.getInt("id").toString(),

          itemsid.toString());


      response.fold(
            (failure) {
          statusRequest = failure;
          print("Data fetch failed with status: $failure");

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

          Get.defaultDialog(title: "Error", middleText: errorMessage);
        },
            (successResponse) {
          statusRequest = handlingData(successResponse);

          if (statusRequest == StatusRequest.success) {

            Get.rawSnackbar(title: 'Success',  messageText: Text("remove done"));
            print("Data fetched successfully");
          } else {
            Get.defaultDialog(
              title: "Info",
              middleText: "failed to add favorite",
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






  @override
  removeFavorite(String itemsid) async {
    statusRequest = StatusRequest.loading;
    update();

    try {
      var response = await addRemoveFavoriteData.removeFavorite(
          myServices.sharedPreferences.getInt("id").toString(),
          itemsid.toString());

      response.fold(
            (failure) {
          statusRequest = failure;
          print("Data fetch failed with status: $failure");

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

          Get.defaultDialog(title: "Error", middleText: errorMessage);
        },
            (successResponse) {
          statusRequest = handlingData(successResponse);

          if (statusRequest == StatusRequest.success) {
            Get.rawSnackbar(title: 'Success',  messageText: Text("added done"));
            print("Data fetched successfully");
          } else {
            Get.defaultDialog(
              title: "Info",
              middleText: "failed to remove favorite",
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





}