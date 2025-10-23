import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  // State variables (no .obs, just regular variables)
  int _cartCount = 3;
  int _selectedCategoryIndex = 0;
  Set<int> _favoriteProducts = <int>{};
  final TextEditingController searchController = TextEditingController();

  // Getters
  int get cartCount => _cartCount;
  int get selectedCategoryIndex => _selectedCategoryIndex;
  Set<int> get favoriteProducts => _favoriteProducts;

  // Product data
  final List<Map<String, dynamic>> categories = [
    {'name': 'All', 'icon': '🏠'},
    {'name': 'Laptop', 'icon': '💻'},
    {'name': 'Mobile', 'icon': '📱'},
    {'name': 'Camera', 'icon': '📷'},
    {'name': 'Shoes', 'icon': '👟'},
    {'name': 'Dress', 'icon': '👗'},
    {'name': 'Glassware', 'icon': '🍷'},
  ];

  final List<Map<String, dynamic>> products = [
    {
      'name': 'MacBook Pro 16"',
      'price': 2399.99,
      'category': 'Laptop',
      'imageUrl': 'https://picsum.photos/250/200?random=1',
      'rating': 4.8,
      'reviews': 324,
      'description': 'Powerful laptop for professionals',
    },
    {
      'name': 'iPhone 14 Pro',
      'price': 999.99,
      'category': 'Mobile',
      'imageUrl': 'https://picsum.photos/250/200?random=2',
      'rating': 4.9,
      'reviews': 1203,
      'description': 'Latest flagship smartphone',
    },
    {
      'name': 'Canon EOS R5',
      'price': 3899.99,
      'category': 'Camera',
      'imageUrl': 'https://picsum.photos/250/200?random=3',
      'rating': 4.7,
      'reviews': 89,
      'description': 'Professional mirrorless camera',
    },
    {
      'name': 'Nike Air Max',
      'price': 129.99,
      'category': 'Shoes',
      'imageUrl': 'https://picsum.photos/250/200?random=4',
      'rating': 4.6,
      'reviews': 456,
      'description': 'Comfortable running shoes',
    },
    {
      'name': 'Floral Summer Dress',
      'price': 59.99,
      'category': 'Dress',
      'imageUrl': 'https://picsum.photos/250/200?random=5',
      'rating': 4.5,
      'reviews': 234,
      'description': 'Elegant summer collection',
    },
    {
      'name': 'Crystal Wine Set',
      'price': 89.99,
      'category': 'Glassware',
      'imageUrl': 'https://picsum.photos/250/200?random=6',
      'rating': 4.8,
      'reviews': 67,
      'description': 'Premium crystal glassware',
    },
  ];

  // Filtered products based on selected category
  List<Map<String, dynamic>> get filteredProducts {
    if (_selectedCategoryIndex == 0) {
      return products;
    } else {
      String selectedCategory = categories[_selectedCategoryIndex]['name'];
      return products.where((product) => product['category'] == selectedCategory).toList();
    }
  }

  // Actions - must call update() manually
  void selectCategory(int index) {
    _selectedCategoryIndex = index;
    update(); // Manually trigger UI update
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
    searchController.dispose();
    super.onClose();
  }
}


