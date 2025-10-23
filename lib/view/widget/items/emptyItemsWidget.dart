import 'package:flutter/material.dart';

class EmptyItemsWidget extends StatelessWidget {
  final VoidCallback onExplorePressed;
  final IconData? icon;
  final String? title;
  final String? description;

  const EmptyItemsWidget({
    Key? key,
    required this.onExplorePressed,
    this.icon,
    this.title,
    this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Customizable Icon
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.grey[50],
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: Icon(
                icon ?? Icons.inventory_2_outlined,
                size: 60,
                color: Colors.grey[400],
              ),
            ),

            const SizedBox(height: 24),

            // Title
            Text(
              title ?? 'No Products Available',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 12),

            // Description
            Text(
              description ?? 'Check back later for new arrivals!',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 32),

            // Explore Button
            // ElevatedButton(
            //   onPressed: onExplorePressed,
            //   style: ElevatedButton.styleFrom(
            //     backgroundColor: Theme.of(context).primaryColor,
            //     padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(12),
            //     ),
            //   ),
            //   child: const Text(
            //     'Browse Catalog',
            //     style: TextStyle(
            //       fontSize: 16,
            //       fontWeight: FontWeight.w600,
            //       color: Colors.white,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}