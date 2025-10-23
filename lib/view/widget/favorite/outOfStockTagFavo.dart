import 'package:flutter/material.dart';

class OutOfStockTag extends StatelessWidget {
  const OutOfStockTag({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.red[50],
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        'Out of Stock',
        style: TextStyle(
          color: Colors.red[600],
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}