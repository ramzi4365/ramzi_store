import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ramzi_store/view/screen/cartIDetails.dart';

import '../view/screen/homePage.dart';


import '../view/screen/mainScreen.dart';
import '../view/screen/myFavorite.dart';
import '../view/screen/profileDrawer.dart';


class MainScreenController extends GetxController {
  // Index for navigation
  int currentIndex = 0;

  // Cart items count
  int cartItemCount = 3;



  // List of pages
  final List<Widget> pages = [
    const HomePage(),
    const CartDetails(),
    const MyFavorite(),
    const ProfileDrawer(),
  ];

  // Method to change the current page
  void changePage(int index) {
    currentIndex = index;
    update(); // Manually trigger UI update
  }

  // Method to update cart badge count
  void updateCartCount(int count) {
    cartItemCount = count;
    update(); // Manually trigger UI update
  }

  // Method to increment cart count
  void incrementCartCount() {
    cartItemCount++;
    update(); // Manually trigger UI update
  }

  // Method to decrement cart count
  void decrementCartCount() {
    if (cartItemCount > 0) {
      cartItemCount--;
      update(); // Manually trigger UI update
    }
  }
}

goToMainScreen() {
  Get.to(() => MainScreen());

}