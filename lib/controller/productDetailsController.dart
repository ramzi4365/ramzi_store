import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:ramzi_store/controller/cartController.dart';
import 'package:ramzi_store/data/model/cartModel.dart';
import 'package:ramzi_store/data/model/itemsModel.dart';

import '../core/class/statusRequest.dart';
import '../core/constant/routes.dart';

import '../core/functions/handlingData.dart';
import '../core/services/services.dart';
import '../data/dataSource/remote/cartData.dart';

abstract class ProductDetailsController extends GetxController with
    GetSingleTickerProviderStateMixin{
  initialData();




}

class ProductDetailsControllerImp extends ProductDetailsController {

 // ItemsData itemsData = ItemsData(Get.find());
  CartData cartData = CartData(Get.find());
  MyServices myServices = Get.find();
  late ItemsModel itemsModel;


  int counter = 1 ;
  StatusRequest? statusRequest;
  int totalPrices =0;
  int currentCount =0 ;
  bool? isFavorite ;





  final PageController imageController = PageController();
  late AnimationController fadeController;
  late Animation<double> fadeAnimation;

  // Regular variables instead of observables
  int currentImageIndex = 0;
  int selectedColorIndex = 0;
  int selectedSizeIndex = 0;
  int quantity = 0;

  bool showFullDescription = false;
  bool isAddingToCart = false;

  Map<dynamic, int> optimisticCounts = {};

