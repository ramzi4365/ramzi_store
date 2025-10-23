import 'package:flutter/material.dart';

class PaymentSectionWidget extends StatelessWidget {
  final List<Map<String, dynamic>> paymentMethods;
  final int selectedIndex;
  final Function(int) onPaymentSelected;

  const PaymentSectionWidget({
    super.key,
    required this.paymentMethods,
    required this.selectedIndex,
    required this.onPaymentSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...paymentMethods.asMap().entries.map((entry) {
          final index = entry.key;
          final method = entry.value;
          final isSelected = index == selectedIndex;

          return GestureDetector(
            onTap: () => onPaymentSelected(index),
            child: Container(
              margin: const EdgeInsets.only(bottom: 12, left: 20, right: 20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: isSelected
                    ? LinearGradient(
                  colors: [
                    Theme.of(context).primaryColor.withOpacity(0.05),
                    Theme.of(context).primaryColor.withOpacity(0.02),
                  ],
                )
                    : null,
                color: !isSelected ? Colors.grey[1000] : null,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isSelected
                      ? Theme.of(context).primaryColor.withOpacity(0.3)
                      : Colors.grey[300]!,
                  width: isSelected ? 2 : 1,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: (method['color'] as Color).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      method['icon'] as IconData,
                      color: method['color'] as Color,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          method['name'] as String,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          method['number'] as String,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected
                            ? Theme.of(context).primaryColor
                            : Colors.grey[400]!,
                        width: 2,
                      ),
                    ),
                    child: isSelected
                        ? Center(
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                      ),
                    )
                        : null,
                  ),
                ],
              ),
            ),
          );
        }).toList(),
        const SizedBox(height: 20),
      ],
    );
  }
}