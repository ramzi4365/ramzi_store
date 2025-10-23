//
//
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// // Product Model
// class Product {
//   final String id;
//   final String name;
//   final String description;
//   final double price;
//   final List<String> images;
//   final double rating;
//   final int reviews;
//   final int? discountPercentage;
//   final List<String> sizes;
//   final List<Color> colors;
//   final String category;
//   final bool inStock;
//
//   const Product({
//     required this.id,
//     required this.name,
//     required this.description,
//     required this.price,
//     required this.images,
//     this.rating = 4.5,
//     this.reviews = 124,
//     this.discountPercentage,
//     required this.sizes,
//     required this.colors,
//     required this.category,
//     this.inStock = true,
//   });
//
//   double get finalPrice {
//     if (discountPercentage != null) {
//       return price * (1 - discountPercentage! / 100);
//     }
//     return price;
//   }
// }
//
// // Product Detail Page
// class ProductDetailPage extends StatefulWidget {
//   final Product product;
//
//   const ProductDetailPage({super.key, required this.product});
//
//   @override
//   State<ProductDetailPage> createState() => _ProductDetailPageState();
// }
//
// class _ProductDetailPageState extends State<ProductDetailPage> {
//   final PageController _imageController = PageController();
//   int _currentImageIndex = 0;
//   int _selectedColorIndex = 0;
//   int _selectedSizeIndex = 0;
//   int _quantity = 1;
//   bool _isFavorite = false;
//   bool _showFullDescription = false;
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final screenHeight = MediaQuery.of(context).size.height;
//
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: CustomScrollView(
//         slivers: [
//           // Custom App Bar with Image
//           SliverAppBar(
//             expandedHeight: screenHeight * 0.5,
//             pinned: true,
//             backgroundColor: Colors.white,
//             elevation: 0,
//             leading: Container(
//               margin: const EdgeInsets.all(8),
//               decoration: BoxDecoration(
//                 color: Colors.white.withOpacity(0.9),
//                 shape: BoxShape.circle,
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.1),
//                     blurRadius: 8,
//                     offset: const Offset(0, 2),
//                   ),
//                 ],
//               ),
//               child: IconButton(
//                 icon: const Icon(Icons.arrow_back, color: Colors.black),
//                 onPressed: () => Navigator.pop(context),
//               ),
//             ),
//             actions: [
//               Container(
//                 margin: const EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   color: Colors.white.withOpacity(0.9),
//                   shape: BoxShape.circle,
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.1),
//                       blurRadius: 8,
//                       offset: const Offset(0, 2),
//                     ),
//                   ],
//                 ),
//                 child: IconButton(
//                   icon: Icon(
//                     _isFavorite ? Icons.favorite : Icons.favorite_border,
//                     color: _isFavorite ? Colors.red : Colors.black,
//                   ),
//                   onPressed: () {
//                     setState(() {
//                       _isFavorite = !_isFavorite;
//                     });
//                   },
//                 ),
//               ),
//               Container(
//                 margin: const EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   color: Colors.white.withOpacity(0.9),
//                   shape: BoxShape.circle,
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.1),
//                       blurRadius: 8,
//                       offset: const Offset(0, 2),
//                     ),
//                   ],
//                 ),
//                 child: IconButton(
//                   icon: const Icon(Icons.share, color: Colors.black),
//                   onPressed: () {},
//                 ),
//               ),
//             ],
//             flexibleSpace: FlexibleSpaceBar(
//               background: Stack(
//                 children: [
//                   // Product Images
//                   PageView.builder(
//                     controller: _imageController,
//                     onPageChanged: (index) {
//                       setState(() {
//                         _currentImageIndex = index;
//                       });
//                     },
//                     itemCount: widget.product.images.length,
//                     itemBuilder: (context, index) {
//                       return Image.network(
//                         widget.product.images[index],
//                         fit: BoxFit.cover,
//                       );
//                     },
//                   ),
//                   // Image Indicators
//                   Positioned(
//                     bottom: 20,
//                     left: 0,
//                     right: 0,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: widget.product.images.asMap().entries.map((entry) {
//                         return Container(
//                           width: 8,
//                           height: 8,
//                           margin: const EdgeInsets.symmetric(horizontal: 4),
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: Colors.white.withOpacity(
//                               _currentImageIndex == entry.key ? 1.0 : 0.5,
//                             ),
//                           ),
//                         );
//                       }).toList(),
//                     ),
//                   ),
//                   // Discount Badge
//                   if (widget.product.discountPercentage != null)
//                     Positioned(
//
//                       top: 100,
//                       left: 16,
//                       child: Container(
//                         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                         decoration: BoxDecoration(
//                           color: const Color(0xFFE74C3C),
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         child: Text(
//                           '${widget.product.discountPercentage}% OFF',
//                           style: const TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 12,
//                           ),
//                         ),
//                       ),
//                     ),
//                 ],
//               ),
//             ),
//           ),
//
//           // Product Details
//           SliverToBoxAdapter(
//             child: Container(
//               padding: const EdgeInsets.all(16),
//               decoration: const BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Product Name and Price
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Expanded(
//                         child: Text(
//                           widget.product.name,
//                           style: theme.textTheme.displayMedium,
//                         ),
//                       ),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           if (widget.product.discountPercentage != null)
//                             Text(
//                               '\$${widget.product.price.toStringAsFixed(2)}',
//                               style: TextStyle(
//                                 fontSize: 14,
//                                 color: Colors.grey,
//                                 decoration: TextDecoration.lineThrough,
//                               ),
//                             ),
//                           Text(
//                             '\$${widget.product.finalPrice.toStringAsFixed(2)}',
//                             style: TextStyle(
//                               fontSize: 24,
//                               fontWeight: FontWeight.bold,
//                               color: theme.colorScheme.secondary,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 8),
//
//                   // Rating and Reviews
//                   Row(
//                     children: [
//                       ...List.generate(5, (index) {
//                         return Icon(
//                           index < widget.product.rating.floor()
//                               ? Icons.star
//                               : Icons.star_border,
//                           color: const Color(0xFFFFD700),
//                           size: 20,
//                         );
//                       }),
//                       const SizedBox(width: 8),
//                       Text(
//                         '${widget.product.rating}',
//                         style: const TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                       const SizedBox(width: 4),
//                       Text(
//                         '(${widget.product.reviews} reviews)',
//                         style: TextStyle(color: Colors.grey[600]),
//                       ),
//                       const Spacer(),
//                       TextButton(
//                         onPressed: () {},
//                         child: const Text('See all reviews'),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 24),
//
//                   // Color Selection
//                   _buildSectionTitle('Color'),
//                   const SizedBox(height: 12),
//                   Row(
//                     children: widget.product.colors.asMap().entries.map((entry) {
//                       final index = entry.key;
//                       final color = entry.value;
//                       final isSelected = _selectedColorIndex == index;
//
//                       return GestureDetector(
//                         onTap: () {
//                           setState(() {
//                             _selectedColorIndex = index;
//                           });
//                         },
//                         child: Container(
//                           margin: const EdgeInsets.only(right: 12),
//                           width: 40,
//                           height: 40,
//                           decoration: BoxDecoration(
//                             color: color,
//                             shape: BoxShape.circle,
//                             border: Border.all(
//                               color: isSelected
//                                   ? theme.colorScheme.primary
//                                   : Colors.grey.shade300,
//                               width: isSelected ? 3 : 1,
//                             ),
//                           ),
//                           child: isSelected
//                               ? Icon(
//                             Icons.check,
//                             color: color.computeLuminance() > 0.5
//                                 ? Colors.black
//                                 : Colors.white,
//                             size: 20,
//                           )
//                               : null,
//                         ),
//                       );
//                     }).toList(),
//                   ),
//                   const SizedBox(height: 24),
//
//                   // Size Selection
//                   _buildSectionTitle('Size'),
//                   const SizedBox(height: 12),
//                   Row(
//                     children: widget.product.sizes.asMap().entries.map((entry) {
//                       final index = entry.key;
//                       final size = entry.value;
//                       final isSelected = _selectedSizeIndex == index;
//
//                       return GestureDetector(
//                         onTap: () {
//                           setState(() {
//                             _selectedSizeIndex = index;
//                           });
//                         },
//                         child: Container(
//                           margin: const EdgeInsets.only(right: 12),
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 20,
//                             vertical: 10,
//                           ),
//                           decoration: BoxDecoration(
//                             color: isSelected
//                                 ? theme.colorScheme.primary
//                                 : Colors.white,
//                             borderRadius: BorderRadius.circular(8),
//                             border: Border.all(
//                               color: isSelected
//                                   ? theme.colorScheme.primary
//                                   : Colors.grey.shade300,
//                             ),
//                           ),
//                           child: Text(
//                             size,
//                             style: TextStyle(
//                               color: isSelected ? Colors.white : Colors.black,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ),
//                       );
//                     }).toList(),
//                   ),
//                   const SizedBox(height: 24),
//
//                   // Quantity Selector
//                   _buildSectionTitle('Quantity'),
//                   const SizedBox(height: 12),
//                   Container(
//                     decoration: BoxDecoration(
//                       color: Colors.grey[100],
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         IconButton(
//                           onPressed: () {
//                             if (_quantity > 1) {
//                               setState(() {
//                                 _quantity--;
//                               });
//                             }
//                           },
//                           icon: const Icon(Icons.remove),
//                         ),
//                         Container(
//                           padding: const EdgeInsets.symmetric(horizontal: 20),
//                           child: Text(
//                             _quantity.toString(),
//                             style: const TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                         IconButton(
//                           onPressed: () {
//                             setState(() {
//                               _quantity++;
//                             });
//                           },
//                           icon: const Icon(Icons.add),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 24),
//
//                   // Description
//                   _buildSectionTitle('Description'),
//                   const SizedBox(height: 12),
//                   Text(
//                     widget.product.description,
//                     style: TextStyle(
//                       color: Colors.grey[700],
//                       height: 1.5,
//                     ),
//                     maxLines: _showFullDescription ? null : 3,
//                     overflow: _showFullDescription ? null : TextOverflow.ellipsis,
//                   ),
//                   TextButton(
//                     onPressed: () {
//                       setState(() {
//                         _showFullDescription = !_showFullDescription;
//                       });
//                     },
//                     child: Text(
//                       _showFullDescription ? 'Show less' : 'Read more',
//                       style: TextStyle(color: theme.colorScheme.primary),
//                     ),
//                   ),
//                   const SizedBox(height: 24),
//
//                   // Product Details
//                   _buildSectionTitle('Product Details'),
//                   const SizedBox(height: 12),
//                   _buildDetailRow('Category', widget.product.category),
//                   _buildDetailRow('SKU', 'PRD-${widget.product.id}'),
//                   _buildDetailRow('Stock', widget.product.inStock ? 'In Stock' : 'Out of Stock'),
//                   _buildDetailRow('Shipping', 'Free shipping on orders over \$50'),
//                   const SizedBox(height: 100), // Space for bottom bar
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//       // Bottom Bar
//       bottomNavigationBar: Container(
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.1),
//               blurRadius: 10,
//               offset: const Offset(0, -2),
//             ),
//           ],
//         ),
//         child: SafeArea(
//           child: Row(
//             children: [
//               Container(
//                 width: 50,
//                 height: 50,
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.grey.shade300),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: IconButton(
//                   icon: const Icon(Icons.shopping_cart_outlined),
//                   onPressed: () {},
//                 ),
//               ),
//               const SizedBox(width: 16),
//               Expanded(
//                 child: ElevatedButton(
//                   onPressed: widget.product.inStock ? () {} : null,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: theme.colorScheme.primary,
//                     disabledBackgroundColor: Colors.grey[300],
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     padding: const EdgeInsets.symmetric(vertical: 16),
//                   ),
//                   child: Text(
//                     widget.product.inStock ? 'Add to Cart' : 'Out of Stock',
//                     style: const TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildSectionTitle(String title) {
//     return Text(
//       title,
//       style: const TextStyle(
//         fontSize: 18,
//         fontWeight: FontWeight.bold,
//       ),
//     );
//   }
//
//   Widget _buildDetailRow(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             label,
//             style: TextStyle(color: Colors.grey[600]),
//           ),
//           Text(
//             value,
//             style: const TextStyle(fontWeight: FontWeight.w500),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// // Updated Product Card with Navigation
// class ProductCard extends StatelessWidget {
//   final Product product;
//
//   const ProductCard({super.key, required this.product});
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final isDiscounted = product.discountPercentage != null;
//
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => ProductDetailPage(product: product),
//           ),
//         );
//       },
//       child: Container(
//         width: 160,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(16),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.08),
//               blurRadius: 10,
//               offset: const Offset(0, 4),
//             ),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Product Image
//             Stack(
//               children: [
//                 ClipRRect(
//                   borderRadius: const BorderRadius.vertical(
//                     top: Radius.circular(16),
//                   ),
//                   child: Image.network(
//                     product.images.first,
//                     height: 120,
//                     width: double.infinity,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 if (isDiscounted)
//                   Positioned(
//                     top: 8,
//                     left: 8,
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                       decoration: BoxDecoration(
//                         color: theme.colorScheme.secondary,
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: Text(
//                         '${product.discountPercentage}% OFF',
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontSize: 12,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ),
//               ],
//             ),
//             // Product Details
//             Padding(
//               padding: const EdgeInsets.all(12),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     product.name,
//                     style: theme.textTheme.bodyLarge?.copyWith(
//                       fontWeight: FontWeight.w600,
//                     ),
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     '\$${product.finalPrice.toStringAsFixed(2)}',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: theme.colorScheme.secondary,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// // Example Usage
// void main() {
//   runApp(MaterialApp(
//     theme: ThemeData(
//       fontFamily: "PlayfairDisplay",
//       primaryColor: const Color(0xFF2C3E50),
//       colorScheme: const ColorScheme.light(
//         primary: Color(0xFF2C3E50),
//         secondary: Color(0xFFE74C3C),
//         surface: Color(0xFFF8F9FA),
//       ),
//     ),
//     home: Scaffold(
//       body: Center(
//         child: ProductCard(
//           product: Product(
//             id: '1',
//             name: 'Wireless Headphones',
//             description: 'Experience crystal-clear sound with our premium wireless headphones. '
//                 'Featuring advanced noise cancellation technology, 30-hour battery life, '
//                 'and supreme comfort for all-day wear. Perfect for music lovers, commuters, '
//                 'and professionals who demand the best audio quality.',
//             price: 79.99,
//             images: [
//               'https://via.placeholder.com/400x400?text=Headphones+1',
//               'https://via.placeholder.com/400x400?text=Headphones+2',
//               'https://via.placeholder.com/400x400?text=Headphones+3',
//             ],
//             rating: 4.8,
//             reviews: 124,
//             discountPercentage: 15,
//             sizes: ['S', 'M', 'L', 'XL'],
//             colors: [Colors.black, Colors.white, Colors.blue, Colors.red],
//             category: 'Electronics',
//           ),
//         ),
//       ),
//     ),
//   ));
// }