  List<Color> availableColors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
  ];
  List<String> availableSizes = ['S', 'M', 'L', 'XL'];









  @override
  add(String itemsid) async {
    // Store original count before optimistic update
    final originalCount = optimisticCounts[itemsid] ?? quantity;

    // Optimistic UI update first
    optimisticCounts[itemsid] = originalCount + 1;
    quantity = originalCount + 1;
    update();

    statusRequest = StatusRequest.loading;

    try {
      var response = await cartData.cartAdd(
        myServices.sharedPreferences.getInt("id").toString(),
        itemsid.toString(),
      );

      response.fold(
            (failure) {
          statusRequest = failure;
          // Revert optimistic update on failure
          optimisticCounts[itemsid] = originalCount;
          quantity = originalCount;

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
          update();
        },
            (successResponse) async {  // Make this async
          statusRequest = handlingData(successResponse);

          if (statusRequest == StatusRequest.success) {
            // Get actual count from server to ensure sync
            await getCountItemsCart(itemsid);
            update(); // Update UI with actual count

            Get.rawSnackbar(
                title: 'Success',
                messageText: const Text("Item added to cart")
            );
            print("Item added to cart successfully");
          } else {
            // Revert optimistic update on API failure
            optimisticCounts[itemsid] = originalCount;
            quantity = originalCount;
            Get.defaultDialog(
              title: "Error",
              middleText: "Failed to add item to cart: ${successResponse['message']}",
            );
          }
          update();
        },
      );
    } catch (e) {
      print("Error in add: $e");
      statusRequest = StatusRequest.serverfailure;
      // Revert optimistic update on exception
      optimisticCounts[itemsid] = originalCount;
      quantity = originalCount;
      Get.defaultDialog(
        title: "Error",
        middleText: "An unexpected error occurred while adding to cart",
      );
      update();
    }
  }
  @override
  remove(String itemsid) async {
    int currentCount = optimisticCounts[itemsid] ?? quantity;

    if (currentCount > 0) {
      // Store original count before optimistic update
      final originalCount = currentCount;

      // Optimistic UI update first
      optimisticCounts[itemsid] = currentCount - 1;
      quantity = currentCount - 1;
      update();

      statusRequest = StatusRequest.loading;

      try {
        var response = await cartData.cartRemove(
          myServices.sharedPreferences.getInt("id").toString(),
          itemsid.toString(),
        );

        response.fold(
              (failure) {
            statusRequest = failure;
            // Revert optimistic update on failure
            optimisticCounts[itemsid] = originalCount;
            quantity = originalCount;

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
            update();
          },
              (successResponse) async {  // Make this async
            statusRequest = handlingData(successResponse);

            if (statusRequest == StatusRequest.success) {
              // Get actual count from server to ensure sync
              await getCountItemsCart(itemsid);
              update(); // Update UI with actual count

              Get.rawSnackbar(
                  title: 'Success',
                  messageText: const Text("Item removed from cart")
              );
              print("Item removed from cart successfully");
            } else {
              // Revert optimistic update on API failure
              optimisticCounts[itemsid] = originalCount;
              quantity = originalCount;
              Get.defaultDialog(
                title: "Error",
                middleText: "Failed to remove item from cart: ${successResponse['message']}",
              );
              print("Remove failed: ${successResponse['message']}");
            }
            update();
          },
        );
      } catch (e) {
        print("Error in remove: $e");
        statusRequest = StatusRequest.serverfailure;
        // Revert optimistic update on exception
        optimisticCounts[itemsid] = currentCount;
        quantity = currentCount;
        Get.defaultDialog(
          title: "Error",
          middleText: "An unexpected error occurred while removing from cart",
        );
        update();
      }
    }
  }
  // Get count with optimistic support
  // Get count with optimistic support
  getCountItemsCart(String itemsid) async {
    try {
      var response = await cartData.cartCount(
        myServices.sharedPreferences.getInt("id").toString(),
        itemsid.toString(),
      );

      response.fold(
            (failure) {
          print("Failed to get cart count: $failure");
          // Don't update quantity on failure - keep optimistic value
        },
            (successResponse) {
          StatusRequest status = handlingData(successResponse);

          if (status == StatusRequest.success) {
            dynamic responseData = successResponse["data"];
            int count = responseData is int ? responseData : int.tryParse(responseData.toString()) ?? 0;
            optimisticCounts[itemsid] = count;
            quantity = count;
            print("Actual cart count from server: $quantity");
          } else {
            print("Cart count API returned failure: ${successResponse['message']}");
          }
        },
      );
    } catch (e) {
      print("Error in getCountItemsCart: $e");
    }
  }








  @override
  void onInit() {
    initialData();

    super.onInit();

    fadeController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    fadeAnimation = CurvedAnimation(
      parent: fadeController,
      curve: Curves.easeIn,
    );
    fadeController.forward();


  }



  @override
  initialData()async {
    statusRequest= StatusRequest.loading;
    itemsModel =Get.arguments['itemsModel'];

    isFavorite = Get.arguments['isFavorite'];
    if (itemsModel.itemsId != null) {
      await getCountItemsCart(itemsModel.itemsId.toString());
    }

    update();

  }

















  // Methods to calculate values instead of getters
  double calculateFinalPrice(double price, double? oldPrice) {
    return oldPrice ?? price;
  }

  double get calculateSavedAmount {
    if (itemsModel.itemsDiscount != null && itemsModel.itemsDiscount! > 0) {
      return (itemsModel.itemsPrice! * itemsModel.itemsDiscount! / 100);
    }
    return 0;
  }



  @override
  void onClose() {
    fadeController.dispose();
    imageController.dispose();
    super.onClose();
  }


  void changeImageIndex(int index) {
    currentImageIndex = index;
    update(); // Manually update the UI
  }

  void changeColorIndex(int index) {
    selectedColorIndex = index;
    update(); // Manually update the UI
  }

  void changeSizeIndex(int index) {
    selectedSizeIndex = index;
    update(); // Manually update the UI
  }

  void incrementQuantity() {
    quantity++;
    update(); // Manually update the UI
  }

  void decrementQuantity() {
    if (quantity > 1) {
      quantity--;
      update(); // Manually update the UI
    }
  }

  void toggleFavorite() {
    isFavorite = !isFavorite!;
    update(); // Manually update the UI
  }

  void toggleDescription() {
    showFullDescription = !showFullDescription;
    update(); // Manually update the UI
  }

  Future<void> addToCart(ItemsModel itemsModel) async {
    isAddingToCart = true;
    update(); // Manually update the UI

    await Future.delayed(const Duration(seconds: 1));
    Get.toNamed(AppRoute.cartDetails);
    isAddingToCart = false;
    update(); // Manually update the UI

    Get.snackbar(
      'Added to Cart',
      '${itemsModel.itemsName} added to cart',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      borderRadius: 8,
    );
  }
}





















