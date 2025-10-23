import 'package:flutter/material.dart';
import 'package:ramzi_store/data/model/itemsModel.dart';

class SizeSelection extends StatelessWidget {
  final ItemsModel product;
  final List<String> sizes;
  final int selectedIndex;
  final Function(int) onSizeSelected;
  final VoidCallback? onSizeGuidePressed;

  const SizeSelection({
    super.key,
    required this.product,
    required this.sizes,
    required this.selectedIndex,
    required this.onSizeSelected,
    this.onSizeGuidePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Size',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            TextButton.icon(
              onPressed: onSizeGuidePressed,
              icon: const Icon(Icons.straighten, size: 16),
              label: const Text('Size Guide', style: TextStyle(fontSize: 12)),
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.secondary,
                padding: EdgeInsets.zero,
                visualDensity: VisualDensity.compact,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: List.generate(
            sizes.length,
                (index) {
              final size = sizes[index];
              final isSelected = selectedIndex == index;
              return GestureDetector(
                onTap: () => onSizeSelected(index),
                child: Container(
                  margin: const EdgeInsets.only(right: 8),
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    color: isSelected ? Theme.of(context).primaryColor : Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: isSelected ? Theme.of(context).primaryColor : Colors.grey[300]!,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      size,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}