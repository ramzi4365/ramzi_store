// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:flutter/services.dart';
//
// // Product Model (unchanged)
// class Product {
//   final String id;
//   final String name;
//   final String description;
//   final double price;
//   final double? oldPrice;
//   final List<String> images;
//   final double rating;
//   final int reviews;
//   final int? discount;
//   final List<String> sizes;
//   final List<Color> colors;
//   final String category;
//   final bool inStock;
//   final bool? isNew;
//
//   const Product({
//     required this.id,
//     required this.name,
//     required this.description,
//     required this.price,
//     this.oldPrice,
//     required this.images,
//     this.rating = 4.5,
//     this.reviews = 124,
//     this.discount,
//     required this.sizes,
//     required this.colors,
//     required this.category,
//     this.inStock = true,
//     this.isNew,
//   });
//
// // Removed getters as requested
// }
//
// // Compact Product Detail Page
// class ProductDetailPage extends StatelessWidget {
//   final Product product;
//
//   ProductDetailPage({super.key, required this.product});
//
//   final ProductDetailController controller = Get.put(ProductDetailController());
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final screenHeight = MediaQuery.of(context).size.height;
//
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Stack(
//         children: [
//           CustomScrollView(
//             slivers: [
//               // Image Gallery
//               SliverAppBar(
//                 expandedHeight: screenHeight * 0.45,
//                 pinned: true,
//                 backgroundColor: Colors.white,
//                 elevation: 0,
//                 leading: _buildAppBarButton(
//                   icon: Icons.arrow_back_ios_new,
//                   onPressed: () => Navigator.pop(context),
//                 ),
//                 actions: [
//                   GetBuilder<ProductDetailController>(
//                     builder: (controller) => _buildAppBarButton(
//                       icon: controller.isFavorite
//                           ? Icons.favorite
//                           : Icons.favorite_outline,
//                       onPressed: () => controller.toggleFavorite(),
//                       color: controller.isFavorite ? Colors.red : null,
//                     ),
//                   ),
//                   _buildAppBarButton(
//                     icon: Icons.share_outlined,
//                     onPressed: () {},
//                   ),
//                   const SizedBox(width: 8),
//                 ],
//                 flexibleSpace: FlexibleSpaceBar(
//                   background: Stack(
//                     children: [
//                       PageView.builder(
//                         controller: controller.imageController,
//                         onPageChanged: (index) {
//                           controller.changeImageIndex(index);
//                         },
//                         itemCount: product.images.length,
//                         itemBuilder: (context, index) {
//                           return Image.network(
//                             product.images[index],
//                             fit: BoxFit.cover,
//                             errorBuilder: (context, error, stackTrace) {
//                               return Container(
//                                 color: Colors.grey[200],
//                                 child: const Icon(Icons.image, size: 50),
//                               );
//                             },
//                           );
//                         },
//                       ),
//
//                       // Thumbnail Preview
//                       Positioned(
//                         bottom: 30,
//                         left: 20,
//                         right: 20,
//                         child: SizedBox(
//                           height: 60,
//                           child: ListView.builder(
//                             scrollDirection: Axis.horizontal,
//                             shrinkWrap: true,
//                             physics: const ClampingScrollPhysics(),
//                             itemCount: product.images.length,
//                             itemBuilder: (context, index) {
//                               final isSelected = controller.currentImageIndex == index;
//                               return GestureDetector(
//                                 onTap: () {
//                                   controller.imageController.animateToPage(
//                                     index,
//                                     duration: const Duration(milliseconds: 300),
//                                     curve: Curves.easeInOut,
//                                   );
//                                 },
//                                 child: AnimatedContainer(
//                                   duration: const Duration(milliseconds: 200),
//                                   margin: const EdgeInsets.only(right: 8),
//                                   width: isSelected ? 65 : 55,
//                                   height: isSelected ? 65 : 55,
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(12),
//                                     border: Border.all(
//                                       color: isSelected
//                                           ? Colors.white
//                                           : Colors.white.withOpacity(0.5),
//                                       width: isSelected ? 3 : 2,
//                                     ),
//                                     boxShadow: [
//                                       BoxShadow(
//                                         color: Colors.black.withOpacity(0.2),
//                                         blurRadius: 8,
//                                         offset: const Offset(0, 2),
//                                       ),
//                                     ],
//                                   ),
//                                   child: ClipRRect(
//                                     borderRadius: BorderRadius.circular(10),
//                                     child: Image.network(
//                                       product.images[index],
//                                       fit: BoxFit.cover,
//                                       errorBuilder: (context, error, stackTrace) {
//                                         return Container(
//                                           color: Colors.grey[200],
//                                           child: Icon(
//                                             Icons.image,
//                                             color: Colors.grey[400],
//                                           ),
//                                         );
//                                       },
//                                     ),
//                                   ),
//                                 ),
//                               );
//                             },
//                           ),
//                         ),
//                       ),
//
//                       // Badges
//                       Positioned(
//                         top: 80,
//                         left: 16,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             if (product.discount != null)
//                               _buildBadge(
//                                 '${product.discount}% OFF',
//                                 theme.colorScheme.secondary,
//                               ),
//                             if (product.isNew == true)
//                               Padding(
//                                 padding: const EdgeInsets.only(top: 8),
//                                 child: _buildBadge('NEW', Colors.green),
//                               ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//
//               // Product Details
//               SliverToBoxAdapter(
//                 child: FadeTransition(
//                   opacity: controller.fadeAnimation,
//                   child: Container(
//                     decoration: const BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.vertical(
//                         top: Radius.circular(24),
//                       ),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(20),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           _buildProductHeader(theme, product),
//                           const SizedBox(height: 20),
//                           _buildPriceRating(theme, product, controller),
//                           const SizedBox(height: 24),
//                           _buildColorSelection(theme, product, controller),
//                           const SizedBox(height: 24),
//                           _buildSizeSelection(theme, product, controller),
//                           const SizedBox(height: 24),
//                           _buildQuantitySection(theme, product, controller),
//                           const SizedBox(height: 24),
//                           _buildDescription(theme, product, controller),
//                           const SizedBox(height: 24),
//                           _buildInfoGrid(theme),
//                           const SizedBox(height: 100),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//
//           // Bottom Bar
//           _buildBottomBar(theme, product, controller),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildAppBarButton({
//     required IconData icon,
//     required VoidCallback onPressed,
//     Color? color,
//   }) {
//     return Container(
//       margin: const EdgeInsets.all(8),
//       decoration: BoxDecoration(
//         color: Colors.white.withOpacity(0.9),
//         shape: BoxShape.circle,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 5,
//           ),
//         ],
//       ),
//       child: IconButton(
//         icon: Icon(icon, color: color ?? Colors.black87, size: 18),
//         onPressed: onPressed,
//       ),
//     );
//   }
//
//   Widget _buildBadge(String text, Color color) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
//       decoration: BoxDecoration(
//         color: color,
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Text(
//         text,
//         style: const TextStyle(
//           color: Colors.white,
//           fontSize: 12,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//     );
//   }
//
//   Widget _buildProductHeader(ThemeData theme, Product product) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//           padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//           decoration: BoxDecoration(
//             color: theme.primaryColor.withOpacity(0.1),
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Text(
//             product.category.toUpperCase(),
//             style: TextStyle(
//               fontSize: 11,
//               fontWeight: FontWeight.w600,
//               color: theme.primaryColor,
//               letterSpacing: 0.5,
//             ),
//           ),
//         ),
//         const SizedBox(height: 8),
//         Text(
//           product.name,
//           style: const TextStyle(
//             fontSize: 22,
//             fontWeight: FontWeight.bold,
//             color: Colors.black87,
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildPriceRating(ThemeData theme, Product product, ProductDetailController controller) {
//     final finalPrice = controller.calculateFinalPrice(product.price, product.oldPrice);
//     final savedAmount = controller.calculateSavedAmount(product.price, product.oldPrice);
//
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.baseline,
//               textBaseline: TextBaseline.alphabetic,
//               children: [
//                 Text(
//                   '\$${finalPrice.toStringAsFixed(2)}',
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     color: theme.primaryColor,
//                   ),
//                 ),
//                 if (product.oldPrice != null) ...[
//                   const SizedBox(width: 8),
//                   Text(
//                     '\$${product.oldPrice!.toStringAsFixed(2)}',
//                     style: const TextStyle(
//                       fontSize: 16,
//                       color: Colors.grey,
//                       decoration: TextDecoration.lineThrough,
//                     ),
//                   ),
//                 ],
//               ],
//             ),
//             if (savedAmount > 0)
//               Text(
//                 'Save \$${savedAmount.toStringAsFixed(2)}',
//                 style: const TextStyle(
//                   fontSize: 12,
//                   color: Colors.green,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//           ],
//         ),
//         Container(
//           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//           decoration: BoxDecoration(
//             color: Colors.amber.withOpacity(0.1),
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Row(
//             children: [
//               const Icon(Icons.star, color: Colors.amber, size: 18),
//               const SizedBox(width: 4),
//               Text(
//                 product.rating.toString(),
//                 style: const TextStyle(fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(width: 6),
//               Text(
//                 '(${product.reviews})',
//                 style: TextStyle(color: Colors.grey[600], fontSize: 12),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildColorSelection(ThemeData theme, Product product, ProductDetailController controller) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Color',
//           style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 12),
//         Row(
//           children: List.generate(
//             product.colors.length,
//                 (index) {
//               final color = product.colors[index];
//               final isSelected = controller.selectedColorIndex == index;
//               return GestureDetector(
//                 onTap: () => controller.changeColorIndex(index),
//                 child: Container(
//                   margin: const EdgeInsets.only(right: 10),
//                   width: 36,
//                   height: 36,
//                   decoration: BoxDecoration(
//                     color: color,
//                     shape: BoxShape.circle,
//                     border: Border.all(
//                       color: isSelected ? theme.primaryColor : Colors.grey[300]!,
//                       width: isSelected ? 2.5 : 1,
//                     ),
//                   ),
//                   child: isSelected
//                       ? Icon(
//                     Icons.check,
//                     color: color.computeLuminance() > 0.5
//                         ? Colors.black
//                         : Colors.white,
//                     size: 18,
//                   )
//                       : null,
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildSizeSelection(ThemeData theme, Product product, ProductDetailController controller) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             const Text(
//               'Size',
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             ),
//             TextButton.icon(
//               onPressed: () {},
//               icon: const Icon(Icons.straighten, size: 16),
//               label: const Text('Size Guide', style: TextStyle(fontSize: 12)),
//               style: TextButton.styleFrom(
//                 foregroundColor: theme.colorScheme.secondary,
//                 padding: EdgeInsets.zero,
//                 visualDensity: VisualDensity.compact,
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 8),
//         Row(
//           children: List.generate(
//             product.sizes.length,
//                 (index) {
//               final size = product.sizes[index];
//               final isSelected = controller.selectedSizeIndex == index;
//               return GestureDetector(
//                 onTap: () => controller.changeSizeIndex(index),
//                 child: Container(
//                   margin: const EdgeInsets.only(right: 8),
//                   width: 45,
//                   height: 45,
//                   decoration: BoxDecoration(
//                     color: isSelected ? theme.primaryColor : Colors.white,
//                     borderRadius: BorderRadius.circular(10),
//                     border: Border.all(
//                       color: isSelected ? theme.primaryColor : Colors.grey[300]!,
//                     ),
//                   ),
//                   child: Center(
//                     child: Text(
//                       size,
//                       style: TextStyle(
//                         color: isSelected ? Colors.white : Colors.black,
//                         fontWeight: FontWeight.w600,
//                         fontSize: 14,
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildQuantitySection(ThemeData theme, Product product, ProductDetailController controller) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               'Quantity',
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 4),
//             Row(
//               children: [
//                 Container(
//                   width: 6,
//                   height: 6,
//                   decoration: BoxDecoration(
//                     color: product.inStock ? Colors.green : Colors.red,
//                     shape: BoxShape.circle,
//                   ),
//                 ),
//                 const SizedBox(width: 6),
//                 Text(
//                   product.inStock ? 'In Stock' : 'Out of Stock',
//                   style: TextStyle(
//                     color: product.inStock ? Colors.green : Colors.red,
//                     fontSize: 12,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//         Container(
//           decoration: BoxDecoration(
//             color: Colors.grey[100],
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: Row(
//             children: [
//               IconButton(
//                 onPressed: controller.quantity > 1
//                     ? () => controller.decrementQuantity()
//                     : null,
//                 icon: const Icon(Icons.remove, size: 18),
//                 constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
//               ),
//               Container(
//                 constraints: const BoxConstraints(minWidth: 40),
//                 alignment: Alignment.center,
//                 child: GetBuilder<ProductDetailController>(
//                   builder: (controller) => Text(
//                     controller.quantity.toString(),
//                     style: const TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//               IconButton(
//                 onPressed: () => controller.incrementQuantity(),
//                 icon: const Icon(Icons.add, size: 18),
//                 constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildDescription(ThemeData theme, Product product, ProductDetailController controller) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Description',
//           style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 8),
//         GetBuilder<ProductDetailController>(
//           builder: (controller) => AnimatedCrossFade(
//             firstChild: Text(
//               product.description,
//               style: TextStyle(
//                 color: Colors.grey[700],
//                 height: 1.5,
//                 fontSize: 14,
//               ),
//               maxLines: 3,
//               overflow: TextOverflow.ellipsis,
//             ),
//             secondChild: Text(
//               product.description,
//               style: TextStyle(
//                 color: Colors.grey[700],
//                 height: 1.5,
//                 fontSize: 14,
//               ),
//             ),
//             crossFadeState: controller.showFullDescription
//                 ? CrossFadeState.showSecond
//                 : CrossFadeState.showFirst,
//             duration: const Duration(milliseconds: 300),
//           ),
//         ),
//         TextButton(
//           onPressed: () => controller.toggleDescription(),
//           style: TextButton.styleFrom(
//             padding: EdgeInsets.zero,
//             visualDensity: VisualDensity.compact,
//           ),
//           child: GetBuilder<ProductDetailController>(
//             builder: (controller) => Text(
//               controller.showFullDescription ? 'Show less' : 'Read more',
//               style: TextStyle(
//                 color: theme.primaryColor,
//                 fontSize: 13,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildInfoGrid(ThemeData theme) {
//     return GridView.count(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       crossAxisCount: 2,
//       childAspectRatio: 2.5,
//       crossAxisSpacing: 10,
//       mainAxisSpacing: 10,
//       children: [
//         _buildInfoItem(Icons.local_shipping, 'Free Shipping', Colors.blue),
//         _buildInfoItem(Icons.assignment_return, '30-Day Returns', Colors.green),
//         _buildInfoItem(Icons.verified_user, 'Authentic', Colors.orange),
//         _buildInfoItem(Icons.support_agent, '24/7 Support', Colors.purple),
//       ],
//     );
//   }
//
//   Widget _buildInfoItem(IconData icon, String text, Color color) {
//     return Container(
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: color.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Row(
//         children: [
//           Icon(icon, color: color, size: 20),
//           const SizedBox(width: 8),
//           Expanded(
//             child: Text(
//               text,
//               style: TextStyle(
//                 color: color,
//                 fontSize: 12,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildBottomBar(ThemeData theme, Product product, ProductDetailController controller) {
//     return Positioned(
//       bottom: 0,
//       left: 0,
//       right: 0,
//       child: GetBuilder<ProductDetailController>(
//         builder: (controller) => Container(
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.05),
//                 blurRadius: 10,
//                 offset: const Offset(0, -5),
//               ),
//             ],
//           ),
//           child: SafeArea(
//             child: Row(
//               children: [
//                 Container(
//                   width: 48,
//                   height: 48,
//                   decoration: BoxDecoration(
//                     color: controller.isFavorite
//                         ? Colors.red.withOpacity(0.1)
//                         : Colors.grey[100],
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: IconButton(
//                     icon: Icon(
//                       controller.isFavorite ? Icons.favorite : Icons.favorite_outline,
//                       color: controller.isFavorite ? Colors.red : Colors.grey[700],
//                       size: 22,
//                     ),
//                     onPressed: () => controller.toggleFavorite(),
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: SizedBox(
//                     height: 48,
//                     child: ElevatedButton(
//                       onPressed: product.inStock && !controller.isAddingToCart
//                           ? () => controller.addToCart(product)
//                           : null,
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: theme.primaryColor,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                       child: controller.isAddingToCart
//                           ? const SizedBox(
//                         width: 20,
//                         height: 20,
//                         child: CircularProgressIndicator(
//                           strokeWidth: 2,
//                           valueColor: AlwaysStoppedAnimation<Color>(
//                             Colors.white,
//                           ),
//                         ),
//                       )
//                           : Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           const Icon(Icons.shopping_cart, size: 18),
//                           const SizedBox(width: 8),
//                           Text(
//                             'Add to Cart • \$${(product.price * controller.quantity).toStringAsFixed(2)}',
//                             style: const TextStyle(
//                               fontSize: 14,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//
//
// class ProductDetailController extends GetxController
//     with SingleGetTickerProviderMixin {
//   final PageController imageController = PageController();
//   late AnimationController fadeController;
//   late Animation<double> fadeAnimation;
//
//   // Regular variables instead of observables
//   int currentImageIndex = 0;
//   int selectedColorIndex = 0;
//   int selectedSizeIndex = 0;
//   int quantity = 1;
//   bool isFavorite = false;
//   bool showFullDescription = false;
//   bool isAddingToCart = false;
//
//   // Methods to calculate values instead of getters
//   double calculateFinalPrice(double price, double? oldPrice) {
//     return oldPrice ?? price;
//   }
//
//   double calculateSavedAmount(double price, double? oldPrice) {
//     return oldPrice != null ? oldPrice - price : 0;
//   }
//
//   @override
//   void onInit() {
//     super.onInit();
//     fadeController = AnimationController(
//       duration: const Duration(milliseconds: 500),
//       vsync: this,
//     );
//     fadeAnimation = CurvedAnimation(
//       parent: fadeController,
//       curve: Curves.easeIn,
//     );
//     fadeController.forward();
//   }
//
//   @override
//   void onClose() {
//     fadeController.dispose();
//     imageController.dispose();
//     super.onClose();
//   }
//
//   void changeImageIndex(int index) {
//     currentImageIndex = index;
//     update(); // Manually update the UI
//   }
//
//   void changeColorIndex(int index) {
//     selectedColorIndex = index;
//     update(); // Manually update the UI
//   }
//
//   void changeSizeIndex(int index) {
//     selectedSizeIndex = index;
//     update(); // Manually update the UI
//   }
//
//   void incrementQuantity() {
//     quantity++;
//     update(); // Manually update the UI
//   }
//
//   void decrementQuantity() {
//     if (quantity > 1) {
//       quantity--;
//       update(); // Manually update the UI
//     }
//   }
//
//   void toggleFavorite() {
//     isFavorite = !isFavorite;
//     update(); // Manually update the UI
//   }
//
//   void toggleDescription() {
//     showFullDescription = !showFullDescription;
//     update(); // Manually update the UI
//   }
//
//   Future<void> addToCart(Product product) async {
//     isAddingToCart = true;
//     update(); // Manually update the UI
//
//     await Future.delayed(const Duration(seconds: 1));
//
//     isAddingToCart = false;
//     update(); // Manually update the UI
//
//     Get.snackbar(
//       'Added to Cart',
//       '${product.name} added to cart',
//       snackPosition: SnackPosition.BOTTOM,
//       backgroundColor: Colors.green,
//       colorText: Colors.white,
//       borderRadius: 8,
//     );
//   }
// }