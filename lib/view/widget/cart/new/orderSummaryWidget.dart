import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ramzi_store/controller/cartController.dart';

class OrderSummaryWidget extends StatelessWidget {

  final double subtotal;
  final double discount;
  final double total;
  final String promoCode;
  final double discountPercentage;


  const OrderSummaryWidget({
    super.key,
    required this.subtotal,
    required this.discount,
    required this.total,
    required this.promoCode,
    required this.discountPercentage,

  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
      builder: (controller) {


        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFFF8F9FA),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.grey[200]!,
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.receipt_long_outlined,
                      size: 18,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Order Summary',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.3,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Summary Items
              _buildSummaryItem(
                icon: Icons.shopping_bag_outlined,
                label: 'Subtotal',
                value: '\$${subtotal.toStringAsFixed(2)}',
                iconColor: Colors.blue[600]!,
              ),

              if (discountPercentage > 0) ...[
                const SizedBox(height: 12),
                _buildSummaryItem(
                  icon: Icons.discount_outlined,
                  label: 'Discount ($promoCode)',
                  value: '-\$${discount.toStringAsFixed(2)}',
                  valueColor: Colors.green[600],
                  iconColor: Colors.green[600]!,
                ),
              ],


              const SizedBox(height: 12),
              _buildSummaryItem(
                icon: Icons.local_shipping_outlined,
                label: 'Delivery Fee',
                value: 'Free',
                valueColor: Colors.green[600],
                iconColor: Colors.orange[600]!,
              ),


              const SizedBox(height: 16),

              // Divider with dots
              Row(
                children: List.generate(
                  30,
                      (index) => Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      height: 2,
                      color: Colors.grey[300],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Total
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).primaryColor.withOpacity(0.05),
                      Theme.of(context).primaryColor.withOpacity(0.02),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Theme.of(context).primaryColor.withOpacity(0.1),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Icon(
                            Icons.payments_outlined,
                            size: 16,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          'Total Amount',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '\$${total.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                            letterSpacing: 0.5,
                          ),
                        ),
                        Text(
                          'USD',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}



Widget _buildSummaryItem({
  required IconData icon,
  required String label,
  required String value,
  required Color iconColor,
  Color? valueColor,
}) {
  return Row(
    children: [
      Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: iconColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(
          icon,
          size: 16,
          color: iconColor,
        ),
      ),
      const SizedBox(width: 12),
      Expanded(
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[700],
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      Text(
        value,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w700,
          color: valueColor ?? Colors.grey[800],
          letterSpacing: 0.3,
        ),
      ),
    ],
  );
}
