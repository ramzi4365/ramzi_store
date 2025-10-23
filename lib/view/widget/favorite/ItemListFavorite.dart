import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ramzi_store/data/model/cartModel.dart';
import 'package:ramzi_store/data/model/myFavoriteModel.dart';
import 'package:ramzi_store/view/widget/favorite/favoriteAddRemoveButton.dart';
import 'package:ramzi_store/view/widget/favorite/outOfStockTagFavo.dart';
import 'package:ramzi_store/view/widget/favorite/ratingTagFavorite.dart';
import 'package:ramzi_store/view/widget/favorite/reviewTagFavorite.dart';

import '../../../linkApi.dart';

class FavoriteListItemWidget extends StatelessWidget {
  final MyFavoriteModel item;

  final VoidCallback onRemovePressed;
  final VoidCallback onAddToCartPressed;
  final VoidCallback onDismissed;

  const FavoriteListItemWidget({
    super.key,
    required this.item,

    required this.onRemovePressed,
    required this.onAddToCartPressed,
    required this.onDismissed,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(item.itemsId.toString()),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: Colors.red[400],
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(Icons.delete_outline, color: Colors.white, size: 24),
      ),
      onDismissed: (direction) => onDismissed(),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Product Image
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[100],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: "${AppiLink.imageItems}/${item.itemsImage}",
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
            const SizedBox(width: 12),

            // Product Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${item.itemsName}",
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      height: 1.3,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      RatingTag(rating: 4.5),
                      const SizedBox(width: 6),
                      ReviewTag(reviews: 100),
                      if (item.itemsActive==1) ...[
                        const SizedBox(width: 6),
                        const OutOfStockTag(),
                      ],
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (item.itemsPrice != null)  //item.oldPrice != null
                            Text(
                              '\$${item.itemsPrice!.toStringAsFixed(2)}',  //item.oldPrice!.toStringAsFixed(2)
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[500],
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          Text(
                            '\$${item.itemsPrice!.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ],
                      ),
                      FavoriteActionButtons(
                        item: item,

                        onRemovePressed: onRemovePressed,
                        onAddToCartPressed: onAddToCartPressed,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}