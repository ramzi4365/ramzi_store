import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../core/class/statusRequest.dart';
import '../core/constant/routes.dart';

import '../core/functions/handlingData.dart';
import '../core/services/services.dart';
import '../data/dataSource/remote/cartData.dart';
import '../data/model/cartModel.dart';
import '../data/model/couponModel.dart';
import '../data/model/itemsModel.dart';

class CartController extends GetxController {
  CartData cartData = CartData(Get.find());
  StatusRequest? statusRequest;
  MyServices myServices = Get.find();
  List<MyCartModel> cartProduct = [];
  CouponModel? couponModel ;


  int? countItems = 0;
  double subTotalPrice = 0;
  double totalPrice = 0;
  int totalCount = 0;


  // Promo code related variables
  String? promoCode = '';
  double? couponDiscount = 0;
  String? couponName;
  int? couponId ;
  TextEditingController? promoController ;





  // Optimistic UI tracking
  Map<String, int> optimisticCounts = {}; // itemsId -> count
  Map<String, bool> pendingOperations = {}; // itemsId -> isPending

  // Get count with optimistic UI support
  Future<int> getCountItemsCart(String itemsid) async {
    print("Getting count for item: $itemsid");

    // OPTIMISTIC: First check if we have an optimistic count
    if (optimisticCounts.containsKey(itemsid)) {
      print("Returning optimistic count: ${optimisticCounts[itemsid]}");
      return optimisticCounts[itemsid]!;
    }

    statusRequest = StatusRequest.loading;
    update();

    try {
      var response = await cartData.cartCount(
        myServices.sharedPreferences.getInt("id").toString(),
        itemsid.toString(),
      );

      return response.fold(
            (failure) {
          statusRequest = failure;
          print("Data fetch failed with status: $failure");
          return 0;
        },
            (successResponse) {
          statusRequest = handlingData(successResponse);
          int finalCount = 0;

          if (statusRequest == StatusRequest.success && successResponse["status"] == "success") {
            // Handle both int and string responses
            dynamic responseData = successResponse["data"];

            if (responseData is int) {
              finalCount = responseData;
            } else if (responseData is String) {
              finalCount = int.tryParse(responseData) ?? 0;
            }

            // Store the count for optimistic updates
            optimisticCounts[itemsid] = finalCount;

            print("Count fetched successfully: $finalCount");
            return finalCount;
          } else {
            print("Failed to get cart count");
            return 0;
          }
        },
      );
    } catch (e) {
      print("Error in getCountItemsCart: $e");
      statusRequest = StatusRequest.serverfailure;
      return 0;
    }
  }

