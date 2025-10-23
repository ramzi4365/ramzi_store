import 'package:flutter/material.dart';
import 'package:ramzi_store/data/model/itemsModel.dart';

class DescriptionSection extends StatelessWidget {
  final ItemsModel product;
  final bool showFullDescription;
  final VoidCallback onToggleDescription;

  const DescriptionSection({
    super.key,
    required this.product,
    required this.showFullDescription,
    required this.onToggleDescription,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Description',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        AnimatedCrossFade(
          firstChild: Text(
            "${product.itemsDesc}",
            style: TextStyle(
              color: Colors.grey[700],
              height: 1.5,
              fontSize: 14,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          secondChild: Text(
            "${product.itemsDesc}",
            style: TextStyle(
              color: Colors.grey[700],
              height: 1.5,
              fontSize: 14,
            ),
          ),
          crossFadeState: showFullDescription
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 300),
        ),
        TextButton(
          onPressed: onToggleDescription,
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            visualDensity: VisualDensity.compact,
          ),
          child: Text(
            showFullDescription ? 'Show less' : 'Read more',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}