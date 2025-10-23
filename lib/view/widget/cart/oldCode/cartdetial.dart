//
//
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
//
// import '../../controller/cartController.dart';
// import '../../core/class/handlingDataView.dart';
// import '../../core/class/statusRequest.dart';
// import '../../core/functions/loadingIndicator.dart';
//
// import '../widget/cart/new/checkoutCart.dart';
// import '../widget/cart/new/customCardItemsCart.dart';
//
// class CartDetails extends GetView<CartController> {
//   const CartDetails({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     Get.put(CartController());
//     return Scaffold(
//       backgroundColor: Colors.grey[50],
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0.5,
//         title: GetBuilder<CartController>(
//           builder: (controller) => Column(
//             children: [
//               Text(
//                 'Shopping Cart',
//                 style: TextStyle(
//                   color: Theme.of(context).primaryColor,
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               Text(
//                 '${controller.cartProduct.length} items',
//                 style: TextStyle(
//                   color: Colors.grey[600],
//                   fontSize: 12,
//                   fontWeight: FontWeight.normal,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         centerTitle: true,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back_ios,
//               color: Theme.of(context).primaryColor, size: 20),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       body: GetBuilder<CartController>(
//         builder: (controller) {
//           // Show loading indicator while data is being fetched
//           if (controller.statusRequest == StatusRequest.loading) {
//             return loadingIndicator("loading your cart...");
//           }
//
//           // Show empty cart if no items
//           if (controller.cartProduct.isEmpty) {
//             return _buildEmptyCart(context);
//           }
//
//           // Show cart with items
//           return Column(
//             children: [
//               // Cart Items List
//               Expanded(
//                 child: ListView.builder(
//                   padding: const EdgeInsets.all(16),
//                   itemCount: controller.cartProduct.length,
//                   itemBuilder: (context, index) {
//                     final itemCart = controller.cartProduct[index];
//                     return Padding(
//                       padding: const EdgeInsets.only(bottom: 12),
//                       child: CartListItemWidget(
//                         itemCart: itemCart,
//                         controller: controller,
//                       ),
//                     );
//                   },
//                 ),
//               ),
//
//               // Bottom Checkout Section
//               CheckoutSection(controller: controller),
//             ],
//           );
//         },
//       ),
//     );
//   }
//
//   Widget _buildLoadingIndicator() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           SizedBox(
//             width: 60,
//             height: 60,
//             child: CircularProgressIndicator(
//               strokeWidth: 4,
//               valueColor: AlwaysStoppedAnimation<Color>(
//                 Colors.grey[700]!,
//               ),
//             ),
//           ),
//           const SizedBox(height: 24),
//           Text(
//             'Loading your cart...',
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.w600,
//               color: Colors.grey[800],
//             ),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             'Please wait a moment',
//             style: TextStyle(
//               fontSize: 14,
//               color: Colors.grey[600],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildEmptyCart(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Container(
//             width: 120,
//             height: 120,
//             decoration: BoxDecoration(
//               color: Colors.grey[100],
//               shape: BoxShape.circle,
//             ),
//             child: Icon(
//               Icons.shopping_cart_outlined,
//               size: 60,
//               color: Colors.grey[400],
//             ),
//           ),
//           const SizedBox(height: 24),
//           Text(
//             'Your cart is empty',
//             style: TextStyle(
//               fontSize: 22,
//               fontWeight: FontWeight.bold,
//               color: Colors.grey[800],
//             ),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             'Add items to get started',
//             style: TextStyle(
//               fontSize: 14,
//               color: Colors.grey[600],
//             ),
//           ),
//           const SizedBox(height: 32),
//           ElevatedButton(
//             onPressed: () => Navigator.pop(context),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Theme.of(context).primaryColor,
//               padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10),
//               ),
//             ),
//             child: const Text(
//               'Continue Shopping',
//               style: TextStyle(
//                 fontSize: 15,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.white,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
