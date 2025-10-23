import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ramzi_store/data/model/cartModel.dart';

import '../core/class/statusRequest.dart';
import '../core/constant/routes.dart';

import '../core/functions/handlingData.dart';
import '../core/services/services.dart';
import '../data/dataSource/remote/addressData.dart';
import '../data/dataSource/remote/checkoutOrder.dart';
import '../data/model/addressModel.dart';
import '../view/widget/checkOut/successDialogWidget.dart';

class CheckoutController extends GetxController {
  // State variables
  int currentStep = -1;
  int selectedAddressIndex = -1;
  int selectedPaymentIndex = -1;
  final TextEditingController promoController = TextEditingController();

  // Order summary values
  late double subTotalPrice;
  double deliveryFee = 0.00; // Free delivery
  double tax = 124.95;
  late double totalPrice;
  late String? couponName;
  late int? couponId;
  late double? couponDiscount;


  MyServices myServices = Get.find();
  List<AddressModel> addresses = [];
  StatusRequest? statusRequest;
  AddressData addressData = AddressData(Get.find());
  CheckoutData checkoutData = CheckoutData(Get.find());
  MyCartModel? cartItems;
 List<String>itemsCartName=[];

  AddressModel? selectedAddress;
  Map<String, dynamic>? selectedPaymentMethod;





  @override
  viewAddress() async {
    statusRequest = StatusRequest.loading;
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
  checkoutOrder() async {
    statusRequest = StatusRequest.loading;

    update();
    Map data = {
      "userid": myServices.sharedPreferences.getInt("id").toString(),
      "addressid": selectedAddress!.addressId.toString(),
      "ordertype": "1",
      "priceDelivery": "20",
      "orderprice": totalPrice.toString(),
      // SAFE CHANGE: If couponId is null, send '0' or an empty string to the API
      "couponid": couponId?.toString() ?? "0",
      "ordeypaymentmethod": "creditcard",
      'couponDiscount': couponDiscount.toString(),
    };

    update();

    try {
      var response = await checkoutData.checkout(data);
      print("API Response: $response");

      // Handle the Either response properly
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
          // This handles Right (success) case - API returned a respon

          // Use handlingData to determine the status from the API response
          statusRequest = handlingData(successResponse);

          if (statusRequest == StatusRequest.success) {
            print("successs============================================");
          }else{
            statusRequest = StatusRequest.none;
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


  // Sample data
  //
  // final List<Map<String, dynamic>> addresses = [
  //   {
  //     'name': 'Home',
  //     'address': '123 Main Street, Apartment 4B',
  //     'city': 'New York, NY 10001',
  //     'phone': '+1 234 567 8900',
  //   },
  //   {
  //     'name': 'Office',
  //     'address': '456 Business Ave, Suite 200',
  //     'city': 'New York, NY 10002',
  //     'phone': '+1 234 567 8901',
  //   },
  // ];

  final List<Map<String, dynamic>> paymentMethods = [
    {
      'name': 'Credit Card',
      'number': '**** **** **** 1234',
      'icon': Icons.credit_card,
      'color': Colors.blue,
    },
    {
      'name': 'PayPal',
      'number': 'john.doe@example.com',
      'icon': Icons.account_balance_wallet,
      'color': Colors.indigo,
    },
    {
      'name': 'Cash on Delivery',
      'number': 'Pay when you receive',
      'icon': Icons.money,
      'color': Colors.green,
    },
  ];

  // Methods
  void updateCurrentStep() {
    if(selectedAddressIndex>=0){
      currentStep = 0;
      update();
    }
    if(selectedPaymentIndex>=0){
      currentStep = 2;
      update();
    }
    update(); // Notify listeners
  }



  void selectAddress(int index) {
    selectedAddressIndex = index;
    selectedAddress = addresses[index];

    // Store the actual address object
    updateCurrentStep();
    update();
  }

  void selectPaymentMethod(int index) {
    selectedPaymentIndex = index;
    selectedPaymentMethod = paymentMethods[index]; // Store the actual payment method
    updateCurrentStep();
    update();
  }

  void applyPromoCode() {
    final String promoCode = promoController.text.trim();
    if (promoCode.isNotEmpty) {
      // Add your promo code logic here
      // For example, apply discount to subtotal
      Get.snackbar(
        'Promo Code Applied',
        'Discount applied successfully!',
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      Get.snackbar(
        'Invalid Code',
        'Please enter a valid promo code',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void placeOrder() {
    // Check if addresses exist
    if (addresses.isEmpty) {
      Get.snackbar(
        'Address Required',
        'Please add a delivery address before placing your order',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange[200],
        colorText: Colors.white,
        duration: Duration(seconds: 3),
        icon: Icon(Icons.warning_amber_rounded, color: Colors.white),
      );
      return; // Stop execution
    }

    // Check if an address is selected
    if (selectedAddressIndex < 0 || selectedAddressIndex >= addresses.length) {
      Get.snackbar(
        'Address Not Selected',
        'Please select a delivery address',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange[200],
        colorText: Colors.white,
      );
      return; // Stop execution
    }

    if (selectedPaymentIndex < 0 || selectedPaymentIndex >= paymentMethods.length) {
      Get.snackbar(
        'Payment Not Selected',
        'Please select a Payment Method',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      return; // Stop execution
    }

    checkoutOrder();
    // If everything is valid, proceed with order placement
    HapticFeedback.lightImpact();

    Get.dialog(
      SuccessDialogWidget(
        onContinueShopping: () {
          Get.back(); // Close dialog
          Get.offAllNamed(AppRoute.homePage); // Go back to previous screen
        },
        onTrackOrder: () {
          Get.back(); // Close dialog
          Get.toNamed(AppRoute.trackOrder); // Go to track order page

        },
      ) as Widget,
      barrierDismissible: false,
    );
  }

  // Format methods for display
  String getFormattedSubtotal() {
    return '\$${subTotalPrice.toStringAsFixed(2)}';
  }

  String getFormattedDeliveryFee() {
    return deliveryFee == 0 ? 'Free' : '\$${deliveryFee.toStringAsFixed(2)}';
  }

  String getFormattedTax() {
    return '\$${tax.toStringAsFixed(2)}';
  }

  String getFormattedTotal() {
    return '\$${totalPrice.toStringAsFixed(2)}';
  }

getCartArgemnt(){
  itemsCartName = Get.arguments['itemsName'] ?? []; // Default to an empty list
  subTotalPrice = Get.arguments['subTotalPrice'] ?? 0.0; // Default to 0.0
  couponId = Get.arguments['couponId']; // This can be null, which is now OK
  couponName = Get.arguments['couponName']; // This can also be null
  totalPrice = Get.arguments['totalPrice'] ?? 0.0;
  couponDiscount = Get.arguments['couponDiscount'] ?? 0.0;



}

  goToAddNewAddress(){
    Get.toNamed(AppRoute.addressAdd)?.then((_) {
      // This runs when you return from the add address page
      viewAddress();
    });
  }

  @override
  void onClose() {
    promoController.dispose();
    super.onClose();
  }


  @override
  void onInit() {
    viewAddress();
    getCartArgemnt();
    super.onInit();

  }

}