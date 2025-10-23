//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:ramzi_store/controller/cartController.dart';
// import 'package:ramzi_store/data/model/cartModel.dart';
//
// import '../../../../core/class/handlingDataView.dart';
// import '../../../../linkApi.dart';
//
//
//
//
// // Separate Cart Item Widget
// class CartListItemWidget extends StatelessWidget {
//   final MyCartModel itemCart;
//   CartController controller;
//
//
//   CartListItemWidget({
//     super.key,
//     required this.itemCart,
//     required this.controller,
//
//   });
//
//   @override
//   Widget build(BuildContext context) {
//
//
//     return  Dismissible(
//       key: Key(itemCart.itemsId.toString()),
//       direction: DismissDirection.endToStart,
//       background: Container(
//         alignment: Alignment.centerRight,
//         padding: const EdgeInsets.only(right: 20),
//         decoration: BoxDecoration(
//           color: Colors.red[400],
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: const Icon(Icons.delete_outline, color: Colors.white, size: 24),
//       ),
//       onDismissed: (direction) => controller.removeItem(itemCart),
//       child: Container(
//         padding: const EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.04),
//               blurRadius: 8,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Row(
//           children: [
//             // Product Image
//             Container(
//               width: 80,
//               height: 80,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//                 color: Colors.grey[100],
//               ),
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(10),
//                 child: CachedNetworkImage(
//                   imageUrl: "${AppiLink.imageItems}/${itemCart.itemsImage}",
//                   fit: BoxFit.fill,
//                   width: double.infinity,
//                   height: 80,
//                   errorWidget: (context, error, stackTrace) {
//                     return Center(
//                       child: Icon(
//                         Icons.image_not_supported,
//                         color: Colors.grey[400],
//                         size: 40,
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ),
//             const SizedBox(width: 12),
//
//             // Product Details
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "${itemCart.itemsName}",
//                     style: const TextStyle(
//                       fontSize: 15,
//                       fontWeight: FontWeight.w600,
//                       height: 1.3,
//                     ),
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   const SizedBox(height: 6),
//                   Row(
//                     children: [
//                       _buildTag('43mm'),
//                       const SizedBox(width: 6),
//                       _buildTag("red"),
//                     ],
//                   ),
//                   const SizedBox(height: 8),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         '\$${itemCart.sumitemsPrice?.toStringAsFixed(2)}',
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                           color: Theme.of(context).primaryColor,
//                         ),
//                       ),
//                       _buildQuantitySelector(itemCart,controller,context),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildTag(String text) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
//       decoration: BoxDecoration(
//         color: Colors.grey[100],
//         borderRadius: BorderRadius.circular(6),
//       ),
//       child: Text(
//         text,
//         style: TextStyle(
//           color: Colors.grey[700],
//           fontSize: 11,
//           fontWeight: FontWeight.w500,
//         ),
//       ),
//     );
//   }
//
//   Widget _buildQuantitySelector(MyCartModel itemCart, CartController controller, context) {
//     final String itemId = itemCart.itemsId.toString();
//
//     return GetBuilder<CartController>(
//       builder: (controller) {
//         final bool isPending = controller.pendingOperations[itemId] == true;
//         final int currentCount = controller.optimisticCounts[itemId] ?? itemCart.countItems!;
//
//         return Container(
//           decoration: BoxDecoration(
//             color: isPending ? Colors.grey[50] : Colors.grey[100],
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: Row(
//             children: [
//               // Remove Button
//               InkWell(
//                 onTap: isPending ? null : () => controller.remove(itemId),
//                 borderRadius: BorderRadius.circular(8),
//                 child: Container(
//                   padding: const EdgeInsets.all(6),
//                   child: isPending
//                       ? SizedBox(
//                     width: 16,
//                     height: 16,
//                     child: CircularProgressIndicator(
//                       strokeWidth: 1.5,
//                       valueColor: AlwaysStoppedAnimation<Color>(
//                         Colors.grey[400]!,
//                       ),
//                     ),
//                   )
//                       : Icon(
//                     Icons.remove,
//                     size: 16,
//                     color: currentCount > 1 ? Theme.of(context).primaryColor : Colors.grey[400],
//                   ),
//                 ),
//               ),
//
//               // Count Display
//               Container(
//                 constraints: const BoxConstraints(minWidth: 32),
//                 alignment: Alignment.center,
//                 child: Text(
//                   isPending ? "..." : "$currentCount",
//                   style: TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w600,
//                     color: isPending ? Colors.grey[500] : Colors.black,
//                   ),
//                 ),
//               ),
//
//               // Add Button
//               InkWell(
//                 onTap: isPending ? null : () => controller.add(itemId),
//                 borderRadius: BorderRadius.circular(8),
//                 child: Container(
//                   padding: const EdgeInsets.all(6),
//                   child: isPending
//                       ? SizedBox(
//                     width: 16,
//                     height: 16,
//                     child: CircularProgressIndicator(
//                       strokeWidth: 1.5,
//                       valueColor: AlwaysStoppedAnimation<Color>(
//                         Colors.grey[400]!,
//                       ),
//                     ),
//                   )
//                       : Icon(
//                     Icons.add,
//                     size: 16,
//                     color: Theme.of(context).primaryColor,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }