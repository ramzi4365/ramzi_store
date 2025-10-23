import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/homePageController.dart';
import '../../../../controller/itemsController/ItemsPageController.dart';
import '../../../../core/class/handlingDataView.dart';

import '../../../../data/model/itemsModel.dart';

import '../../../../linkApi.dart';

import '../../../core/functions/translateDatabase.dart';
import 'emptyItemsWidget.dart';

class CustomSearchItems extends StatelessWidget {
  final List<ItemsModel> searchItems;

  const CustomSearchItems({super.key,required this.searchItems});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ItemsPageControllerImp>(
      builder: (controller) => HandlingDataViewWithEmpty(
        statusRequest: controller.statusRequest!,
        isEmpty: controller.searchItems.isEmpty,
        emptyWidget: EmptyItemsWidget(onExplorePressed: () {}),
        widget: ListView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          itemCount: controller.searchItems.length,
          itemBuilder: (context, index) {
            return _buildSearchItem(
              context,
              searchItems[index],
              index,
              controller,
            );
          },
        ),
      ),
    );
  }

  Widget _buildSearchItem(
      BuildContext context,
      ItemsModel searchitems,
      int index,
      ItemsPageControllerImp controller,
      ) {
    return GestureDetector(
      onTap: () {
        controller.goToProductDetails(searchitems, false);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 12,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Container(
              width: 100,
              height: 100,
              margin: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                  imageUrl: "${AppiLink.imageItems}/${searchItems.elementAt(index).itemsImage}",
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                  errorWidget: (context, error, stackTrace) {
                    return Center(
                      child: Icon(
                        Icons.image_not_supported,
                        color: Colors.grey[400],
                        size: 30,
                      ),
                    );
                  },
                ),
              ),
            ),

            // Product Details
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 12, 12, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Category and Name
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${translateDatabase(searchitems.categoriesNameAr, searchitems.categoriesName)}",
                          style: TextStyle(
                            color: Theme.of(context).primaryColor.withOpacity(0.7),
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "${translateDatabase(searchitems.itemsNameAr, searchitems.itemsName)}",
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.black87,
                            height: 1.2,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),

                    // Rating and Price
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              size: 16,
                              color: Colors.amber,
                            ),
                            const SizedBox(width: 4),
                            const Text(
                              "4.8",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(width: 4),
                            const Text(
                              '(123)',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '\$${searchitems.itemsPrice!.toStringAsFixed(2)}',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
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
}