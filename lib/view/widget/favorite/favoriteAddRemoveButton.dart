import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/model/myFavoriteModel.dart';

class FavoriteActionButtons extends StatelessWidget {
  final MyFavoriteModel item;

  final VoidCallback onRemovePressed;
  final VoidCallback onAddToCartPressed;

  const FavoriteActionButtons({
    super.key,
    required this.item,

    required this.onRemovePressed,
    required this.onAddToCartPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Remove from favorites button
        InkWell(
          onTap: onRemovePressed,
          borderRadius: BorderRadius.circular(6),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(
              Icons.favorite,
              size: 18,
              color: Colors.red[400],
            ),
          ),
        ),
        const SizedBox(width: 8),

        // Add to cart button
        InkWell(
          onTap: item.itemsActive==1 ? onAddToCartPressed : null,
          borderRadius: BorderRadius.circular(6),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: item.itemsActive==1 ? Theme.of(context).primaryColor : Colors.grey[300],
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(
              Icons.shopping_cart_outlined,
              size: 18,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}