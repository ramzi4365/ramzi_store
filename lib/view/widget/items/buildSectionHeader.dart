import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ramzi_store/data/model/itemsModel.dart';

import '../../../controller/itemsController/ItemsPageController.dart';
import '../../../data/model/categoriesModel.dart';
import '../../../testai/itemslistt.dart';

class BuildSectionHeader extends StatelessWidget {




  const BuildSectionHeader({super.key});

  @override
  Widget build(BuildContext context) {
    ItemsPageControllerImp controller = Get.put(ItemsPageControllerImp());

    String selectedCategory =
    controller.selectedCateg == 0
        ? 'All'
        : controller.categories[controller.selectedCateg!].categoriesName!;

    List<ItemsModel> filteredProducts = controller.filteredProducts;

    return Padding(
      padding: EdgeInsets.fromLTRB(24, 16, 24, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                selectedCategory == 'All' ? 'Popular Products' : selectedCategory,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              SizedBox(height: 4),
              Text(
                '${filteredProducts.length} items available',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          Row(
            children: [
              _buildSortButton(Icons.sort, 'Sort'),
              SizedBox(width: 12),
              _buildSortButton(Icons.grid_view, 'View'),
            ],
          ),
        ],
      ),
    );
  }
}


Widget _buildSortButton(IconData icon, String text) {
  return TextButton.icon(
    onPressed: () {},
    icon: Icon(icon, size: 18),
    label: Text(text),
    style: TextButton.styleFrom(
      foregroundColor: Colors.grey[700],
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: Colors.grey[300]!),
      ),
    ),
  );
}