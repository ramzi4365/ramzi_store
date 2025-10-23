import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ramzi_store/core/constant/color.dart';
import 'package:ramzi_store/data/model/categoriesModel.dart';
import '../../../controller/itemsController/ItemsPageController.dart';
import '../../../core/functions/translateDatabase.dart';


class CustomCategoriesItemsPage extends StatelessWidget {
  final CategoriesModel categories;
  final bool isSelected;
  final String getCategoryIcon;
  final void Function()? selectCategoryOntap;

  const CustomCategoriesItemsPage({
    super.key,
    required this.categories,
    required this.isSelected,
    required this.getCategoryIcon,
    required this.selectCategoryOntap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: selectCategoryOntap, // Fixed: removed unnecessary arrow function
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
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
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  getCategoryIcon,
                  style: TextStyle(fontSize: 28),
                ),
              ),
            ),
            SizedBox(height: 8),
            Text(
              "${translateDatabase(categories.categoriesNameAr, categories.categoriesName)}",
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
  }
}