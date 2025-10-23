//
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// void main() {
//   runApp(ProductListingApp());
// }
//
// class ProductListingApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'ShopEasy',
//       theme: ThemeData(
//         primaryColor: Color(0xFF2C3E50),
//         colorScheme: ColorScheme.light(
//           primary: Color(0xFF2C3E50),
//           secondary: Color(0xFFE74C3C),
//           surface: Color(0xFFF8F9FA),
//         ),
//         fontFamily: 'SF Pro Display',
//         appBarTheme: AppBarTheme(
//           elevation: 0,
//           backgroundColor: Colors.transparent,
//           systemOverlayStyle: SystemUiOverlayStyle.dark,
//         ),
//       ),
//       home: ProductListingPage(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }
//
// class Product {
//   final String name;
//   final double price;
//   final String category;
//   final String imageUrl;
//   final double rating;
//   final int reviews;
//   final String description;
//
//   Product({
//     required this.name,
//     required this.price,
//     required this.category,
//     required this.imageUrl,
//     required this.rating,
//     required this.reviews,
//     required this.description,
//   });
// }
//
// class ProductListingPage extends StatefulWidget {
//   @override
//   _ProductListingPageState createState() => _ProductListingPageState();
// }
//
// class _ProductListingPageState extends State<ProductListingPage>
//     with TickerProviderStateMixin {
//   int _cartCount = 3;
//   int _selectedCategoryIndex = 0;
//   final TextEditingController _searchController = TextEditingController();
//   late AnimationController _animationController;
//   Set<int> _favoriteProducts = {};
//
//   final List<String> categories = [
//     'All',
//     'Laptop',
//     'Mobile',
//     'Camera',
//     'Shoes',
//     'Dress',
//     'Glassware'
//   ];
//
//   final List<String> categoryIcons = [
//     '🏠',
//     '💻',
//     '📱',
//     '📷',
//     '👟',
//     '👗',
//     '🍷'
//   ];
//
//   final List<Product> products = [
//     Product(
//       name: 'MacBook Pro 16"',
//       price: 2399.99,
//       category: 'Laptop',
//       imageUrl: 'https://picsum.photos/250/200?random=1',
//       rating: 4.8,
//       reviews: 324,
//       description: 'Powerful laptop for professionals',
//     ),
//     Product(
//       name: 'iPhone 14 Pro',
//       price: 999.99,
//       category: 'Mobile',
//       imageUrl: 'https://picsum.photos/250/200?random=2',
//       rating: 4.9,
//       reviews: 1203,
//       description: 'Latest flagship smartphone',
//     ),
//     Product(
//       name: 'Canon EOS R5',
//       price: 3899.99,
//       category: 'Camera',
//       imageUrl: 'https://picsum.photos/250/200?random=3',
//       rating: 4.7,
//       reviews: 89,
//       description: 'Professional mirrorless camera',
//     ),
//     Product(
//       name: 'Nike Air Max',
//       price: 129.99,
//       category: 'Shoes',
//       imageUrl: 'https://picsum.photos/250/200?random=4',
//       rating: 4.6,
//       reviews: 456,
//       description: 'Comfortable running shoes',
//     ),
//     Product(
//       name: 'Floral Summer Dress',
//       price: 59.99,
//       category: 'Dress',
//       imageUrl: 'https://picsum.photos/250/200?random=5',
//       rating: 4.5,
//       reviews: 234,
//       description: 'Elegant summer collection',
//     ),
//     Product(
//       name: 'Crystal Wine Set',
//       price: 89.99,
//       category: 'Glassware',
//       imageUrl: 'https://picsum.photos/250/200?random=6',
//       rating: 4.8,
//       reviews: 67,
//       description: 'Premium crystal glassware',
//     ),
//     Product(
//       name: 'Dell XPS 13',
//       price: 1299.99,
//       category: 'Laptop',
//       imageUrl: 'https://picsum.photos/250/200?random=7',
//       rating: 4.7,
//       reviews: 892,
//       description: 'Ultra-portable laptop',
//     ),
//     Product(
//       name: 'Samsung Galaxy S23',
//       price: 899.99,
//       category: 'Mobile',
//       imageUrl: 'https://picsum.photos/250/200?random=8',
//       rating: 4.8,
//       reviews: 1567,
//       description: 'Android flagship phone',
//     ),
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       duration: Duration(milliseconds: 300),
//       vsync: this,
//     );
//   }
//
//   @override
//   void dispose() {
//     _animationController.dispose();
//     _searchController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Theme
//           .of(context)
//           .colorScheme
//           .surface,
//       body: SafeArea(
//         child: Column(
//           children: [
//             // Header Section
//             _buildHeader(),
//
//             // Category Navigation
//             _buildCategoryNavigation(),
//
//             // Products Section Header
//             _buildSectionHeader(),
//
//             // Product Display Section
//             Expanded(
//               child: _buildProductGrid(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildHeader() {
//     return Container(
//       padding: EdgeInsets.fromLTRB(20, 20, 20, 16),
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               // Logo and Welcome
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'ShopEasy',
//                     style: TextStyle(
//                       fontSize: 28,
//                       fontWeight: FontWeight.w800,
//                       color: Theme
//                           .of(context)
//                           .primaryColor,
//                       letterSpacing: -0.5,
//                     ),
//                   ),
//                   SizedBox(height: 4),
//                   Text(
//                     'Discover amazing products',
//                     style: TextStyle(
//                       fontSize: 14,
//                       color: Colors.grey[600],
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ),
//                 ],
//               ),
//
//               // Action Icons
//               Row(
//                 children: [
//                   _buildHeaderIcon(
//                     Icons.notifications_none_outlined,
//                     onPressed: () {},
//                     badge: '2',
//                   ),
//                   SizedBox(width: 12),
//                   _buildHeaderIcon(
//                     Icons.favorite_border_outlined,
//                     onPressed: () {},
//                   ),
//                   SizedBox(width: 12),
//                   _buildHeaderIcon(
//                     Icons.shopping_bag_outlined,
//                     onPressed: () {},
//                     badge: _cartCount.toString(),
//                     isCart: true,
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           SizedBox(height: 20),
//
//           // Search Bar
//           Container(
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(16),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.05),
//                   blurRadius: 10,
//                   offset: Offset(0, 4),
//                 ),
//               ],
//             ),
//             child: TextField(
//               controller: _searchController,
//               decoration: InputDecoration(
//                 hintText: 'Search products, brands...',
//                 hintStyle: TextStyle(
//                   color: Colors.grey[400],
//                   fontSize: 16,
//                 ),
//                 border: InputBorder.none,
//                 prefixIcon: Icon(
//                   Icons.search,
//                   color: Colors.grey[400],
//                   size: 24,
//                 ),
//                 suffixIcon: Container(
//                   margin: EdgeInsets.all(8),
//                   decoration: BoxDecoration(
//                     color: Theme
//                         .of(context)
//                         .primaryColor,
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Icon(
//                     Icons.tune,
//                     color: Colors.white,
//                     size: 20,
//                   ),
//                 ),
//                 contentPadding: EdgeInsets.symmetric(
//                   horizontal: 20,
//                   vertical: 16,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildHeaderIcon(IconData icon, {
//     required VoidCallback onPressed,
//     String? badge,
//     bool isCart = false,
//   }) {
//     return Container(
//       height: 44,
//       width: 44,
//       child: Stack(
//         children: [
//           Center(
//             child: IconButton(
//               icon: Icon(icon, size: 26),
//               onPressed: onPressed,
//               color: Theme
//                   .of(context)
//                   .primaryColor,
//             ),
//           ),
//           if (badge != null)
//             Positioned(
//               right: 6,
//               top: 6,
//               child: Container(
//                 padding: EdgeInsets.all(4),
//                 decoration: BoxDecoration(
//                   color: isCart
//                       ? Theme
//                       .of(context)
//                       .colorScheme
//                       .secondary
//                       : Theme
//                       .of(context)
//                       .primaryColor,
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 constraints: BoxConstraints(
//                   minWidth: 20,
//                   minHeight: 20,
//                 ),
//                 child: Text(
//                   badge,
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 11,
//                     fontWeight: FontWeight.w600,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildCategoryNavigation() {
//     return Container(
//       height: 100,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: categories.length,
//         padding: EdgeInsets.symmetric(horizontal: 16),
//         itemBuilder: (context, index) {
//           bool isSelected = _selectedCategoryIndex == index;
//           return GestureDetector(
//             onTap: () {
//               setState(() {
//                 _selectedCategoryIndex = index;
//               });
//             },
//             child: AnimatedContainer(
//               duration: Duration(milliseconds: 200),
//               margin: EdgeInsets.symmetric(horizontal: 8),
//               child: Column(
//                 children: [
//                   Container(
//                     width: 64,
//                     height: 64,
//                     decoration: BoxDecoration(
//                       color: isSelected
//                           ? Theme
//                           .of(context)
//                           .primaryColor
//                           : Colors.white,
//                       borderRadius: BorderRadius.circular(20),
//                       boxShadow: [
//                         BoxShadow(
//                           color: isSelected
//                               ? Theme
//                               .of(context)
//                               .primaryColor
//                               .withOpacity(0.3)
//                               : Colors.black.withOpacity(0.05),
//                           blurRadius: 12,
//                           offset: Offset(0, 4),
//                         ),
//                       ],
//                     ),
//                     child: Center(
//                       child: Text(
//                         categoryIcons[index],
//                         style: TextStyle(fontSize: 28),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 8),
//                   Text(
//                     categories[index],
//                     style: TextStyle(
//                       color: isSelected
//                           ? Theme
//                           .of(context)
//                           .primaryColor
//                           : Colors.grey[600],
//                       fontWeight: isSelected ? FontWeight.w600 : FontWeight
//                           .w400,
//                       fontSize: 13,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   Widget _buildSectionHeader() {
//     String selectedCategory = categories[_selectedCategoryIndex];
//     List<Product> filteredProducts = _selectedCategoryIndex == 0
//         ? products
//         : products.where((p) => p.category == selectedCategory).toList();
//
//     return Padding(
//       padding: EdgeInsets.fromLTRB(24, 16, 24, 16),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 selectedCategory == 'All'
//                     ? 'Popular Products'
//                     : selectedCategory,
//                 style: TextStyle(
//                   fontSize: 22,
//                   fontWeight: FontWeight.w700,
//                   color: Theme
//                       .of(context)
//                       .primaryColor,
//                 ),
//               ),
//               SizedBox(height: 4),
//               Text(
//                 '${filteredProducts.length} items available',
//                 style: TextStyle(
//                   fontSize: 14,
//                   color: Colors.grey[600],
//                 ),
//               ),
//             ],
//           ),
//           Row(
//             children: [
//               _buildSortButton(Icons.sort, 'Sort'),
//               SizedBox(width: 12),
//               _buildSortButton(Icons.grid_view, 'View'),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildSortButton(IconData icon, String label) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 8,
//             offset: Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           Icon(icon, size: 18, color: Theme
//               .of(context)
//               .primaryColor),
//           SizedBox(width: 4),
//           Text(
//             label,
//             style: TextStyle(
//               fontSize: 13,
//               fontWeight: FontWeight.w500,
//               color: Theme
//                   .of(context)
//                   .primaryColor,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildProductGrid() {
//     List<Product> filteredProducts = _selectedCategoryIndex == 0
//         ? products
//         : products.where((p) =>
//     p.category == categories[_selectedCategoryIndex]).toList();
//
//     return GridView.builder(
//       padding: EdgeInsets.symmetric(horizontal: 20),
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         childAspectRatio: 0.58, // Adjusted to give more height
//         crossAxisSpacing: 16,
//         mainAxisSpacing: 20,
//       ),
//       itemCount: filteredProducts.length,
//       itemBuilder: (context, index) {
//         return _buildProductCard(filteredProducts[index], index);
//       },
//     );
//   }
//
//   Widget _buildProductCard(Product product, int index) {
//     bool isFavorite = _favoriteProducts.contains(index);
//
//     return GestureDetector(
//       onTap: () {
//         // Navigate to product detail
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(20),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.08),
//               blurRadius: 16,
//               offset: Offset(0, 4),
//             ),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Product Image with Favorite Button
//             Stack(
//               children: [
//                 Container(
//                   height: 120, // Reduced height
//                   decoration: BoxDecoration(
//                     color: Colors.grey[100],
//                     borderRadius: BorderRadius.vertical(
//                       top: Radius.circular(20),
//                     ),
//                   ),
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.vertical(
//                       top: Radius.circular(20),
//                     ),
//                     child: Image.network(
//                       product.imageUrl,
//                       fit: BoxFit.cover,
//                       width: double.infinity,
//                       errorBuilder: (context, error, stackTrace) {
//                         return Center(
//                           child: Icon(
//                             Icons.image_not_supported,
//                             color: Colors.grey[400],
//                             size: 40,
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   top: 8,
//                   right: 8,
//                   child: GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         if (isFavorite) {
//                           _favoriteProducts.remove(index);
//                         } else {
//                           _favoriteProducts.add(index);
//                         }
//                       });
//                     },
//                     child: Container(
//                       padding: EdgeInsets.all(6), // Reduced padding
//                       decoration: BoxDecoration(
//                         color: Colors.white.withOpacity(0.9),
//                         borderRadius: BorderRadius.circular(12),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.1),
//                             blurRadius: 8,
//                           ),
//                         ],
//                       ),
//                       child: AnimatedSwitcher(
//                         duration: Duration(milliseconds: 200),
//                         child: Icon(
//                           isFavorite ? Icons.favorite : Icons.favorite_border,
//                           key: ValueKey(isFavorite),
//                           color: isFavorite
//                               ? Theme
//                               .of(context)
//                               .colorScheme
//                               .secondary
//                               : Colors.grey[600],
//                           size: 18, // Reduced size
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 // Discount Badge
//                 if (index % 3 == 0)
//                   Positioned(
//                     top: 8,
//                     left: 8,
//                     child: Container(
//                       padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                       decoration: BoxDecoration(
//                         color: Theme
//                             .of(context)
//                             .colorScheme
//                             .secondary,
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: Text(
//                         '-20%',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 11, // Reduced size
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                   ),
//               ],
//             ),
//
//             // Product Info
//             Expanded(
//               child: Padding(
//                 padding: EdgeInsets.all(10), // Reduced padding
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     // Product details
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             product.category,
//                             style: TextStyle(
//                               color: Theme
//                                   .of(context)
//                                   .primaryColor
//                                   .withOpacity(0.6),
//                               fontSize: 10, // Reduced size
//                               fontWeight: FontWeight.w600,
//                               letterSpacing: 0.5,
//                             ),
//                           ),
//                           SizedBox(height: 2), // Reduced spacing
//                           Text(
//                             product.name,
//                             style: TextStyle(
//                               fontWeight: FontWeight.w600,
//                               fontSize: 13, // Reduced size
//                               color: Colors.black87,
//                               height: 1.2,
//                             ),
//                             maxLines: 2,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                           SizedBox(height: 4), // Reduced spacing
//                           Row(
//                             children: [
//                               Icon(
//                                 Icons.star,
//                                 size: 12, // Reduced size
//                                 color: Colors.amber,
//                               ),
//                               SizedBox(width: 2),
//                               Text(
//                                 product.rating.toString(),
//                                 style: TextStyle(
//                                   fontSize: 11, // Reduced size
//                                   fontWeight: FontWeight.w500,
//                                   color: Colors.grey[700],
//                                 ),
//                               ),
//                               SizedBox(width: 2),
//                               Text(
//                                 '(${product.reviews})',
//                                 style: TextStyle(
//                                   fontSize: 10, // Reduced size
//                                   color: Colors.grey[500],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                     // Price and button
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           '\$${product.price.toStringAsFixed(2)}',
//                           style: TextStyle(
//                             color: Theme
//                                 .of(context)
//                                 .primaryColor,
//                             fontWeight: FontWeight.w700,
//                             fontSize: 16, // Reduced size
//                           ),
//                         ),
//                         SizedBox(height: 6), // Reduced spacing
//                         SizedBox(
//                           width: double.infinity,
//                           height: 30, // Reduced height
//                           child: ElevatedButton(
//                             onPressed: () {
//                               setState(() {
//                                 _cartCount++;
//                               });
//                               _showAddToCartAnimation(product);
//                             },
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Icon(Icons.add_shopping_cart, size: 14),
//                                 // Reduced size
//                                 SizedBox(width: 4),
//                                 Text(
//                                   'Add',
//                                   style: TextStyle(
//                                     fontSize: 12, // Reduced size
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Theme
//                                   .of(context)
//                                   .primaryColor,
//                               elevation: 0,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                               padding: EdgeInsets.symmetric(
//                                   horizontal: 8), // Reduced padding
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void _showAddToCartAnimation(Product product) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Row(
//           children: [
//             Icon(Icons.check_circle, color: Colors.white, size: 20),
//             SizedBox(width: 12),
//             Expanded(
//               child: Text(
//                 'Added ${product.name} to cart',
//                 style: TextStyle(fontWeight: FontWeight.w500),
//               ),
//             ),
//             TextButton(
//               onPressed: () {
//                 ScaffoldMessenger.of(context).hideCurrentSnackBar();
//               },
//               child: Text(
//                 'VIEW CART',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ),
//           ],
//         ),
//         backgroundColor: Colors.green[600],
//         behavior: SnackBarBehavior.floating,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10),
//         ),
//         margin: EdgeInsets.all(16),
//         duration: Duration(seconds: 2),
//       ),
//     );
//   }
//
//
// }