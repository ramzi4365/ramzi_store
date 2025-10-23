import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ramzi_store/data/model/itemsModel.dart';
import 'package:ramzi_store/view/widget/items/emptyItemsWidget.dart';
import '../../../controller/itemsController/ItemsPageController.dart';
import '../../../controller/favorite/addRemovFavorite.dart';
import '../../../core/class/handlingDataView.dart';

import '../../../core/functions/translateDatabase.dart';
import '../../../linkApi.dart';

class Customlistitems extends StatelessWidget {
  ItemsPageControllerImp controller ;
  Customlistitems({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    AddRemoveFavoriteControllerImp favoriteController = Get.put(AddRemoveFavoriteControllerImp());

    return GetBuilder<ItemsPageControllerImp>(

        builder: (controller)=>HandlingDataViewWithEmpty(
            statusRequest: controller.statusRequest,
            isEmpty: controller.filteredProducts.isEmpty,
            emptyWidget: EmptyItemsWidget(onExplorePressed: (){}),
            widget
        : GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.58,
        crossAxisSpacing: 16,
        mainAxisSpacing: 20,
      ),
      itemCount: controller.filteredProducts.length,
      itemBuilder: (context, index) {
        return _buildProductCard(
            context,
            controller.filteredProducts[index],
            index,
            controller,
            favoriteController
        );
      },
            ))) ;
  }

  Widget _buildProductCard(
      BuildContext context,
      ItemsModel itemsModel,
      int index,
      ItemsPageControllerImp controller,
      AddRemoveFavoriteControllerImp favoriteController
      ) {


    return GestureDetector(
      onTap: () {
        controller.goToProductDetails(itemsModel, favoriteController.isfavorite[itemsModel.itemsId.toString()] == '1');
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image with Favorite Button
            Stack(
              children: [
                Container(
                  height: 130,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: "${AppiLink.imageItems}/${itemsModel.itemsImage}",
                      fit: BoxFit.fill,
                      width: double.infinity,
                      height: 80,
                      errorWidget: (context, error, stackTrace) {
                        return Center(
                          child: Icon(
                            Icons.image_not_supported,
                            color: Colors.grey[400],
                            size: 40,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Positioned(
                    top: 8,
                    right: 8,
                    child: GetBuilder<AddRemoveFavoriteControllerImp>(
                        builder: (favoriteController) {
                          bool isFavorite = favoriteController.isfavorite[
                          itemsModel.itemsId.toString()] ==
                              '1';

                          return
                            GestureDetector(
                              onTap: () {
                                if (isFavorite) {
                                  favoriteController.setFavorite(
                                      itemsModel.itemsId.toString(), "0");
                                  favoriteController.removeFavorite(
                                      itemsModel.itemsId.toString());

                                } else {
                                  favoriteController.setFavorite(
                                      itemsModel.itemsId.toString(), "1");
                                  favoriteController.addFavorite(
                                      itemsModel.itemsId.toString());


                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.9),
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 8,
                                    ),
                                  ],
                                ),
                                child: AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 200),
                                  child: Icon(
                                    isFavorite ? Icons.favorite : Icons
                                        .favorite_border,
                                    key: ValueKey(isFavorite),
                                    color: isFavorite
                                        ? Theme
                                        .of(context)
                                        .colorScheme
                                        .secondary
                                        : Colors.grey[600],
                                    size: 18,
                                  ),
                                ),
                              ),
                            );

                        }
                    )),
                // Discount Badge
                if (index % 3 == 0)
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        '-20%',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
              ],
            ),

            // Product Info
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Product details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${translateDatabase(itemsModel.categoriesNameAr, itemsModel.categoriesName)}",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor.withOpacity(0.6),
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            "${translateDatabase(itemsModel.itemsNameAr, itemsModel.itemsName)}",
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              color: Colors.black87,
                              height: 1.2,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                size: 15,
                                color: Colors.amber,
                              ),
                              const SizedBox(width: 2),
                              const Text(
                                "4.8",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(width: 2),
                              const Text(
                                '(123)',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Price and button
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '\$${itemsModel.itemsPrice!.toStringAsFixed(2)}',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          width: double.infinity,
                          height: 30,
                          child: ElevatedButton(
                            onPressed: () {
                              controller.addToCart();
                              _showAddToCartAnimation(context, itemsModel);
                            },
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.add_shopping_cart, size: 5),
                                //SizedBox(width: 4),
                                Text(
                                  'Add to cart',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddToCartAnimation(BuildContext context, ItemsModel itemsModel) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Added ${itemsModel.itemsName} to cart',
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
            TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
              child: const Text(
                'VIEW CART',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.green[600],
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}