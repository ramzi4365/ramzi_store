// // checkout_page.dart
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
//
// class CheckoutPage extends StatefulWidget {
//   const CheckoutPage({super.key});
//
//   @override
//   State<CheckoutPage> createState() => _CheckoutPageState();
// }
//
// class _CheckoutPageState extends State<CheckoutPage> {
//   int _currentStep = 0;
//   int _selectedAddressIndex = 0;
//   int _selectedPaymentIndex = 0;
//   final TextEditingController _promoController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF8F9FA),
//       body: CustomScrollView(
//         slivers: [
//           // Custom App Bar
//           SliverAppBar(
//             expandedHeight: 120,
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
//                           'Checkout',
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
//                                 Icons.lock_rounded,
//                                 size: 16,
//                                 color: Theme.of(context).primaryColor,
//                               ),
//                               const SizedBox(width: 6),
//                               Text(
//                                 'Secure Checkout',
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
//           ),
//
//           // Progress Steps
//           SliverToBoxAdapter(
//             child: Container(
//               color: Colors.white,
//               padding: const EdgeInsets.symmetric(vertical: 20),
//               child: _buildProgressSteps(),
//             ),
//           ),
//
//           // Content
//           SliverPadding(
//             padding: const EdgeInsets.all(20),
//             sliver: SliverList(
//               delegate: SliverChildListDelegate([
//                 // Delivery Address Section
//                 _buildSectionCard(
//                   title: 'Delivery Address',
//                   icon: Icons.location_on_rounded,
//                   iconColor: Colors.blue[600]!,
//                   child: _buildAddressSection(),
//                 ),
//                 const SizedBox(height: 16),
//
//                 // Payment Method Section
//                 _buildSectionCard(
//                   title: 'Payment Method',
//                   icon: Icons.payment_rounded,
//                   iconColor: Colors.green[600]!,
//                   child: _buildPaymentSection(),
//                 ),
//                 const SizedBox(height: 16),
//
//                 // Order Summary Section
//                 _buildSectionCard(
//                   title: 'Order Summary',
//                   icon: Icons.receipt_long_rounded,
//                   iconColor: Colors.orange[600]!,
//                   child: _buildOrderSummarySection(),
//                 ),
//                 const SizedBox(height: 100),
//               ]),
//             ),
//           ),
//         ],
//       ),
//       bottomSheet: _buildBottomCheckout(),
//     );
//   }
//
//   Widget _buildProgressSteps() {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       child: Row(
//         children: [
//           _buildStepItem(0, 'Address', Icons.location_on_outlined),
//           _buildStepConnector(0),
//           _buildStepItem(1, 'Payment', Icons.payment_outlined),
//           _buildStepConnector(1),
//           _buildStepItem(2, 'Review', Icons.rate_review_outlined),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildStepItem(int index, String label, IconData icon) {
//     final isActive = index <= _currentStep;
//     final isCompleted = index < _currentStep;
//
//     return Expanded(
//       child: Column(
//         children: [
//           Container(
//             width: 50,
//             height: 50,
//             decoration: BoxDecoration(
//               gradient: isActive
//                   ? LinearGradient(
//                 colors: [
//                   Theme.of(context).primaryColor,
//                   Theme.of(context).primaryColor.withOpacity(0.8),
//                 ],
//               )
//                   : null,
//               color: !isActive ? Colors.grey[300] : null,
//               shape: BoxShape.circle,
//               boxShadow: isActive
//                   ? [
//                 BoxShadow(
//                   color: Theme.of(context).primaryColor.withOpacity(0.3),
//                   blurRadius: 15,
//                   offset: const Offset(0, 5),
//                 ),
//               ]
//                   : null,
//             ),
//             child: Center(
//               child: isCompleted
//                   ? const Icon(
//                 Icons.check_rounded,
//                 color: Colors.white,
//                 size: 24,
//               )
//                   : Icon(
//                 icon,
//                 color: isActive ? Colors.white : Colors.grey[600],
//                 size: 24,
//               ),
//             ),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             label,
//             style: TextStyle(
//               fontSize: 13,
//               fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
//               color: isActive ? Theme.of(context).primaryColor : Colors.grey[600],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildStepConnector(int index) {
//     final isActive = index < _currentStep;
//
//     return Expanded(
//       child: Container(
//         height: 2,
//         margin: const EdgeInsets.only(bottom: 30),
//         decoration: BoxDecoration(
//           gradient: isActive
//               ? LinearGradient(
//             colors: [
//               Theme.of(context).primaryColor,
//               Theme.of(context).primaryColor.withOpacity(0.5),
//             ],
//           )
//               : null,
//           color: !isActive ? Colors.grey[300] : null,
//         ),
//       ),
//     );
//   }
//
//   Widget _buildSectionCard({
//     required String title,
//     required IconData icon,
//     required Color iconColor,
//     required Widget child,
//   }) {
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
//                     color: iconColor.withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Icon(
//                     icon,
//                     color: iconColor,
//                     size: 24,
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 Text(
//                   title,
//                   style: const TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     letterSpacing: 0.3,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           child,
//         ],
//       ),
//     );
//   }
//
//   Widget _buildAddressSection() {
//     final addresses = [
//       {
//         'name': 'Home',
//         'address': '123 Main Street, Apartment 4B',
//         'city': 'New York, NY 10001',
//         'phone': '+1 234 567 8900',
//       },
//       {
//         'name': 'Office',
//         'address': '456 Business Ave, Suite 200',
//         'city': 'New York, NY 10002',
//         'phone': '+1 234 567 8901',
//       },
//     ];
//
//     return Column(
//       children: [
//         ...addresses.asMap().entries.map((entry) {
//           final index = entry.key;
//           final address = entry.value;
//           final isSelected = index == _selectedAddressIndex;
//
//           return GestureDetector(
//             onTap: () => setState(() => _selectedAddressIndex = index),
//             child: Container(
//               margin: const EdgeInsets.only(bottom: 12, left: 20, right: 20),
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 gradient: isSelected
//                     ? LinearGradient(
//                   colors: [
//                     Theme.of(context).primaryColor.withOpacity(0.05),
//                     Theme.of(context).primaryColor.withOpacity(0.02),
//                   ],
//                 )
//                     : null,
//                 color: !isSelected ? Colors.grey[50] : null,
//                 borderRadius: BorderRadius.circular(16),
//                 border: Border.all(
//                   color: isSelected
//                       ? Theme.of(context).primaryColor.withOpacity(0.3)
//                       : Colors.grey[300]!,
//                   width: isSelected ? 2 : 1,
//                 ),
//               ),
//               child: Row(
//                 children: [
//                   Container(
//                     width: 20,
//                     height: 20,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       border: Border.all(
//                         color: isSelected
//                             ? Theme.of(context).primaryColor
//                             : Colors.grey[400]!,
//                         width: 2,
//                       ),
//                     ),
//                     child: isSelected
//                         ? Center(
//                       child: Container(
//                         width: 10,
//                         height: 10,
//                         decoration: BoxDecoration(
//                           color: Theme.of(context).primaryColor,
//                           shape: BoxShape.circle,
//                         ),
//                       ),
//                     )
//                         : null,
//                   ),
//                   const SizedBox(width: 16),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           children: [
//                             Text(
//                               address['name']!,
//                               style: const TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                             const SizedBox(width: 8),
//                             if (index == 0)
//                               Container(
//                                 padding: const EdgeInsets.symmetric(
//                                   horizontal: 8,
//                                   vertical: 2,
//                                 ),
//                                 decoration: BoxDecoration(
//                                   color: Colors.green[100],
//                                   borderRadius: BorderRadius.circular(8),
//                                 ),
//                                 child: Text(
//                                   'Default',
//                                   style: TextStyle(
//                                     fontSize: 11,
//                                     color: Colors.green[700],
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                 ),
//                               ),
//                           ],
//                         ),
//                         const SizedBox(height: 4),
//                         Text(
//                           address['address']!,
//                           style: TextStyle(
//                             fontSize: 14,
//                             color: Colors.grey[700],
//                           ),
//                         ),
//                         Text(
//                           address['city']!,
//                           style: TextStyle(
//                             fontSize: 14,
//                             color: Colors.grey[700],
//                           ),
//                         ),
//                         const SizedBox(height: 4),
//                         Row(
//                           children: [
//                             Icon(
//                               Icons.phone,
//                               size: 14,
//                               color: Colors.grey[600],
//                             ),
//                             const SizedBox(width: 4),
//                             Text(
//                               address['phone']!,
//                               style: TextStyle(
//                                 fontSize: 13,
//                                 color: Colors.grey[600],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   Icon(
//                     Icons.edit_rounded,
//                     size: 20,
//                     color: Colors.grey[400],
//                   ),
//                 ],
//               ),
//             ),
//           );
//         }).toList(),
//
//         // Add New Address Button
//         Container(
//           margin: const EdgeInsets.all(20),
//           child: TextButton(
//             onPressed: () {},
//             style: TextButton.styleFrom(
//               padding: const EdgeInsets.symmetric(vertical: 12),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(
//                   Icons.add_circle_outline,
//                   color: Theme.of(context).primaryColor,
//                   size: 20,
//                 ),
//                 const SizedBox(width: 8),
//                 Text(
//                   'Add New Address',
//                   style: TextStyle(
//                     color: Theme.of(context).primaryColor,
//                     fontSize: 15,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildPaymentSection() {
//     final paymentMethods = [
//       {
//         'name': 'Credit Card',
//         'number': '**** **** **** 1234',
//         'icon': Icons.credit_card,
//         'color': Colors.blue,
//       },
//       {
//         'name': 'PayPal',
//         'number': 'john.doe@example.com',
//         'icon': Icons.account_balance_wallet,
//         'color': Colors.indigo,
//       },
//       {
//         'name': 'Cash on Delivery',
//         'number': 'Pay when you receive',
//         'icon': Icons.money,
//         'color': Colors.green,
//       },
//     ];
//
//     return Column(
//       children: [
//         ...paymentMethods.asMap().entries.map((entry) {
//           final index = entry.key;
//           final method = entry.value;
//           final isSelected = index == _selectedPaymentIndex;
//
//           return GestureDetector(
//             onTap: () => setState(() => _selectedPaymentIndex = index),
//             child: Container(
//               margin: const EdgeInsets.only(bottom: 12, left: 20, right: 20),
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 gradient: isSelected
//                     ? LinearGradient(
//                   colors: [
//                     Theme.of(context).primaryColor.withOpacity(0.05),
//                     Theme.of(context).primaryColor.withOpacity(0.02),
//                   ],
//                 )
//                     : null,
//                 color: !isSelected ? Colors.grey[50] : null,
//                 borderRadius: BorderRadius.circular(16),
//                 border: Border.all(
//                   color: isSelected
//                       ? Theme.of(context).primaryColor.withOpacity(0.3)
//                       : Colors.grey[300]!,
//                   width: isSelected ? 2 : 1,
//                 ),
//               ),
//               child: Row(
//                 children: [
//                   Container(
//                     width: 50,
//                     height: 50,
//                     decoration: BoxDecoration(
//                       color: (method['color'] as Color).withOpacity(0.1),
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Icon(
//                       method['icon'] as IconData,
//                       color: method['color'] as Color,
//                       size: 24,
//                     ),
//                   ),
//                   const SizedBox(width: 16),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           method['name'] as String,
//                           style: const TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                         const SizedBox(height: 4),
//                         Text(
//                           method['number'] as String,
//                           style: TextStyle(
//                             fontSize: 14,
//                             color: Colors.grey[600],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     width: 20,
//                     height: 20,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       border: Border.all(
//                         color: isSelected
//                             ? Theme.of(context).primaryColor
//                             : Colors.grey[400]!,
//                         width: 2,
//                       ),
//                     ),
//                     child: isSelected
//                         ? Center(
//                       child: Container(
//                         width: 10,
//                         height: 10,
//                         decoration: BoxDecoration(
//                           color: Theme.of(context).primaryColor,
//                           shape: BoxShape.circle,
//                         ),
//                       ),
//                     )
//                         : null,
//                   ),
//                 ],
//               ),
//             ),
//           );
//         }).toList(),
//         const SizedBox(height: 20),
//       ],
//     );
//   }
//
//   Widget _buildOrderSummarySection() {
//     return Padding(
//       padding: const EdgeInsets.all(20),
//       child: Column(
//         children: [
//           // Cart Items Preview
//           Container(
//             padding: const EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               color: const Color(0xFFF8F9FA),
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Row(
//               children: [
//                 Container(
//                   width: 60,
//                   height: 60,
//                   decoration: BoxDecoration(
//                     color: Theme.of(context).primaryColor.withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Center(
//                     child: Text(
//                       '3',
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: Theme.of(context).primaryColor,
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 16),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text(
//                         'Total Items',
//                         style: TextStyle(
//                           fontSize: 14,
//                           color: Colors.grey,
//                         ),
//                       ),
//                       const SizedBox(height: 4),
//                       Row(
//                         children: [
//                           Expanded(
//                             child: Text(
//                               'Apple Watch, iPhone 13, AirPods Pro',
//                               style: TextStyle(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w500,
//                                 color: Colors.grey[700],
//                               ),
//                               maxLines: 1,
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 20),
//
//           // Promo Code
//           Container(
//             decoration: BoxDecoration(
//               color: const Color(0xFFF8F9FA),
//               borderRadius: BorderRadius.circular(12),
//               border: Border.all(
//                 color: Colors.grey[300]!,
//                 width: 1,
//               ),
//             ),
//             child: Row(
//               children: [
//                 const SizedBox(width: 16),
//                 Icon(
//                   Icons.discount_outlined,
//                   color: Theme.of(context).colorScheme.secondary,
//                   size: 20,
//                 ),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: TextField(
//                     controller: _promoController,
//                     decoration: const InputDecoration(
//                       hintText: 'Enter promo code',
//                       hintStyle: TextStyle(fontSize: 14),
//                       border: InputBorder.none,
//                       contentPadding: EdgeInsets.symmetric(vertical: 14),
//                     ),
//                     style: const TextStyle(fontSize: 14),
//                   ),
//                 ),
//                 TextButton(
//                   onPressed: () {},
//                   style: TextButton.styleFrom(
//                     padding: const EdgeInsets.symmetric(horizontal: 16),
//                   ),
//                   child: Text(
//                     'Apply',
//                     style: TextStyle(
//                       color: Theme.of(context).primaryColor,
//                       fontWeight: FontWeight.w600,
//                       fontSize: 14,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 20),
//
//           // Summary Details
//           _buildSummaryRow('Subtotal', '\$2,499.00'),
//           const SizedBox(height: 12),
//           _buildSummaryRow('Delivery Fee', 'Free', valueColor: Colors.green[600]),
//           const SizedBox(height: 12),
//           _buildSummaryRow('Tax', '\$124.95'),
//           const SizedBox(height: 16),
//           const Divider(),
//           const SizedBox(height: 16),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               const Text(
//                 'Total',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               Text(
//                 '\$2,623.95',
//                 style: TextStyle(
//                   fontSize: 22,
//                   fontWeight: FontWeight.bold,
//                   color: Theme.of(context).primaryColor,
//                 ),
//               ),
//             ],
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
//   Widget _buildBottomCheckout() {
//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.08),
//             blurRadius: 20,
//             offset: const Offset(0, -10),
//           ),
//         ],
//       ),
//       child: SafeArea(
//         child: Row(
//           children: [
//             Expanded(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Total Amount',
//                     style: TextStyle(
//                       fontSize: 14,
//                       color: Colors.grey[600],
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     '\$2,623.95',
//                     style: TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                       color: Theme.of(context).primaryColor,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(width: 16),
//             Expanded(
//               flex: 2,
//               child: Container(
//                 height: 56,
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [
//                       Theme.of(context).primaryColor,
//                       Theme.of(context).primaryColor.withOpacity(0.8),
//                     ],
//                   ),
//                   borderRadius: BorderRadius.circular(16),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Theme.of(context).primaryColor.withOpacity(0.3),
//                       blurRadius: 20,
//                       offset: const Offset(0, 10),
//                     ),
//                   ],
//                 ),
//                 child: ElevatedButton(
//                   onPressed: () {
//                     HapticFeedback.lightImpact();
//                     _showSuccessDialog();
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.transparent,
//                     shadowColor: Colors.transparent,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(16),
//                     ),
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Container(
//                         padding: const EdgeInsets.all(8),
//                         decoration: BoxDecoration(
//                           color: Colors.white.withOpacity(0.2),
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: const Icon(
//                           Icons.check_circle_outline,
//                           size: 18,
//                           color: Colors.white,
//                         ),
//                       ),
//                       const SizedBox(width: 12),
//                       const Text(
//                         'Place Order',
//                         style: TextStyle(
//                           fontSize: 17,
//                           fontWeight: FontWeight.w600,
//                           color: Colors.white,
//                           letterSpacing: 0.5,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void _showSuccessDialog() {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (context) => Dialog(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(20),
//         ),
//         child: Container(
//           padding: const EdgeInsets.all(24),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Container(
//                 width: 80,
//                 height: 80,
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [
//                       Colors.green[400]!,
//                       Colors.green[600]!,
//                     ],
//                   ),
//                   shape: BoxShape.circle,
//                 ),
//                 child: const Icon(
//                   Icons.check,
//                   color: Colors.white,
//                   size: 40,
//                 ),
//               ),
//               const SizedBox(height: 20),
//               const Text(
//                 'Order Placed!',
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 8),
//               Text(
//                 'Your order has been placed successfully.Order #123456',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontSize: 14,
//                   color: Colors.grey[600],
//                   height: 1.5,
//                 ),
//               ),
//               const SizedBox(height: 24),
//               Row(
//                 children: [
//                   Expanded(
//                     child: TextButton(
//                       onPressed: () {
//                         Navigator.pop(context);
//                         Navigator.pop(context);
//                       },
//                       child: const Text('Continue Shopping'),
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: ElevatedButton(
//                       onPressed: () {
//                         Navigator.pop(context);
//                         // Navigate to orders
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Theme.of(context).primaryColor,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                       child: const Text(
//                         'Track Order',
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
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
//     home: const CheckoutPage(),
//   ));
// }