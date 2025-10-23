import 'package:flutter/material.dart';
import 'package:ramzi_store/data/model/cartModel.dart';

class OrderSummarySectionWidget extends StatelessWidget {
  //final TextEditingController promoController;

  //final VoidCallback onApplyPromo;
  final List<String> itemsCartName;
  final String subtotal;
  final String deliveryFee;
  final String tax;
  final String total;

  const OrderSummarySectionWidget({
    super.key,
    //required this.promoController,
    //required this.onApplyPromo,
    required this.itemsCartName,
    required this.subtotal,
    required this.deliveryFee,
    required this.tax,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Cart Items Preview
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF8F9FA),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      '3',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Total Items',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Expanded(
                            child: Text(

                              itemsCartName.isEmpty ? 'No items selected' : itemsCartName.join(', '),
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[700],
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Promo Code
          // Container(
          //   decoration: BoxDecoration(
          //     color: const Color(0xFFF8F9FA),
          //     borderRadius: BorderRadius.circular(12),
          //     border: Border.all(
          //       color: Colors.grey[300]!,
          //       width: 1,
          //     ),
          //   ),
          //   child: Row(
          //     children: [
          //       const SizedBox(width: 16),
          //       Icon(
          //         Icons.discount_outlined,
          //         color: Theme.of(context).colorScheme.secondary,
          //         size: 20,
          //       ),
          //       const SizedBox(width: 12),
          //       Expanded(
          //         child: TextField(
          //           controller: promoController,
          //           decoration: const InputDecoration(
          //             hintText: 'Enter promo code',
          //             hintStyle: TextStyle(fontSize: 14),
          //             border: InputBorder.none,
          //             contentPadding: EdgeInsets.symmetric(vertical: 14),
          //           ),
          //           style: const TextStyle(fontSize: 14),
          //         ),
          //       ),
          //       TextButton(
          //         onPressed: onApplyPromo,
          //         style: TextButton.styleFrom(
          //           padding: const EdgeInsets.symmetric(horizontal: 16),
          //         ),
          //         child: Text(
          //           'Apply',
          //           style: TextStyle(
          //             color: Theme.of(context).primaryColor,
          //             fontWeight: FontWeight.w600,
          //             fontSize: 14,
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          const SizedBox(height: 20),

          // Summary Details using controller data
          _buildSummaryRow('Subtotal', subtotal),
          const SizedBox(height: 12),
          _buildSummaryRow('Delivery Fee', deliveryFee, valueColor: Colors.green[600]),
          const SizedBox(height: 12),
          _buildSummaryRow('Tax', tax),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                total,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {Color? valueColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: valueColor ?? Colors.grey[800],
          ),
        ),
      ],
    );
  }
}