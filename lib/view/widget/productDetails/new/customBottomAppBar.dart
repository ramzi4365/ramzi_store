import 'package:flutter/material.dart';
import 'package:ramzi_store/core/constant/color.dart';
import 'package:ramzi_store/data/model/itemsModel.dart';

class ProductBottomBar extends StatelessWidget {
  final ItemsModel product;
  final bool isFavorite;
  final bool isAddingToCart;
  final int quantity;
  final VoidCallback onToggleFavorite;
  final VoidCallback onAddToCart;

  const ProductBottomBar({
    super.key,
    required this.product,
    required this.isFavorite,
    required this.isAddingToCart,
    required this.quantity,
    required this.onToggleFavorite,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      padding: const EdgeInsets.only(bottom: 20, left: 0, right: 0, top: 0),
      child: SafeArea(
        child: Row(
          children: [
            // Favorite Button
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: isFavorite
                    ? Colors.red.withOpacity(0.1)
                    : Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_outline,
                  color: isFavorite ? Colors.red : Colors.grey[700],
                  size: 22,
                ),
                onPressed: onToggleFavorite,
              ),
            ),
            const SizedBox(width: 12),

            // Add to Cart Button
            Expanded(
              child: SizedBox(
                height: 48,
                child: ElevatedButton(
                  onPressed: product.itemsActive == 1 && !isAddingToCart
                      ? onAddToCart
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: isAddingToCart
                      ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.white,
                      ),
                    ),
                  )
                      : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.shopping_cart, size: 18),
                      const SizedBox(width: 8),
                      Text(
                        'Add to Cart • \$${(product.itemsPrice! * quantity).toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColor.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}