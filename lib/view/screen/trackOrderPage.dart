// track_order_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/trackOrderController.dart';
import '../widget/trackOrder/currentStatusCardWidge.dart';
import '../widget/trackOrder/deliveryPartnerCardWidget.dart';
import '../widget/trackOrder/estimatedDeliveryCardWidget.dart';
import '../widget/trackOrder/orderInfoCardWidget.dart';
import '../widget/trackOrder/orderItemsCardWidget.dart';
import '../widget/trackOrder/paymentSummaryCardWidget.dart';
import '../widget/trackOrder/shippingAddressCardWidget.dart';
import '../widget/trackOrder/trackingTimelineCardWidget.dart';



class TrackOrderPage extends GetView<TrackOrderController> {
  const TrackOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: GetBuilder<TrackOrderController>(
        builder: (controller) => CustomScrollView(
          slivers: [
            // Custom App Bar
            _buildAppBar(context),

            // Content
            SliverFillRemaining(
              child: _buildTabContent(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 120,
      floating: false,
      pinned: true,
      backgroundColor: Colors.white,
      elevation: 0,
      leading: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Theme.of(context).primaryColor,
            size: 20,
          ),
          onPressed: () => Get.back(),
        ),
      ),
      actions: [
        Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: IconButton(
            icon: Icon(
              Icons.support_agent_rounded,
              color: Theme.of(context).primaryColor,
              size: 20,
            ),
            onPressed: () => controller.showSupportDialog(),
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Theme.of(context).primaryColor.withOpacity(0.05),
                Colors.white,
              ],
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Track Order',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.local_shipping_rounded,
                          size: 16,
                          color: Theme.of(context).primaryColor,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Order ${controller.orderId}',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: Container(
          color: Colors.white,
          child: _buildTabBar(context),
        ),
      ),
    );
  }

  Widget _buildTabBar(BuildContext context) {
    return GetBuilder<TrackOrderController>(
      builder: (controller) => TabBar(
        controller: controller.tabController,
        labelColor: Theme.of(context).primaryColor,
        unselectedLabelColor: Colors.grey[600],
        indicatorColor: Theme.of(context).primaryColor,
        indicatorWeight: 3,
        tabs: const [
          Tab(text: 'Tracking'),
          Tab(text: 'Order Details'),
        ],
      ),
    );
  }

  Widget _buildTabContent() {
    return GetBuilder<TrackOrderController>(
      builder: (controller) => TabBarView(
        controller: controller.tabController,
        children: [
          // Order Details Tab
          _buildOrderDetailsTab(),
          // Tracking Tab
         // _buildTrackingTab(),

        ],
      ),
    );
  }

  // Widget _buildTrackingTab() {
  //   return GetBuilder<TrackOrderController>(
  //     builder: (controller) => SingleChildScrollView(
  //       padding: const EdgeInsets.all(20),
  //       child: Column(
  //         children: [
  //           CurrentStatusCardWidget(
  //             currentStatus: controller.currentStatus,
  //             lastUpdated: controller.lastUpdated,
  //           ),
  //           const SizedBox(height: 20),
  //           EstimatedDeliveryCardWidget(
  //             estimatedDelivery: controller.estimatedDelivery,
  //           ),
  //           const SizedBox(height: 20),
  //           TrackingTimelineCardWidget(
  //             trackingSteps: controller.trackingSteps,
  //           ),
  //           const SizedBox(height: 20),
  //           DeliveryPartnerCardWidget(
  //             deliveryPartnerName: controller.deliveryPartnerName,
  //             deliveryPartnerImage: controller.deliveryPartnerImage,
  //             deliveryPartnerRating: controller.deliveryPartnerRating,
  //             deliveryPartnerDeliveries: controller.deliveryPartnerDeliveries,
  //             onCallPressed: controller.callDeliveryPartner,
  //             onMessagePressed: controller.messageDeliveryPartner,
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget _buildOrderDetailsTab() {
    return GetBuilder<TrackOrderController>(
      builder: (controller) => SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            OrderInfoCardWidget(
              orderId: controller.orderId,
              orderDate: controller.orderDate,
              paymentMethod: controller.paymentMethod,
              currentStatus: controller.currentStatus,
            ),
            const SizedBox(height: 20),
            OrderItemsCardWidget(
              orderItems: controller.orderItems,
            ),
            const SizedBox(height: 20),
            ShippingAddressCardWidget(
              recipientName: controller.recipientName,
              shippingAddress: controller.shippingAddress,
              phoneNumber: controller.phoneNumber,
            ),
            const SizedBox(height: 20),
            PaymentSummaryCardWidget(
              subtotal: controller.subtotal,
              shipping: controller.shipping,
              tax: controller.tax,
              discount: controller.discount,
              promoCode: controller.promoCode,
              total: controller.total,
              paymentCard: controller.paymentCard,
              onDownloadInvoice: controller.downloadInvoice,
            ),
          ],
        ),
      ),
    );
  }
}