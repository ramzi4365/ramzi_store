// widgets/track_order/order_info_card_widget.dart
import 'package:flutter/material.dart';

class OrderInfoCardWidget extends StatelessWidget {
  final String orderId;
  final String orderDate;
  final String paymentMethod;
  final String currentStatus;

  const OrderInfoCardWidget({
    super.key,
    required this.orderId,
    required this.orderDate,
    required this.paymentMethod,
    required this.currentStatus,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildInfoRow('Order ID', orderId),
          const SizedBox(height: 12),
          _buildInfoRow('Order Date', orderDate),
          const SizedBox(height: 12),
          _buildInfoRow('Payment Method', paymentMethod),
          const SizedBox(height: 12),
          _buildInfoRow('Status', currentStatus, isStatus: true),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {bool isStatus = false}) {
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
        isStatus
            ? Container(
          padding:
          const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.orange[50],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            value,
            style: TextStyle(
              fontSize: 12,
              color: Colors.orange[700],
              fontWeight: FontWeight.w600,
            ),
          ),
        )
            : Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}