  // Add with optimistic UI update
  add(String itemsid) async {
    print("Adding item: $itemsid");

    // OPTIMISTIC UPDATE: Update UI immediately
    int currentCount = optimisticCounts[itemsid] ?? 0;
    optimisticCounts[itemsid] = currentCount + 1;
    pendingOperations[itemsid] = true;
    update();

    Get.rawSnackbar(title: 'Success', messageText: Text("Item added to cart"));

    // Call API in background
    try {
      var response = await cartData.cartAdd(
        myServices.sharedPreferences.getInt("id").toString(),
        itemsid.toString(),
      );

      response.fold(
            (failure) {
          // REVERT OPTIMISTIC UPDATE: If API fails, revert the change
          optimisticCounts[itemsid] = currentCount;
          pendingOperations[itemsid] = false;
          update();

          print("Add failed with status: $failure");
          Get.rawSnackbar(
            title: 'Error',
            messageText: Text("Failed to add item to cart"),
          );
        },
            (successResponse) {
          // CONFIRM OPTIMISTIC UPDATE: If API succeeds, keep the change
          pendingOperations[itemsid] = false;
          update();

          print("Add confirmed by server");
          // Refresh actual data from server
          viewItemCart();
        },
      );
    } catch (e) {
      // REVERT ON ERROR: If API call fails completely, revert the change
      optimisticCounts[itemsid] = currentCount;
      pendingOperations[itemsid] = false;
      update();

      print("Error in add: $e");
      Get.rawSnackbar(
        title: 'Error',
        messageText: Text("Network error occurred"),
      );
    }
  }


// Remove with optimistic UI update
  remove(String itemsid) async {
    print("Removing item: $itemsid");

    // Check if already at 0
    int currentCount = optimisticCounts[itemsid] ?? 0;
    if (currentCount <= 0) {
      return;
    }

    // Check if operation is already in progress
    if (pendingOperations[itemsid] == true) {
      return;
    }

    // OPTIMISTIC UPDATE: Update UI immediately
    optimisticCounts[itemsid] = currentCount - 1;
    pendingOperations[itemsid] = true;
    update();
    // Call API in background
    try {
      var response = await cartData.cartRemove(
        myServices.sharedPreferences.getInt("id").toString(),
        itemsid.toString(),
      );

      response.fold(
            (failure) {
          // REVERT OPTIMISTIC UPDATE: If API fails, revert the change
          optimisticCounts[itemsid] = currentCount;
          pendingOperations[itemsid] = false;
          update();
          print("Remove failed with status: $failure");
        },
            (successResponse) {
          statusRequest = handlingData(successResponse);
          // CONFIRM OPTIMISTIC UPDATE: If API succeeds, keep the change
          pendingOperations[itemsid] = false;
          update();

          print("Remove confirmed by server");
          // Refresh actual data from server
          viewItemCart();
        },
      );
    } catch (e) {
      // REVERT ON ERROR: If API call fails completely, revert the change
      optimisticCounts[itemsid] = currentCount;
      pendingOperations[itemsid] = false;
      update();

      print("Error in remove: $e");
      Get.rawSnackbar(
        title: 'Error',
        messageText: Text("Network error occurred"),
      );
    }
  }
// View cart items
// View cart ite
  viewItemCart() async {
    print('[CartController] viewItemCart called');
    statusRequest = StatusRequest.loading;
    update();

    try {
      String userId = myServices.sharedPreferences.getInt("id").toString();
      print('[CartController] Fetching cart for user ID: $userId');
      var response = await cartData.cartView(userId);
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
        }, (successResponse) {
          statusRequest = handlingData(successResponse);
          if (statusRequest == StatusRequest.success && successResponse["status"] == "success") {
            List dataResponse = successResponse["datacart"];
            Map dataResponsePriceCount = successResponse["countprice"];
            cartProduct.clear();
            cartProduct.addAll(dataResponse.map((e) => MyCartModel.fromJson(e)));
            subTotalPrice = double.parse(dataResponsePriceCount["totalprice"].toString());
            totalCount = int.parse(dataResponsePriceCount["totalcount"].toString());
            // SYNC OPTIMISTIC COUNTS WITH SERVER DATA - ADD THIS
            for (var item in cartProduct) {
              if (item.itemsId != null) {
                optimisticCounts[item.itemsId.toString()] = item.countItems ?? 0;
                print('Synced optimistic count for item ${item.itemsId}: ${item.countItems}');
              }
            }
          }
          update();
        },
      );
    } catch (e) {
      print('[CartController] Exception in viewItemCart: $e');
      statusRequest = StatusRequest.serverfailure;
      update();
    }

  }


  goToProductDetailsFromCart(MyCartModel cartItem){

    // Create ItemsModel from MyCartModel
    ItemsModel itemsModel = ItemsModel(
      itemsId: cartItem.itemsId,
      itemsName: cartItem.itemsName,
      itemsNameAr: cartItem.itemsNameAr,
      itemsDesc: cartItem.itemsDesc,
      itemsDescAr: cartItem.itemsDescAr,
      itemsImage: cartItem.itemsImage,
      itemsCount: cartItem.itemsCount,
      itemsActive: cartItem.itemsActive,
      itemsPrice: cartItem.itemsPrice,
      itemsDiscount: cartItem.itemsDiscount,
      itemsDate: cartItem.itemsDate,
      itemsCat: cartItem.itemsCat,
      //categoriesName: cartItem.categoriesName, // Note: This might be null in MyCartModel
      //categoriesNameAr: cartItem.categoriesNameAr, // This might be null too
      // categoriesId, categoriesImage, categoriesDatetime, favorite will be null
      // but that's okay as they might be fetched in product details
    );

    Get.toNamed(AppRoute.productDetails, arguments: {
      'itemsModel': itemsModel,
      'isFavorite': false, // You might want to fetch this separately
    });

  }




  checkPromo() async {
    try {
      var response = await cartData.checkCoupon(promoController!.text);

      response.fold(
            (failure) {
          // This 'failure' is for network or server connection errors.
          clearCoupon();
          promoController!.clear();
          Get.snackbar(
            'Error',
            'Could not connect to the server.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        },
            (successResponse) {
          if (successResponse["status"] == "success") {
            // --- THIS IS A VALID PROMO CODE ---
            Map<String, dynamic> dataResponse = successResponse["data"];
            couponModel = CouponModel.fromJson(dataResponse);
            couponDiscount = couponModel!.couponDiscount!.toDouble();
            couponName = couponModel!.couponName;
            couponId = couponModel!.couponId;
            promoCode=couponName;

            promoController!.clear();
            Get.snackbar(
              'Success',
              'Promo code applied successfully!',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green,
              colorText: Colors.white,
            );
          } else {
            // --- THIS IS AN INVALID PROMO CODE ---
            // The server responded successfully but told us the code is bad.
            clearCoupon();
            promoController!.clear();
            Get.snackbar(
              'Invalid Promo Code',
              successResponse["message"] ?? 'The promo code you entered is invalid',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.orange[400],
              colorText: Colors.white,
              duration: Duration(seconds: 3),
            );
          }
        },
      );
    } catch (e) {
      // This handles any other unexpected errors during the process.
      clearCoupon();
      promoController!.clear();
      Get.snackbar(
        'Network Error',
        'An unexpected error occurred.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }

    // We only need one update() call at the end to refresh the UI with the
    // new discount values (or to clear them).
    update();
  }
  // Add this method to your CartController class

void clearCoupon() {
    couponModel = null;
  couponDiscount = 0;
  couponName = null;

  update();
}




  @override
  void onInit() {

    viewItemCart();
    promoController = TextEditingController();
    super.onInit();
  }









  // Removed getter, using method instead







  // Methods for calculations instead of getters


  double calculateDiscount() {
   return subTotalPrice * (couponDiscount! / 100);
  }

  double calculateTotal() {
    totalPrice = subTotalPrice - calculateDiscount();
    return totalPrice;
  }



  void removeItem( item) {
    final index = cartProduct.indexOf(item);
    cartProduct.remove(item);
    update();

    // Show undo snackbar
    Get.snackbar(
      'Item Removed',
      '${item.name} removed from cart',
      snackPosition: SnackPosition.BOTTOM,
      mainButton: TextButton(
        onPressed: () {
          // Undo remove action
          cartProduct.insert(index, item);
          update();
          Get.closeCurrentSnackbar();
        },
        child: const Text('UNDO'),
      ),
      duration: const Duration(seconds: 3),
    );
  }
  // Item removal with undo functionality

  // Promo code application
// Promo code application - SIMPLE
  void applyPromoCode() {
    final code = promoController!.text.trim();

    if (code.isEmpty&&couponModel != null) {
      Get.snackbar(
        'Error',
        'Please enter a promo code',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange[400],
        colorText: Colors.white,
      );
      return;
    }
    checkPromo();
  }



  // Get item count
  int getItemCount() {
    return cartProduct.length;
  }

  // goToMainScreen() {
  //   Get.to(() => MainScreen());
  //
  // }


  goToCheckout(){
    List<String> itemsName = cartProduct.map((item) => item.itemsName ?? '').toList();

    Get.toNamed(AppRoute.checkout, arguments: {
      'subTotalPrice': subTotalPrice,
      'itemsName': itemsName,
      'couponId' : couponId,
      'couponName' : couponName,
      'totalPrice' : totalPrice,
      'couponDiscount' : couponDiscount,



    });
  }


  @override
  void onClose() {
    promoController!.dispose();
    super.onClose();
  }

  @override
  void onReady() {
    // This runs every time the controller becomes active
    viewItemCart();

  }












}