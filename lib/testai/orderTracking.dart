//
// // track_order_page.dart
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:timeline_tile/timeline_tile.dart';
//
// class TrackOrderPage extends StatefulWidget {
//   const TrackOrderPage({super.key});
//
//   @override
//   State<TrackOrderPage> createState() => _TrackOrderPageState();
// }
//
// class _TrackOrderPageState extends State<TrackOrderPage>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//   }
//
//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF8F9FA),
//       body: CustomScrollView(
//         slivers: [
//           // Custom App Bar
//           SliverAppBar(
//             expandedHeight: 140,
//             floating: false,
//             pinned: true,
//             backgroundColor: Colors.white,
//             elevation: 0,
//             leading: Container(
//               margin: const EdgeInsets.all(8),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(12),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.05),
//                     blurRadius: 10,
//                     offset: const Offset(0, 2),
//                   ),
//                 ],
//               ),
//               child: IconButton(
//                 icon: Icon(
//                   Icons.arrow_back_ios_new,
//                   color: Theme.of(context).primaryColor,
//                   size: 20,
//                 ),
//                 onPressed: () => Navigator.pop(context),
//               ),
//             ),
//             actions: [
//               Container(
//                 margin: const EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(12),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.05),
//                       blurRadius: 10,
//                       offset: const Offset(0, 2),
//                     ),
//                   ],
//                 ),
//                 child: IconButton(
//                   icon: Icon(
//                     Icons.support_agent_rounded,
//                     color: Theme.of(context).primaryColor,
//                     size: 20,
//                   ),
//                   onPressed: () {
//                     _showSupportDialog();
//                   },
//                 ),
//               ),
//             ],
//             flexibleSpace: FlexibleSpaceBar(
//               background: Container(
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                     colors: [
//                       Theme.of(context).primaryColor.withOpacity(0.05),
//                       Colors.white,
//                     ],
//                   ),
//                 ),
//                 child: SafeArea(
//                   child: Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         const SizedBox(height: 40),
//                         Text(
//                           'Track Order',
//                           style: TextStyle(
//                             color: Theme.of(context).primaryColor,
//                             fontSize: 24,
//                             fontWeight: FontWeight.bold,
//                             letterSpacing: 0.5,
//                           ),
//                         ),
//                         const SizedBox(height: 8),
//                         Container(
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 16,
//                             vertical: 6,
//                           ),
//                           decoration: BoxDecoration(
//                             color: Theme.of(context).primaryColor.withOpacity(0.1),
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                           child: Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Icon(
//                                 Icons.local_shipping_rounded,
//                                 size: 16,
//                                 color: Theme.of(context).primaryColor,
//                               ),
//                               const SizedBox(width: 6),
//                               Text(
//                                 'Order #123456',
//                                 style: TextStyle(
//                                   color: Theme.of(context).primaryColor,
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             bottom: PreferredSize(
//               preferredSize: const Size.fromHeight(50),
//               child: Container(
//                 color: Colors.white,
//                 child: TabBar(
//                   controller: _tabController,
//                   labelColor: Theme.of(context).primaryColor,
//                   unselectedLabelColor: Colors.grey[600],
//                   indicatorColor: Theme.of(context).primaryColor,
//                   indicatorWeight: 3,
//                   tabs: const [
//                     Tab(text: 'Tracking'),
//                     Tab(text: 'Order Details'),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//
//           // Content
//           SliverFillRemaining(
//             child: TabBarView(
//               controller: _tabController,
//               children: [
//                 // Tracking Tab
//                 _buildTrackingTab(),
//                 // Order Details Tab
//                 _buildOrderDetailsTab(),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildTrackingTab() {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(20),
//       child: Column(
//         children: [
//           // Current Status Card
//           _buildCurrentStatusCard(),
//           const SizedBox(height: 20),
//
//           // Estimated Delivery Card
//           _buildEstimatedDeliveryCard(),
//           const SizedBox(height: 20),
//
//           // Tracking Timeline
//           _buildTrackingTimeline(),
//           const SizedBox(height: 20),
//
//           // Delivery Partner Card
//           _buildDeliveryPartnerCard(),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildCurrentStatusCard() {
//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//           colors: [
//             Theme.of(context).primaryColor,
//             Theme.of(context).primaryColor.withOpacity(0.8),
//           ],
//         ),
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Theme.of(context).primaryColor.withOpacity(0.3),
//             blurRadius: 20,
//             offset: const Offset(0, 10),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           Container(
//             width: 80,
//             height: 80,
//             decoration: BoxDecoration(
//               color: Colors.white.withOpacity(0.2),
//               shape: BoxShape.circle,
//             ),
//             child: const Icon(
//               Icons.local_shipping_rounded,
//               size: 40,
//               color: Colors.white,
//             ),
//           ),
//           const SizedBox(height: 16),
//           const Text(
//             'Out for Delivery',
//             style: TextStyle(
//               fontSize: 22,
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//               letterSpacing: 0.5,
//             ),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             'Your package is on the way',
//             style: TextStyle(
//               fontSize: 14,
//               color: Colors.white.withOpacity(0.9),
//             ),
//           ),
//           const SizedBox(height: 16),
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//             decoration: BoxDecoration(
//               color: Colors.white.withOpacity(0.2),
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Icon(
//                   Icons.access_time,
//                   size: 16,
//                   color: Colors.white.withOpacity(0.9),
//                 ),
//                 const SizedBox(width: 6),
//                 Text(
//                   'Last updated: 2 hours ago',
//                   style: TextStyle(
//                     fontSize: 12,
//                     color: Colors.white.withOpacity(0.9),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildEstimatedDeliveryCard() {
//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.04),
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           Container(
//             width: 60,
//             height: 60,
//             decoration: BoxDecoration(
//               color: Colors.green[50],
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Icon(
//               Icons.calendar_today_rounded,
//               color: Colors.green[600],
//               size: 28,
//             ),
//           ),
//           const SizedBox(width: 16),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Estimated Delivery',
//                   style: TextStyle(
//                     fontSize: 14,
//                     color: Colors.grey[600],
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 const Text(
//                   'Today, 3:00 PM - 5:00 PM',
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             padding: const EdgeInsets.all(8),
//             decoration: BoxDecoration(
//               color: Colors.green[50],
//               shape: BoxShape.circle,
//             ),
//             child: Icon(
//               Icons.check,
//               color: Colors.green[600],
//               size: 20,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildTrackingTimeline() {
//     final trackingSteps = [
//       {
//         'title': 'Order Placed',
//         'subtitle': 'Your order has been placed successfully',
//         'time': 'Oct 25, 10:30 AM',
//         'isCompleted': true,
//       },
//       {
//         'title': 'Order Confirmed',
//         'subtitle': 'Seller has confirmed your order',
//         'time': 'Oct 25, 11:00 AM',
//         'isCompleted': true,
//       },
//       {
//         'title': 'Order Shipped',
//         'subtitle': 'Your package is on the way',
//         'time': 'Oct 26, 09:00 AM',
//         'isCompleted': true,
//       },
//       {
//         'title': 'Out for Delivery',
//         'subtitle': 'Package will be delivered today',
//         'time': 'Oct 27, 08:30 AM',
//         'isCompleted': true,
//       },
//       {
//         'title': 'Delivered',
//         'subtitle': 'Package delivered successfully',
//         'time': 'Pending',
//         'isCompleted': false,
//       },
//     ];
//
//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.04),
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(10),
//                 decoration: BoxDecoration(
//                   color: Theme.of(context).primaryColor.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Icon(
//                   Icons.timeline_rounded,
//                   color: Theme.of(context).primaryColor,
//                   size: 24,
//                 ),
//               ),
//               const SizedBox(width: 12),
//               const Text(
//                 'Tracking History',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   letterSpacing: 0.3,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 20),
//           ...trackingSteps.asMap().entries.map((entry) {
//             final index = entry.key;
//             final step = entry.value;
//             final isLast = index == trackingSteps.length - 1;
//             final isCompleted = step['isCompleted'] as bool;
//
//             return TimelineTile(
//               alignment: TimelineAlign.manual,
//               lineXY: 0.1,
//               isFirst: index == 0,
//               isLast: isLast,
//               indicatorStyle: IndicatorStyle(
//                 width: 40,
//                 height: 40,
//                 indicator: Container(
//                   decoration: BoxDecoration(
//                     gradient: isCompleted
//                         ? LinearGradient(
//                       colors: [
//                         Theme.of(context).primaryColor,
//                         Theme.of(context).primaryColor.withOpacity(0.8),
//                       ],
//                     )
//                         : null,
//                     color: !isCompleted ? Colors.grey[300] : null,
//                     shape: BoxShape.circle,
//                   ),
//                   child: Center(
//                     child: isCompleted
//                         ? const Icon(
//                       Icons.check,
//                       color: Colors.white,
//                       size: 20,
//                     )
//                         : Text(
//                       '${index + 1}',
//                       style: TextStyle(
//                         color: Colors.grey[600],
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               afterLineStyle: LineStyle(
//                 color: isCompleted ? Theme.of(context).primaryColor : Colors.grey[300]!,
//                 thickness: 2,
//               ),
//               beforeLineStyle: LineStyle(
//                 color: index > 0 && trackingSteps[index - 1]['isCompleted'] as bool
//                     ? Theme.of(context).primaryColor
//                     : Colors.grey[300]!,
//                 thickness: 2,
//               ),
//               endChild: Container(
//                 constraints: const BoxConstraints(minHeight: 80),
//                 padding: const EdgeInsets.only(left: 16, bottom: 16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       step['title'] as String,
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                         color: isCompleted ? Colors.black : Colors.grey[600],
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       step['subtitle'] as String,
//                       style: TextStyle(
//                         fontSize: 13,
//                         color: Colors.grey[600],
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                     Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                       decoration: BoxDecoration(
//                         color: isCompleted
//                             ? Theme.of(context).primaryColor.withOpacity(0.1)
//                             : Colors.grey[100],
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: Text(
//                         step['time'] as String,
//                         style: TextStyle(
//                           fontSize: 11,
//                           color: isCompleted
//                               ? Theme.of(context).primaryColor
//                               : Colors.grey[600],
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           }).toList(),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildDeliveryPartnerCard() {
//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.04),
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Container(
//                 width: 60,
//                 height: 60,
//                 decoration: BoxDecoration(
//                   image: const DecorationImage(
//                     image: NetworkImage('https://via.placeholder.com/150'),
//                     fit: BoxFit.cover,
//                   ),
//                   borderRadius: BorderRadius.circular(12),
//                   border: Border.all(
//                     color: Colors.grey[200]!,
//                     width: 2,
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 16),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       'John Smith',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       'Delivery Partner',
//                       style: TextStyle(
//                         fontSize: 14,
//                         color: Colors.grey[600],
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                     Row(
//                       children: [
//                         Icon(
//                           Icons.star,
//                           size: 16,
//                           color: Colors.amber[600],
//                         ),
//                         const SizedBox(width: 4),
//                         Text(
//                           '4.8',
//                           style: TextStyle(
//                             fontSize: 14,
//                             fontWeight: FontWeight.w600,
//                             color: Colors.grey[800],
//                           ),
//                         ),
//                         Text(
//                           ' (230 deliveries)',
//                           style: TextStyle(
//                             fontSize: 12,
//                             color: Colors.grey[600],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 16),
//           Row(
//             children: [
//               Expanded(
//                 child: Container(
//                   height: 48,
//                   decoration: BoxDecoration(
//                     color: Theme.of(context).primaryColor.withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: TextButton(
//                     onPressed: () {},
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(
//                           Icons.phone_rounded,
//                           size: 20,
//                           color: Theme.of(context).primaryColor,
//                         ),
//                         const SizedBox(width: 8),
//                         Text(
//                           'Call',
//                           style: TextStyle(
//                             color: Theme.of(context).primaryColor,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 12),
//               Expanded(
//                 child: Container(
//                   height: 48,
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       colors: [
//                         Theme.of(context).primaryColor,
//                         Theme.of(context).primaryColor.withOpacity(0.8),
//                       ],
//                     ),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: ElevatedButton(
//                     onPressed: () {},
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.transparent,
//                       shadowColor: Colors.transparent,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: const [
//                         Icon(
//                           Icons.message_rounded,
//                           size: 20,
//                           color: Colors.white,
//                         ),
//                         SizedBox(width: 8),
//                         Text(
//                           'Message',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildOrderDetailsTab() {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(20),
//       child: Column(
//         children: [
//           // Order Info Card
//           _buildOrderInfoCard(),
//           const SizedBox(height: 20),
//
//           // Items Card
//           _buildItemsCard(),
//           const SizedBox(height: 20),
//
//           // Shipping Address Card
//           _buildShippingAddressCard(),
//           const SizedBox(height: 20),
//
//           // Payment Summary Card
//           _buildPaymentSummaryCard(),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildOrderInfoCard() {
//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.04),
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           _buildInfoRow('Order ID', '#123456'),
//           const SizedBox(height: 12),
//           _buildInfoRow('Order Date', 'Oct 25, 2023, 10:30 AM'),
//           const SizedBox(height: 12),
//           _buildInfoRow('Payment Method', 'Credit Card'),
//           const SizedBox(height: 12),
//           _buildInfoRow('Status', 'Out for Delivery', isStatus: true),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildInfoRow(String label, String value, {bool isStatus = false}) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           label,
//           style: TextStyle(
//             fontSize: 14,
//             color: Colors.grey[600],
//           ),
//         ),
//         isStatus
//             ? Container(
//           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//           decoration: BoxDecoration(
//             color: Colors.orange[50],
//             borderRadius: BorderRadius.circular(20),
//           ),
//           child: Text(
//             value,
//             style: TextStyle(
//               fontSize: 12,
//               color: Colors.orange[700],
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         )
//             : Text(
//           value,
//           style: const TextStyle(
//             fontSize: 14,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildItemsCard() {
//     final items = [
//       {
//         'name': 'Apple Watch Series 7',
//         'variant': 'GPS, 45mm',
//         'price': '\$399.00',
//         'quantity': 1,
//         'image': 'https://via.placeholder.com/100',
//       },
//       {
//         'name': 'iPhone 13 Pro',
//         'variant': 'Pacific Blue, 256GB',
//         'price': '\$999.00',
//         'quantity': 1,
//         'image': 'https://via.placeholder.com/100',
//       },
//       {
//         'name': 'AirPods Pro',
//         'variant': 'White',
//         'price': '\$249.00',
//         'quantity': 2,
//         'image': 'https://via.placeholder.com/100',
//       },
//     ];
//
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.04),
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(20),
//             child: Row(
//               children: [
//                 Container(
//                   padding: const EdgeInsets.all(10),
//                   decoration: BoxDecoration(
//                     color: Colors.blue[50],
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Icon(
//                     Icons.shopping_bag_rounded,
//                     color: Colors.blue[600],
//                     size: 24,
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 const Text(
//                   'Order Items',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     letterSpacing: 0.3,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           ...items.map((item) => Container(
//             padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
//             child: Row(
//               children: [
//                 Container(
//                   width: 70,
//                   height: 70,
//                   decoration: BoxDecoration(
//                     color: Colors.grey[100],
//                     borderRadius: BorderRadius.circular(12),
//                     image: DecorationImage(
//                       image: NetworkImage(item['image'] as String),
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 16),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         item['name'] as String,
//                         style: const TextStyle(
//                           fontSize: 15,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       const SizedBox(height: 4),
//                       Text(
//                         item['variant'] as String,
//                         style: TextStyle(
//                           fontSize: 13,
//                           color: Colors.grey[600],
//                         ),
//                       ),
//                       const SizedBox(height: 4),
//                       Text(
//                         'Qty: ${item['quantity']}',
//                         style: TextStyle(
//                           fontSize: 13,
//                           color: Colors.grey[700],
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Text(
//                   item['price'] as String,
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                     color: Theme.of(context).primaryColor,
//                   ),
//                 ),
//               ],
//             ),
//           )).toList(),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildShippingAddressCard() {
//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.04),
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(10),
//                 decoration: BoxDecoration(
//                   color: Colors.green[50],
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Icon(
//                   Icons.location_on_rounded,
//                   color: Colors.green[600],
//                   size: 24,
//                 ),
//               ),
//               const SizedBox(width: 12),
//               Text(
//                 '''123 Main Street, Apartment 4B
// New York, NY 10001
// United States''',
//                 style: TextStyle(
//                   fontSize: 14,
//                   color: Colors.grey[700],
//                   height: 1.5,
//                 ),
//               ),
//
//             ],
//           ),
//           const SizedBox(height: 16),
//           const Text(
//             'John Doe',
//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             '''123 Main Street, Apartment 4B
// New York, NY 10001
// United States''',
//             style: TextStyle(
//               fontSize: 14,
//               color: Colors.grey[700],
//               height: 1.5,
//             ),
//           ),
//           const SizedBox(height: 8),
//           Row(
//             children: [
//               Icon(
//                 Icons.phone,
//                 size: 16,
//                 color: Colors.grey[600],
//               ),
//               const SizedBox(width: 6),
//               Text(
//                 '+1 234 567 8900',
//                 style: TextStyle(
//                   fontSize: 14,
//                   color: Colors.grey[600],
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildPaymentSummaryCard() {
//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.04),
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(10),
//                 decoration: BoxDecoration(
//                   color: Colors.purple[50],
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Icon(
//                   Icons.receipt_rounded,
//                   color: Colors.purple[600],
//                   size: 24,
//                 ),
//               ),
//               const SizedBox(width: 12),
//               const Text(
//                 'Payment Summary',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   letterSpacing: 0.3,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 20),
//
//           // Summary rows
//           _buildSummaryRow('Subtotal', '\$1,647.00'),
//           const SizedBox(height: 12),
//           _buildSummaryRow('Shipping', '\$15.00'),
//           const SizedBox(height: 12),
//           _buildSummaryRow('Tax', '\$131.76'),
//           const SizedBox(height: 12),
//
//           // Discount row with special styling
//           Container(
//             padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
//             decoration: BoxDecoration(
//               color: Colors.green[50],
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   children: [
//                     Icon(
//                       Icons.discount_outlined,
//                       size: 16,
//                       color: Colors.green[700],
//                     ),
//                     const SizedBox(width: 8),
//                     Text(
//                       'Promo Code (SAVE10)',
//                       style: TextStyle(
//                         fontSize: 14,
//                         color: Colors.green[700],
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ],
//                 ),
//                 Text(
//                   '-\$164.70',
//                   style: TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.green[700],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//
//           const SizedBox(height: 16),
//
//           // Divider
//           Container(
//             height: 1,
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [
//                   Colors.transparent,
//                   Colors.grey[300]!,
//                   Colors.grey[300]!,
//                   Colors.transparent,
//                 ],
//                 stops: const [0, 0.2, 0.8, 1],
//               ),
//             ),
//           ),
//
//           const SizedBox(height: 16),
//
//           // Total section
//           Container(
//             padding: const EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [
//                   Theme.of(context).primaryColor.withOpacity(0.05),
//                   Theme.of(context).primaryColor.withOpacity(0.02),
//                 ],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//               borderRadius: BorderRadius.circular(12),
//               border: Border.all(
//                 color: Theme.of(context).primaryColor.withOpacity(0.1),
//                 width: 1,
//               ),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       'Total Paid',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                         letterSpacing: 0.3,
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                     Row(
//                       children: [
//                         Icon(
//                           Icons.credit_card,
//                           size: 16,
//                           color: Colors.grey[600],
//                         ),
//                         const SizedBox(width: 6),
//                         Text(
//                           'Visa •••• 1234',
//                           style: TextStyle(
//                             fontSize: 12,
//                             color: Colors.grey[600],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     Text(
//                       '\$1,629.06',
//                       style: TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                         color: Theme.of(context).primaryColor,
//                         letterSpacing: 0.5,
//                       ),
//                     ),
//                     Text(
//                       'USD',
//                       style: TextStyle(
//                         fontSize: 11,
//                         color: Colors.grey[600],
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//
//           const SizedBox(height: 20),
//
//           // Download Invoice Button
//           Container(
//             width: double.infinity,
//             height: 48,
//             decoration: BoxDecoration(
//               border: Border.all(
//                 color: Theme.of(context).primaryColor.withOpacity(0.3),
//                 width: 1,
//               ),
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: TextButton(
//               onPressed: () {
//                 // Handle download invoice
//               },
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(
//                     Icons.download_rounded,
//                     size: 20,
//                     color: Theme.of(context).primaryColor,
//                   ),
//                   const SizedBox(width: 8),
//                   Text(
//                     'Download Invoice',
//                     style: TextStyle(
//                       color: Theme.of(context).primaryColor,
//                       fontWeight: FontWeight.w600,
//                       fontSize: 15,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildSummaryRow(String label, String value, {Color? valueColor}) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           label,
//           style: TextStyle(
//             fontSize: 14,
//             color: Colors.grey[600],
//           ),
//         ),
//         Text(
//           value,
//           style: TextStyle(
//             fontSize: 14,
//             fontWeight: FontWeight.w600,
//             color: valueColor ?? Colors.grey[800],
//           ),
//         ),
//       ],
//     );
//   }
//
//   void _showSupportDialog() {
//     Get.dialog(
//       Dialog(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(20),
//         ),
//         child: Container(
//           padding: const EdgeInsets.all(24),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(20),
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Container(
//                 width: 80,
//                 height: 80,
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [
//                       Theme.of(context).primaryColor.withOpacity(0.1),
//                       Theme.of(context).primaryColor.withOpacity(0.05),
//                     ],
//                   ),
//                   shape: BoxShape.circle,
//                 ),
//                 child: Icon(
//                   Icons.support_agent_rounded,
//                   size: 40,
//                   color: Theme.of(context).primaryColor,
//                 ),
//               ),
//               const SizedBox(height: 20),
//               const Text(
//                 'Need Help?',
//                 style: TextStyle(
//                   fontSize: 22,
//                   fontWeight: FontWeight.bold,
//                   letterSpacing: 0.3,
//                 ),
//               ),
//               const SizedBox(height: 8),
//               Text(
//                 'Our support team is here to assist you',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontSize: 14,
//                   color: Colors.grey[600],
//                   height: 1.5,
//                 ),
//               ),
//               const SizedBox(height: 24),
//
//               // Contact Options
//               _buildContactOption(
//                 icon: Icons.chat_bubble_rounded,
//                 title: 'Live Chat',
//                 subtitle: 'Chat with our support team',
//                 color: Colors.blue[600]!,
//                 onTap: () {
//                   Navigator.pop(context);
//                   // Handle live chat
//                 },
//               ),
//               const SizedBox(height: 12),
//               _buildContactOption(
//                 icon: Icons.phone_rounded,
//                 title: 'Call Us',
//                 subtitle: '+1 234 567 8900',
//                 color: Colors.green[600]!,
//                 onTap: () {
//                   Navigator.pop(context);
//                   // Handle phone call
//                 },
//               ),
//               const SizedBox(height: 12),
//               _buildContactOption(
//                 icon: Icons.email_rounded,
//                 title: 'Email Support',
//                 subtitle: 'support@example.com',
//                 color: Colors.purple[600]!,
//                 onTap: () {
//                   Navigator.pop(context);
//                   // Handle email
//                 },
//               ),
//
//               const SizedBox(height: 20),
//
//               TextButton(
//                 onPressed: () => Navigator.pop(context),
//                 child: Text(
//                   'Close',
//                   style: TextStyle(
//                     color: Colors.grey[600],
//                     fontSize: 15,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       barrierDismissible: true,
//     );
//   }
//
//   Widget _buildContactOption({
//     required IconData icon,
//     required String title,
//     required String subtitle,
//     required Color color,
//     required VoidCallback onTap,
//   }) {
//     return InkWell(
//       onTap: onTap,
//       borderRadius: BorderRadius.circular(12),
//       child: Container(
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: color.withOpacity(0.05),
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(
//             color: color.withOpacity(0.2),
//             width: 1,
//           ),
//         ),
//         child: Row(
//           children: [
//             Container(
//               padding: const EdgeInsets.all(10),
//               decoration: BoxDecoration(
//                 color: color.withOpacity(0.1),
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Icon(
//                 icon,
//                 color: color,
//                 size: 24,
//               ),
//             ),
//             const SizedBox(width: 16),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     title,
//                     style: const TextStyle(
//                       fontSize: 15,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   const SizedBox(height: 2),
//                   Text(
//                     subtitle,
//                     style: TextStyle(
//                       fontSize: 13,
//                       color: Colors.grey[600],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Icon(
//               Icons.arrow_forward_ios,
//               size: 16,
//               color: Colors.grey[400],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
// }
//
//
// // Example usage
// void main() {
//   runApp(MaterialApp(
//     theme: ThemeData(
//       primaryColor: const Color(0xFF2C3E50),
//       colorScheme: const ColorScheme.light(
//         primary: Color(0xFF2C3E50),
//         secondary: Color(0xFFE74C3C),
//         surface: Color(0xFFF8F9FA),
//       ),
//     ),
//     home: const TrackOrderPage(),
//   ));
// }
//
//
