// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../../../controller/cartController.dart';
//
//
//
// class CheckoutSection extends StatelessWidget {
//   final CartController controller;
//
//   const CheckoutSection({
//     super.key,
//     required this.controller,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 10,
//             offset: const Offset(0, -5),
//           ),
//         ],
//       ),
//       child: SafeArea(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             // Promo Code Section
//             Container(
//               decoration: BoxDecoration(
//                 color: Colors.grey[50],
//                 borderRadius: BorderRadius.circular(10),
//                 border: Border.all(color: Colors.grey[200]!),
//               ),
//               child: Row(
//                 children: [
//                   const SizedBox(width: 12),
//                   Icon(Icons.confirmation_number_outlined,
//                       color: Theme.of(context).colorScheme.secondary, size: 20),
//                   const SizedBox(width: 10),
//                   Expanded(
//                     child: TextField(
//                       controller: controller.promoController,
//                       decoration: const InputDecoration(
//                         hintText: 'Enter promo code',
//                         hintStyle: TextStyle(fontSize: 14),
//                         border: InputBorder.none,
//                         contentPadding: EdgeInsets.symmetric(vertical: 12),
//                       ),
//                       style: const TextStyle(fontSize: 14),
//                     ),
//                   ),
//                   TextButton(
//                     onPressed: controller.applyPromoCode,
//                     style: TextButton.styleFrom(
//                       padding: const EdgeInsets.symmetric(horizontal: 16),
//                     ),
//                     child: Text(
//                       'Apply',
//                       style: TextStyle(
//                         color: Theme.of(context).primaryColor,
//                         fontWeight: FontWeight.w600,
//                         fontSize: 14,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 16),
//
//             // Order Summary - Only wrap specific reactive parts
//             _buildOrderSummary(context),
//             const SizedBox(height: 16),
//
//             // Checkout Button
//             _buildCheckoutButton(context , controller),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildOrderSummary(BuildContext context) {
//
//     final subtotal = controller.subTotalPrice;
//     final discount = controller.calculateDiscount();
//     final total = controller.calculateTotal();
//     final promoCode = controller.promoCode;
//     final discountPercentage = controller.discountPercentage;
//
//
//
//     return Container(
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.grey[50],
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Column(
//         children: [
//           _buildSummaryRow('Subtotal', '\$${subtotal.toStringAsFixed(2)}'),
//           if (discountPercentage !> 0) ...[
//             const SizedBox(height: 8),
//             _buildSummaryRow(
//               'Discount ($promoCode)',
//               '-\$${discount.toStringAsFixed(2)}',
//               valueColor: Colors.green[600],
//             ),
//           ],
//           const SizedBox(height: 8),
//           _buildSummaryRow('Delivery Fee', 'Free', valueColor: Colors.green[600]),
//           const SizedBox(height: 8),
//           const Divider(height: 16),
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
//                 '\$${total.toStringAsFixed(2)}',
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
// }
//
// Widget _buildCheckoutButton(BuildContext context, CartController controller ) {
//   // Only use Obx if you have an observable variable for cart emptiness
//   return SizedBox(
//     width: double.infinity,
//     height: 50,
//     child: ElevatedButton(
//       onPressed: controller.cartProduct.isNotEmpty
//           ? () {
//         _navigateToCheckout();
//       }
//           : null,
//       style: ElevatedButton.styleFrom(
//         backgroundColor: Theme.of(context).primaryColor,
//         disabledBackgroundColor: Colors.grey[300],
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12),
//         ),
//         elevation: 0,
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const Icon(Icons.lock_outline, size: 18, color: Colors.white),
//           const SizedBox(width: 8),
//           const Text(
//             'Proceed to Checkout',
//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.w600,
//               color: Colors.white,
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }
//
//
// Widget _buildSummaryRow(String label, String value, {Color? valueColor}) {
//   return Row(
//     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     children: [
//       Text(
//         label,
//         style: TextStyle(
//           fontSize: 14,
//           color: Colors.grey[600],
//         ),
//       ),
//       Text(
//         value,
//         style: TextStyle(
//           fontSize: 14,
//           fontWeight: FontWeight.w600,
//           color: valueColor ?? Colors.grey[800],
//         ),
//       ),
//     ],
//   );
// }
//
// void _navigateToCheckout() {
//   Get.snackbar(
//     'Checkout',
//     'Proceeding to checkout...',
//     snackPosition: SnackPosition.BOTTOM,
//   );
// }
