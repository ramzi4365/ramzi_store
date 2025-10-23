import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ramzi_store/core/constant/routes.dart';

import '../../controller/favorite/addRemovFavorite.dart';
import '../../controller/favorite/myfavoriteController.dart';
import '../../core/class/handlingDataView.dart';
import '../widget/favorite/ItemListFavorite.dart';

import '../widget/favorite/emptyFavoritesWidget.dart';

class MyFavorite extends GetView<MyFavoriteControllerImp> {
  const MyFavorite({super.key});


  @override
  Widget build(BuildContext context) {
    Get.put(MyFavoriteControllerImp());
    AddRemoveFavoriteControllerImp  ddRemoveFavoriteController = Get.put(AddRemoveFavoriteControllerImp());
    final bool fromBottomBar = Get.arguments?['fromBottomBar'] ?? true;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: Column(
          children: [
            Text(
              'My Favorites',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),GetBuilder<MyFavoriteControllerImp>(builder: (controller)=>Text(
              '${controller.favoriteItems.length} items',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
                fontWeight: FontWeight.normal,
              ),
            ),)

          ],
        ),
        centerTitle: true,
        leading: fromBottomBar?null:IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Theme.of(context).primaryColor, size: 20),
          onPressed: () => Get.back(),
        ),
      ),
      body: HandlingDataViewWithEmpty(
      statusRequest: controller.statusRequest!,
      isEmpty: controller.favoriteItems.isEmpty,
      emptyWidget: EmptyFavoritesWidget(onExplorePressed: () {}),
      widget: _buildFavoritesList(ddRemoveFavoriteController),
    ),

    );
  }


  Widget _buildFavoritesList(AddRemoveFavoriteControllerImp ddRemoveFavoriteController) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: controller.favoriteItems.length,
      itemBuilder: (context, index) {
        final item = controller.favoriteItems[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: FavoriteListItemWidget(
            item: item,
            onRemovePressed: () => controller.removeFromFavorites(item, () {
              ddRemoveFavoriteController.addFavorite(item.itemsId.toString());
            }),
            onAddToCartPressed:()=> controller.moveToCart(item),
            onDismissed: () => controller.removeFromFavorites(item, () {
              ddRemoveFavoriteController.addFavorite(item.itemsId.toString());
            }),
          ),
        );
      },
    );
  }

}
