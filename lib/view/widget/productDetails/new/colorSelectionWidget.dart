import 'package:flutter/material.dart';
import 'package:ramzi_store/data/model/itemsModel.dart';

import '../../../../controller/productDetailsController.dart';

class ColorSelection extends StatelessWidget {
  final ItemsModel product;
  final List<Color> colors;
  final int selectedIndex;
  final Function(int) onColorSelected;

  const ColorSelection({
    super.key,
    required this.product,
    required this.colors,
    required this.selectedIndex,
    required this.onColorSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Color',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Row(
          children: List.generate(
            colors.length,
                (index) {
              final color = colors[index];
              final isSelected = selectedIndex == index;
              return GestureDetector(
                onTap: () => onColorSelected(index),
                child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected ? Theme.of(context).primaryColor : Colors.grey[300]!,
                      width: isSelected ? 2.5 : 1,
                    ),
                  ),
                  child: isSelected
                      ? Icon(
                    Icons.check,
                    color: color.computeLuminance() > 0.5
                        ? Colors.black
                        : Colors.white,
                    size: 18,
                  )
                      : null,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}