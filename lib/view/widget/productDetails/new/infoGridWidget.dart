import 'package:flutter/material.dart';

class InfoGrid extends StatelessWidget {
  const InfoGrid({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 2.5,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: [
        _buildInfoItem(Icons.local_shipping, 'Free Shipping', Colors.blue),
        _buildInfoItem(Icons.assignment_return, '30-Day Returns', Colors.green),
        _buildInfoItem(Icons.verified_user, 'Authentic', Colors.orange),
        _buildInfoItem(Icons.support_agent, '24/7 Support', Colors.purple),
      ],
    );
  }

  Widget _buildInfoItem(IconData icon, String text, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}