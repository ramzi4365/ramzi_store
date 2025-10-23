import 'package:get/get.dart';
import 'package:ramzi_store/data/model/myFavoriteModel.dart';

import '../../core/class/statusRequest.dart';
import '../../core/constant/routes.dart';

import '../../core/functions/handlingData.dart';
import '../../core/services/services.dart';
import '../../data/dataSource/remote/deleteFavoriteData.dart';
import '../../data/dataSource/remote/myFavoriteData.dart';
import 'package:flutter/material.dart';

abstract class MyFavoriteController extends GetxController {

  getData();
  deleteFavorite( String favorite_id);
  goToItmes();
}

class MyFavoriteControllerImp extends MyFavoriteController {

  MyFavoriteData myfavoriteData = MyFavoriteData(Get.find());
  DeleteFavoriteData deleteFavoriteData = DeleteFavoriteData(Get.find());
  late StatusRequest statusRequest;
  MyServices myServices = Get.find();
  List<MyFavoriteModel> favoriteItems = [];


  @override
  void onInit() {
    getData();
    super.onInit();
  }


  @override
  getData() async {
    statusRequest = StatusRequest.loading;
    update();

    try {
      var response = await myfavoriteData.postData(
        myServices.sharedPreferences.getInt("id").toString(),
      );

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
            if (successResponse['data'] != null) {
              List responseData = successResponse['data'];
              favoriteItems.clear();  // Clear first
              favoriteItems.addAll(responseData.map((e) => MyFavoriteModel.fromJson(e)));
              print("Data fetched successfully");
              print(favoriteItems);
            } else {
              Get.defaultDialog(
                title: "Info",
                middleText: "No favorites available",
              );
            }

            print("Data fetched successfully");
          } else {
            Get.defaultDialog(
              title: "Info",
              middleText: "Failed to load favorites",
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
    update();
  }




  //
  // @override
  // deleteFavorite(favorite_id) {
  //
  //   var response = deleteFavoriteData.deleteFavorite(
  //       favorite_id.toString());
  //   data.removeWhere((element) => element.favoriteId == favorite_id);
  //   update();
  // }









  @override
  deleteFavorite(String favorite_id) {
    // OPTIMISTIC UPDATE: Remove from UI immediately
    final itemToRemove = favoriteItems.firstWhere(
          (element) => element.favoriteId.toString() == favorite_id,
      orElse: () => MyFavoriteModel(), // Fallback if not found
    );

    favoriteItems.removeWhere((element) => element.favoriteId.toString() == favorite_id);
    update(); // Update UI immediately

    // Call API in background (don't wait for it)
    deleteFavoriteData.deleteFavorite(favorite_id).then((response) {
      response.fold(
            (failure) {
          // If API fails, add the item back to the list
          print("Delete failed, restoring item");
          favoriteItems.add(itemToRemove);
          update();

          Get.rawSnackbar(
              title: 'Error',
              messageText: Text('Failed to delete favorite')
          );
        },
            (successResponse) {
          // If API succeeds, do nothing (item already removed)
          print("Delete confirmed by server");
          Get.rawSnackbar(
              title: 'Success',
              messageText: Text('Favorite removed successfully')
          );
        },
      );
    }).catchError((error) {
      // If API call fails completely, restore the item
      print("API call failed, restoring item: $error");
      favoriteItems.add(itemToRemove);
      update();

      Get.rawSnackbar(
          title: 'Error',
          messageText: Text('Network error occurred')

      );
    }
    );
  }













  void removeFromFavorites(MyFavoriteModel item,Function addFavorite) {

    deleteFavorite(item.favoriteId.toString());


    Get.snackbar(
      '',
      '${item.itemsName} removed from favorites',
      backgroundColor: Colors.red,
      snackPosition: SnackPosition.BOTTOM,
      mainButton: TextButton(
        onPressed: () {
          addFavorite(item.itemsId.toString());
          update();
          Get.closeCurrentSnackbar();
        },
        child: const Text(
          'UNDO',
          style: TextStyle(color: Colors.white),
        ),
      ),
      snackStyle: SnackStyle.FLOATING, // ✅ instead of behavior
      margin: const EdgeInsets.all(16),
      borderRadius: 10,
    );
  }

  void moveToCart(MyFavoriteModel item) {
    Get.snackbar(
      '',
      '${item.itemsName} added to cart',
      backgroundColor: Colors.green,
      snackPosition: SnackPosition.BOTTOM,
      snackStyle: SnackStyle.FLOATING,
      margin: const EdgeInsets.all(16),
      borderRadius: 10,
    );
  }




  @override
  goToItmes() {
    // TODO: implement goToItmes
    Get.toNamed(AppRoute.items);


  }













}

