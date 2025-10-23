import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/itemsController/ItemsPageController.dart';
import '../widget/homePage/new/searchBar.dart';
import '../widget/items/appBarheaderItems.dart';
import '../widget/items/buildSectionHeader.dart';
import '../widget/items/customCategoriesItemsPage.dart';
import '../widget/items/customListItems.dart';
import '../widget/items/searchLitItems.dart';

class Items extends StatelessWidget {
  const Items({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ItemsPageControllerImp());

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: GetBuilder<ItemsPageControllerImp>(
        builder: (controller) => SafeArea(
          child: Column(
            children: [
              // Header Section
              HeaderAppBarItems(
                onPressedNotification: () {},
                onPressedFavorite: () {
                  controller.goToFavorite();
                },
                onPressedCart: () {
                  controller.goToCart();
                },
              ),
              const SizedBox(height: 20),
              SearchBarWidget(
                controller: controller.searchController!,
                onFilterPressed: () {},
                onChanged: (value) {
                  controller.checkSearch(value);
                },
                onSubmitted: (value) {
                  controller.checkSearch(value);
                },
              ),
              const SizedBox(height: 20),

              // Conditional rendering based on search state
              if (controller.isSearch)
                controller.searchItems.isEmpty
                    ? Expanded(
                  child: Center(child: Text("No results found")),
                )
                    : Expanded(
                  child: CustomSearchItems(
                    searchItems: controller.searchItems,
                  ),
                )
              else
                Expanded(
                  child: Column(
                    children: [
                      // Category Navigation
                      _buildCategoryList(controller),
                      const SizedBox(height: 20),
                      // Products Section Header
                      BuildSectionHeader(),
                      const SizedBox(height: 20),
                      // Product Display Section
                      Expanded(
                        child: Customlistitems(controller: controller),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  // Fixed category list method
  Widget _buildCategoryList(ItemsPageControllerImp controller) {
    return Container(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: controller.categories.length,
        padding: EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (context, index) {
          final category = controller.categories[index];
          final isSelected = controller.selectedCateg == index;
          return CustomCategoriesItemsPage(
            categories: category,
            isSelected: isSelected,
            getCategoryIcon: controller.getCategoryIcon(category.categoriesName),
            selectCategoryOntap: () {
              controller.selectCategory(index, controller.categories[index].categoriesId.toString());
            },
          );
        },
      ),
    );
  }
}