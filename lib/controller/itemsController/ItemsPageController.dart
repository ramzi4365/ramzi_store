


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ramzi_store/core/services/services.dart';
import 'package:ramzi_store/data/model/cartModel.dart';
import 'package:ramzi_store/data/model/itemsModel.dart';
import '../../core/class/statusRequest.dart';
import '../../core/constant/routes.dart';

import '../../core/functions/handlingData.dart';
import '../../data/dataSource/remote/homePageData.dart';
import '../../data/dataSource/remote/itemsData.dart';
import '../../data/model/categoriesModel.dart';
import '../../data/model/searchModel.dart';

abstract class ItemsPageController extends GetxController{

  initialData();
  selectCategory(int index,String categoriesType);
  getItems(String categoryId);
  goToProductDetails(ItemsModel itemsModel ,bool isFavorite);
  goToCart();
}


class ItemsPageControllerImp extends ItemsPageController {
  MyServices myServices  = Get.find();

  int? selectedCateg;
  List<CategoriesModel> categories = [];
  List<ItemsModel> items = [];

  late StatusRequest statusRequest;
  String? categoryId;
  String? categoriesType;
  ItemsData itemsData = ItemsData(Get.find());




  // ========================= searchcotroller=======================================


  List<ItemsModel> searchItems = [];
  HomePageData searchData = HomePageData(Get.find());
  TextEditingController? searchController ;
  bool isSearch = false;





  checkSearch(String val) async {
    if (val.isNotEmpty){
      isSearch = true;
      statusRequest = StatusRequest.loading;
      update();

      try {
        var response = await searchData.searchData(val);
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


///////////////////////////////////////////////////////////////////////////////////////////////////////




  @override
  getItems(categoryId) async {

    statusRequest = StatusRequest.loading;
    update();
    try {
      var response = await itemsData.postData(
          categoryId,myServices.sharedPreferences.getInt("id").toString());

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

            Get.defaultDialog(title: "Error", middleText: errorMessage);
          },
              (successResponse) {
            statusRequest = handlingData(successResponse);

            if (statusRequest == StatusRequest.success) {

              // Check if the response has categories data
              if (successResponse['data'] != null) {

                List dataResponse = successResponse['data'];
                items.addAll(dataResponse.map((e) => ItemsModel.fromJson(e)));
                update();

                print("Data fetched successfully");
              } else {
                Get.defaultDialog(
                    title: "Info",
                    middleText: "No categories available"
                );
              }
            } else {
              final errorMessage = successResponse['message'] ??
                  "Failed to fetch data";
              // Get.defaultDialog(
              //     title: "Error",
              //     middleText: errorMessage
              // );
            }
          }
      );
    } catch (e) {

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
    categories = Get.arguments["categories"];
    selectedCateg = Get.arguments["selectedCateg"] ?? 0;
    categoryId = Get.arguments["categoryId"];
    searchController = TextEditingController();
    getItems(categoryId!);

  }



  void onInit() {
    initialData();
    super.onInit();
    update();
  }







  @override
  goToProductDetails(itemsModel , isFavorite) {
    Get.toNamed(AppRoute.productDetails,arguments: {
      "itemsModel" : itemsModel,
      "isFavorite" : isFavorite


    }
    );

  }







int _cartCount = 3;

Set<int> _favoriteProducts = <int>{};


// Getters
int get cartCount => _cartCount;

Set<int> get favoriteProducts => _favoriteProducts;

// Product data




  // Product data - use a Map instead of List
  final Map<String, String> categoriesIcon = {
    'All': '🏠',
    'laptop': '💻',
    'mobile': '📱',
    'camera': '📷',

    'shoes': '👟',
    'dress': '👗',
    'Glassware': '🍷',
  };

  String getCategoryIcon(String? categoryName) {
    return categoriesIcon[categoryName] ?? '🏠'; // default icon
  }



//Filtered products based on selected category
  // Filtered products based on selected category

  List<ItemsModel> get filteredProducts {
    if (selectedCateg == 0) return items;

    String selectedCategory = categories[selectedCateg!].categoriesName!;

    return items
        .where((product) => product.categoriesName == selectedCategory)
        .toList();

  }

// Actions - must call update() manually
void selectCategory(int index,categoriesType) {
  items.clear();
  selectedCateg = index;
  categoryId = categoriesType;
  getItems(categoryId!);
  update();
   // Manually trigger UI update
}

void toggleFavorite(int productIndex) {
  if (_favoriteProducts.contains(productIndex)) {
    _favoriteProducts.remove(productIndex);
  } else {
    _favoriteProducts.add(productIndex);
  }
  update(); // Manually trigger UI update
}



void addToCart() {
  _cartCount++;
  update(); // Manually trigger UI update
}

void showAddToCartSnackbar(String productName) {
  Get.snackbar(
    'Success',
    'Added $productName to cart',
    backgroundColor: Colors.green[600],
    colorText: Colors.white,
    duration: Duration(seconds: 2),
    snackPosition: SnackPosition.BOTTOM,
  );
}

@override
void onClose() {
  searchController!.dispose();
  super.onClose();
}

  @override
  goToCart() {
    // TODO: implement goToCart
    Get.toNamed(AppRoute.cartDetails,arguments: {'fromBottomBar': false});
  }


goToFavorite() {
  // TODO: implement goToCart
  Get.toNamed(AppRoute.myFavorite,arguments: {'fromBottomBar': false});
}
}