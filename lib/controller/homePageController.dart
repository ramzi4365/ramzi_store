import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ramzi_store/core/services/services.dart';
import 'package:ramzi_store/linkApi.dart';

import '../core/class/statusRequest.dart';
import '../core/constant/routes.dart';

import '../core/functions/handlingData.dart';
import '../data/dataSource/remote/homePageData.dart';
import '../data/model/categoriesModel.dart';
import '../data/model/itemsModel.dart';



abstract class HomePageController extends GetxController {
  initialData();
  getData();
  goToItems(List categories , int selectedCateg,String categoryId);

  PageController get carouselController;

  int get currentCarouselIndex;
  List<Map<String, dynamic>> get promoData;

}

class HomePageControllerImp extends HomePageController {

  String? lang;

  MyServices myServices = Get.find();
  late StatusRequest statusRequest;
  List <CategoriesModel>categories = [];
  List<ItemsModel> homeItems = [];
  List<ItemsModel> searchItems = [];


  HomePageData homePageData = HomePageData(Get.find());
  HomePageData searchData = HomePageData(Get.find());

  TextEditingController? searchController ;
  final PageController carouselController = PageController();
  int currentCarouselIndex = 0;
  int selectedCateg = 0;
  bool isSearch = false;



  changeCateg(int i){
    selectedCateg = i;
    update();
  }



  checkSearch(String val) async {
    if (val.isNotEmpty){
      isSearch = true;
      statusRequest = StatusRequest.loading;

      update();

      try {
        var response = await searchData.searchData(searchController!.text);
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
                // Check if the response has categories data
                if (successResponse['data'] != null) {
                  List itemResponse = successResponse['data'];
                  searchItems.clear();
                  searchItems.addAll(
                      itemResponse.map((e) => ItemsModel.fromJson(e)));
                }
              } else {
                final errorMessage = successResponse['message'] ??
                    "Failed to fetch data";

              }
            }
        );
      } catch (e) {
        print("Error in getData: $e");
        statusRequest = StatusRequest.serverfailure;
        Get.defaultDialog(
            title: "Error",
            middleText: "An unexpected error occurred"
        );
      }

    }else
      {
        isSearch = false;
        searchItems.clear();
        searchController?.clear();
        update();

        //getData();
      }
    update();
  }


  @override
  getData() async {
    statusRequest = StatusRequest.loading;
    update();

    try {
      var response = await homePageData.postData();

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
              // Check if the response has categories data
              if (successResponse['categories'] != null) {
                List categoryResponse = successResponse['categories'];
                categories.addAll(
                    categoryResponse.map((e) => CategoriesModel.fromJson(e)));
                List itemResponse = successResponse['items'];

                homeItems.addAll(
                    itemResponse.map((e) => ItemsModel.fromJson(e)));
              } else {
                Get.defaultDialog(
                    title: "Info",
                    middleText: "No categories available"
                );
              }
            } else {
              final errorMessage = successResponse['message'] ??
                  "Failed to fetch data";
              Get.defaultDialog(
                  title: "Error",
                  middleText: errorMessage
              );
            }
          }
      );
    } catch (e) {
      print("Error in getData: $e");
      statusRequest = StatusRequest.serverfailure;
      Get.defaultDialog(
          title: "Error",
          middleText: "An unexpected error occurred"
      );
    }
    update();
  }


  @override
  initialData() {
    lang = myServices.sharedPreferences.getString("lang");
    searchController = TextEditingController();
    // Initialize any data you need here

  }

  @override
  void onInit() {
    initialData();
    getData(); // Fetch data when controller initializes
    startCarouselAutoScroll();
    super.onInit();
  }

  @override
  goToItems(categories, int selectedCateg, String categoryId) {
    Get.toNamed(AppRoute.items, arguments: {
      "categories": categories,
      "selectedCateg": selectedCateg,
      "categoryId": categoryId
    });
  }


  // Add this method to your controller class

  int calculateDiscountedPrice(int? price, int? discount) {
    if (price == null) return 0;
    if (discount == null || discount <= 0) return price;

    // Calculate as double then round to int
    final discountedPrice = price - (price * discount / 100);
    return discountedPrice.round(); // or .floor() or .ceil() depending on your needs
  }

// Optional: Method to check if product has discount
  bool hasDiscount(int? discount) {
    return discount != null && discount > 0;
  }

// Optional: Method to check if product is new
  bool isNewProduct(int? activeStatus) {
    return activeStatus == 1;
  }
// Add this method to your HomePageControllerImp class
  String getCategoryIcon(String? categoryName) {
    final Map<String, String> categoriesIcon = {
      'All': '🏠',
      'laptop': '💻',
      'mobile': '📱',
      'camera': '📷',
      'shoes': '👟',
      'dress': '👗',
      'Glassware': '🍷',
    };

    return categoriesIcon[categoryName] ?? '🛍️'; // Default icon
  }
  // Enhanced Mock Data
  final List<Map<String, dynamic>> promoData = [
    {
      'image': 'https://via.placeholder.com/400x200/FF6B6B/FFFFFF?text=Summer+Sale',
      'title': 'Summer Collection',
      'subtitle': 'Up to 50% off on selected items',
      'color': const Color(0xFFFF6B6B),
    },
    {
      'image': 'https://via.placeholder.com/400x200/4ECDC4/FFFFFF?text=New+Arrivals',
      'title': 'New Arrivals',
      'subtitle': 'Check out the latest trends',
      'color': const Color(0xFF4ECDC4),
    },
    {
      'image': 'https://via.placeholder.com/400x200/45B7D1/FFFFFF?text=Electronics',
      'title': 'Tech Deals',
      'subtitle': 'Best prices on electronics',
      'color': const Color(0xFF45B7D1),
    },
    {
      'image': 'https://via.placeholder.com/400x200/F7B731/FFFFFF?text=Free+Shipping',
      'title': 'Free Shipping',
      'subtitle': 'On orders over \$50',
      'color': const Color(0xFFF7B731),
    },
  ];







  void startCarouselAutoScroll() {
    Future.delayed(const Duration(seconds: 3), () {
      if (carouselController.hasClients) {
        int nextPage = (currentCarouselIndex + 1) % promoData.length;
        carouselController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
        startCarouselAutoScroll();
      }
    });
  }

  void updateCarouselIndex(int index) {
    currentCarouselIndex = index;
    update();
  }

  @override
  void onClose() {
    searchController!.dispose();
    carouselController.dispose();
    super.onClose();
  }



  goToProductDetails(itemsModel,isFavorite) {
    Get.toNamed(AppRoute.productDetails,arguments: {
      "itemsModel" : itemsModel,
      "isFavorite" : isFavorite,



    }
    );

  }


}


