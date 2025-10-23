import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ramzi_store/controller/homePageController.dart';

import 'package:ramzi_store/data/model/categoriesModel.dart';

import '../../../../core/functions/translateDatabase.dart';

class CategorySectionWidget extends StatelessWidget {
  final HomePageControllerImp controller;

  const CategorySectionWidget({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomePageControllerImp>( // Add GetBuilder here
      builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Categories',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('See all'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.categories.length,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemBuilder: (context, index) {
                  final category = controller.categories[index];
                  final isSelected = controller.selectedCateg == index;

                  return GestureDetector(
                    onTap: () {
                      controller.changeCateg(index);
                      controller.goToItems(
                        controller.categories,
                        index,
                        category.categoriesId.toString(),
                      );
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        children: [
                          Container(
                            width: 64,
                            height: 64,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Theme.of(context).primaryColor
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: isSelected
                                      ? Theme.of(context).primaryColor.withOpacity(0.3)
                                      : Colors.black.withOpacity(0.05),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                _getCategoryIcon(category.categoriesName),
                                style: const TextStyle(fontSize: 28),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            translateDatabase(category.categoriesNameAr, category.categoriesName),
                            style: TextStyle(
                              color: isSelected
                                  ? Theme.of(context).primaryColor
                                  : Colors.grey[600],
                              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  String _getCategoryIcon(String? categoryName) {
    final Map<String, String> categoriesIcon = {
      'All': '🏠',
      'laptop': '💻',
      'mobile': '📱',
      'camera': '📷',
      'shoes': '👟',
      'dress': '👗',
      'Glassware': '🍷',
    };

    return categoriesIcon[categoryName] ?? '🛍️';
  }
}