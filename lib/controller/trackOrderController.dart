// track_order_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TrackOrderController extends GetxController with GetSingleTickerProviderStateMixin {
  // Tab controller
  late TabController tabController;

  // Order data (regular variables, not Rx)
  String orderId = '#123456';
  String currentStatus = 'Out for Delivery';
  String estimatedDelivery = 'Today, 3:00 PM - 5:00 PM';
  String lastUpdated = '2 hours ago';

  // Delivery partner data
  String deliveryPartnerName = 'John Smith';
  String deliveryPartnerImage = 'https://ui-avatars.com/api/?name=John+Smith&size=150&background=random';
  double deliveryPartnerRating = 4.8;
  int deliveryPartnerDeliveries = 230;

  // Order info
  String orderDate = 'Oct 25, 2023, 10:30 AM';
  String paymentMethod = 'Credit Card';
  String paymentCard = 'Visa •••• 1234';

  // Shipping address
  String recipientName = 'John Doe';
  String shippingAddress = '''123 Main Street, Apartment 4B
New York, NY 10001
United States''';
  String phoneNumber = '+1 234 567 8900';

  // Payment summary
  double subtotal = 1647.00;
  double shipping = 15.00;
  double tax = 131.76;
  double discount = 164.70;
  String promoCode = 'SAVE10';
  double get total => subtotal + shipping + tax - discount;

  // Tracking steps
  List<Map<String, dynamic>> trackingSteps = [
    {
      'title': 'Order Placed',
      'subtitle': 'Your order has been placed successfully',
      'time': 'Oct 25, 10:30 AM',
      'isCompleted': true,
    },
    {
      'title': 'Order Confirmed',
      'subtitle': 'Seller has confirmed your order',
      'time': 'Oct 25, 11:00 AM',
      'isCompleted': true,
    },
    {
      'title': 'Order Shipped',
      'subtitle': 'Your package is on the way',
      'time': 'Oct 26, 09:00 AM',
      'isCompleted': true,
    },
    {
      'title': 'Out for Delivery',
      'subtitle': 'Package will be delivered today',
      'time': 'Oct 27, 08:30 AM',
      'isCompleted': true,
    },
    {
      'title': 'Delivered',
      'subtitle': 'Package delivered successfully',
      'time': 'Pending',
      'isCompleted': false,
    },
  ];

  // Order items
  List<Map<String, dynamic>> orderItems = [
    {
      'name': 'Apple Watch Series 7',
      'variant': 'GPS, 45mm',
      'price': '\$399.00',
      'quantity': 1,
      'image': 'https://ui-avatars.com/api/?name=Apple+Watch&size=100&background=random',
    },
    {
      'name': 'iPhone 13 Pro',
      'variant': 'Pacific Blue, 256GB',
      'price': '\$999.00',
      'quantity': 1,
      'image': 'https://ui-avatars.com/api/?name=iPhone+13&size=100&background=random',
    },
    {
      'name': 'AirPods Pro',
      'variant': 'White',
      'price': '\$249.00',
      'quantity': 2,
      'image': 'https://ui-avatars.com/api/?name=AirPods&size=100&background=random',
    },
  ];

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    loadOrderData();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  void loadOrderData() {
    // TODO: Implement API call to load order data
    update(); // Update UI after data is loaded
  }

  void callDeliveryPartner() {
    Get.snackbar(
      'Calling',
      'Calling $deliveryPartnerName...',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green[100],
      colorText: Colors.green[900],
      icon: const Icon(Icons.phone, color: Colors.green),
    );
  }

  void messageDeliveryPartner() {
    Get.snackbar(
      'Message',
      'Opening chat with $deliveryPartnerName...',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.blue[100],
      colorText: Colors.blue[900],
      icon: const Icon(Icons.message, color: Colors.blue),
    );
  }

  void downloadInvoice() {
    Get.snackbar(
      'Download',
      'Downloading invoice...',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.purple[100],
      colorText: Colors.purple[900],
      icon: const Icon(Icons.download, color: Colors.purple),
    );
  }

  void showSupportDialog() {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: _buildSupportDialog(),
      ),
      barrierDismissible: true,
    );
  }

  Widget _buildSupportDialog() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Get.theme.primaryColor.withOpacity(0.1),
                  Get.theme.primaryColor.withOpacity(0.05),
                ],
              ),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.support_agent_rounded,
              size: 40,
              color: Get.theme.primaryColor,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Need Help?',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Our support team is here to assist you',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              height: 1.5,
            ),
          ),
          const SizedBox(height: 24),
          _buildContactOption(
            icon: Icons.chat_bubble_rounded,
            title: 'Live Chat',
            subtitle: 'Chat with our support team',
            color: Colors.blue[600]!,
            onTap: () => contactSupport('Live Chat'),
          ),
          const SizedBox(height: 12),
          _buildContactOption(
            icon: Icons.phone_rounded,
            title: 'Call Us',
            subtitle: '+1 234 567 8900',
            color: Colors.green[600]!,
            onTap: () => contactSupport('Phone Call'),
          ),
          const SizedBox(height: 12),
          _buildContactOption(
            icon: Icons.email_rounded,
            title: 'Email Support',
            subtitle: 'support@example.com',
            color: Colors.purple[600]!,
            onTap: () => contactSupport('Email'),
          ),
          const SizedBox(height: 20),
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Close',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: color.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                color: color,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.grey[400],
            ),
          ],
        ),
      ),
    );
  }



  void contactSupport(String method) {
    Get.back();
    Get.snackbar(
      'Support',
      'Opening $method...',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.orange[100],
      colorText: Colors.orange[900],
      icon: const Icon(Icons.support_agent, color: Colors.orange),
    );
  }
}

