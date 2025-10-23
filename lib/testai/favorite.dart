// //
// //
// //
// //
// // import 'package:flutter/material.dart';
// // import 'package:get/get_core/src/get_main.dart';
// // import 'package:get/get_instance/src/extension_instance.dart';
// // import 'package:get/get_navigation/src/root/get_material_app.dart';
// // import 'package:ramzi_store/binding.dart';
// // import 'package:ramzi_store/binding/initialBinding.dart';
// // import 'package:ramzi_store/core/constant/color.dart';
// // import 'package:ramzi_store/core/constant/routes.dart';
// // import 'package:ramzi_store/core/localization/chageLocal.dart';
// // import 'package:ramzi_store/core/localization/translation.dart';
// // import 'package:ramzi_store/core/services/services.dart';
// // import 'package:ramzi_store/routes.dart';
// // import 'package:ramzi_store/test.dart';
// // import 'package:ramzi_store/view/screen/onBoarding.dart';
// //
// // import 'view/screen/language.dart';
// //
// //
// // void main() async {
// //   WidgetsFlutterBinding.ensureInitialized();
// //   await initialServices();
// //   runApp(const MyApp());
// // }
// //
// //
// //
// //
// //
// // class MyApp extends StatelessWidget {
// //   const MyApp({Key? key}) : super(key: key);
// //
// //
// //   // This widget is the root of your application.
// //   @override
// //   Widget build(BuildContext context) {
// //     LocaleController controller = Get.put(LocaleController());
// //     return GetMaterialApp(
// //       translations: MyTranslation(),
// //       debugShowCheckedModeBanner: false,
// //       title: 'Flutter Demo',
// //       locale: controller.language,
// //       theme: controller.appTheme,
// //       initialBinding: InitialBinding(),
// //
// //
// //       //routes: routes,
// //       getPages: routes,
// //     );
// //   }
// // }
// //
// //
// //
// //
// //
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// // Favorite Item Model
// class FavoriteItem {
//   final String id;
//   final String name;
//   final String image;
//   final double price;
//   final double? oldPrice;
//   final double rating;
//   final int reviews;
//   final bool inStock;
//
//   FavoriteItem({
//     required this.id,
//     required this.name,
//     required this.image,
//     required this.price,
//     this.oldPrice,
//     required this.rating,
//     required this.reviews,
//     this.inStock = true,
//   });
//
//   int get discountPercentage {
//     if (oldPrice != null && oldPrice! > price) {
//       return (((oldPrice! - price) / oldPrice!) * 100).round();
//     }
//     return 0;
//   }
// }
//
// // Favorites Page
// class FavoritesPage extends StatefulWidget {
//   const FavoritesPage({super.key});
//
//   @override
//   State<FavoritesPage> createState() => _FavoritesPageState();
// }
//
// class _FavoritesPageState extends State<FavoritesPage> {
//   // Mock favorite items
//   List<FavoriteItem> favoriteItems = [
//     FavoriteItem(
//       id: '1',
//       name: 'Wireless Headphones Pro',
//       image: 'https://via.placeholder.com/200x200/2C3E50/FFFFFF?text=Headphones',
//       price: 79.99,
//       oldPrice: 99.99,
//       rating: 4.8,
//       reviews: 234,
//     ),
//     FavoriteItem(
//       id: '2',
//       name: 'Smart Watch Ultra',
//       image: 'https://via.placeholder.com/200x200/E74C3C/FFFFFF?text=Watch',
//       price: 299.99,
//       rating: 4.9,
//       reviews: 567,
//     ),
//     FavoriteItem(
//       id: '3',
//       name: 'Designer Leather Jacket',
//       image: 'https://via.placeholder.com/200x200/34495E/FFFFFF?text=Jacket',
//       price: 199.99,
//       oldPrice: 299.99,
//       rating: 4.7,
//       reviews: 123,
//     ),
//     FavoriteItem(
//       id: '4',
//       name: 'Premium Sneakers',
//       image: 'https://via.placeholder.com/200x200/3498DB/FFFFFF?text=Shoes',
//       price: 129.99,
//       rating: 4.6,
//       reviews: 89,
//       inStock: false,
//     ),
//     FavoriteItem(
//       id: '5',
//       name: 'Smart LED Lamp',
//       image: 'https://via.placeholder.com/200x200/F39C12/FFFFFF?text=Lamp',
//       price: 49.99,
//       oldPrice: 69.99,
//       rating: 4.5,
//       reviews: 45,
//     ),
//     FavoriteItem(
//       id: '6',
//       name: 'Bluetooth Speaker',
//       image: 'https://via.placeholder.com/200x200/1ABC9C/FFFFFF?text=Speaker',
//       price: 59.99,
//       rating: 4.4,
//       reviews: 78,
//     ),
//   ];
//
//   void removeFromFavorites(FavoriteItem item) {
//     final index = favoriteItems.indexOf(item);
//     setState(() {
//       favoriteItems.remove(item);
//     });
//
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text('${item.name} removed from favorites'),
//         backgroundColor: Colors.red,
//         action: SnackBarAction(
//           label: 'UNDO',
//           onPressed: () {
//             setState(() {
//               favoriteItems.insert(index, item);
//             });
//           },
//         ),
//         behavior: SnackBarBehavior.floating,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10),
//         ),
//       ),
//     );
//   }
//
//   void moveToCart(FavoriteItem item) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text('${item.name} added to cart'),
//         backgroundColor: Colors.green,
//         behavior: SnackBarBehavior.floating,
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//
//     return Scaffold(
//       backgroundColor: Colors.grey[50],
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0.5,
//         title: Column(
//           children: [
//             Text(
//               'My Favorites',
//               style: TextStyle(
//                 color: theme.primaryColor,
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             Text(
//               '${favoriteItems.length} items',
//               style: TextStyle(
//                 color: Colors.grey[600],
//                 fontSize: 12,
//                 fontWeight: FontWeight.normal,
//               ),
//             ),
//           ],
//         ),
//         centerTitle: true,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back_ios, color: theme.primaryColor, size: 20),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       body: favoriteItems.isEmpty
//           ? _buildEmptyFavorites(theme)
//           : _buildFavoritesList(theme),
//     );
//   }
//
//   Widget _buildEmptyFavorites(ThemeData theme) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Container(
//             width: 100,
//             height: 100,
//             decoration: BoxDecoration(
//               color: Colors.red[50],
//               shape: BoxShape.circle,
//             ),
//             child: Icon(
//               Icons.favorite_outline,
//               size: 50,
//               color: Colors.red[300],
//             ),
//           ),
//           const SizedBox(height: 20),
//           Text(
//             'No favorites yet',
//             style: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//               color: Colors.grey[800],
//             ),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             'Start adding items you love',
//             style: TextStyle(
//               fontSize: 14,
//               color: Colors.grey[600],
//             ),
//           ),
//           const SizedBox(height: 24),
//           ElevatedButton(
//             onPressed: () => Navigator.pop(context),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: theme.primaryColor,
//               padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(8),
//               ),
//             ),
//             child: const Text(
//               'Explore Products',
//               style: TextStyle(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.white,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildFavoritesList(ThemeData theme) {
//     return ListView.builder(
//       padding: const EdgeInsets.all(16),
//       itemCount: favoriteItems.length,
//       itemBuilder: (context, index) {
//         return Padding(
//           padding: const EdgeInsets.only(bottom: 12),
//           child: _buildFavoriteItem(favoriteItems[index], theme),
//         );
//       },
//     );
//   }
//
//   Widget _buildFavoriteItem(FavoriteItem item, ThemeData theme) {
//     return Dismissible(
//       key: Key(item.id),
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
//       onDismissed: (direction) => removeFromFavorites(item),
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
//                 child: Image.network(
//                   item.image,
//                   fit: BoxFit.cover,
//                   errorBuilder: (context, error, stackTrace) {
//                     return Icon(Icons.image, color: Colors.grey[400]);
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
//                     item.name,
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
//                       _buildRatingTag(item.rating),
//                       const SizedBox(width: 6),
//                       _buildReviewTag(item.reviews),
//                       if (!item.inStock) ...[
//                         const SizedBox(width: 6),
//                         _buildOutOfStockTag(),
//                       ],
//                     ],
//                   ),
//                   const SizedBox(height: 8),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           if (item.oldPrice != null)
//                             Text(
//                               '\$${item.oldPrice!.toStringAsFixed(2)}',
//                               style: TextStyle(
//                                 fontSize: 12,
//                                 color: Colors.grey[500],
//                                 decoration: TextDecoration.lineThrough,
//                               ),
//                             ),
//                           Text(
//                             '\$${item.price.toStringAsFixed(2)}',
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                               color: theme.primaryColor,
//                             ),
//                           ),
//                         ],
//                       ),
//                       _buildActionButtons(item, theme),
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
//   Widget _buildRatingTag(double rating) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
//       decoration: BoxDecoration(
//         color: Colors.amber[50],
//         borderRadius: BorderRadius.circular(4),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(Icons.star, size: 12, color: Colors.amber[700]),
//           const SizedBox(width: 2),
//           Text(
//             rating.toString(),
//             style: TextStyle(
//               color: Colors.amber[800],
//               fontSize: 10,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildReviewTag(int reviews) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
//       decoration: BoxDecoration(
//         color: Colors.grey[100],
//         borderRadius: BorderRadius.circular(4),
//       ),
//       child: Text(
//         '($reviews)',
//         style: TextStyle(
//           color: Colors.grey[700],
//           fontSize: 10,
//           fontWeight: FontWeight.w500,
//         ),
//       ),
//     );
//   }
//
//   Widget _buildOutOfStockTag() {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
//       decoration: BoxDecoration(
//         color: Colors.red[50],
//         borderRadius: BorderRadius.circular(4),
//       ),
//       child: Text(
//         'Out of Stock',
//         style: TextStyle(
//           color: Colors.red[600],
//           fontSize: 10,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//     );
//   }
//
//   Widget _buildActionButtons(FavoriteItem item, ThemeData theme) {
//     return Row(
//       children: [
//         // Remove from favorites button
//         InkWell(
//           onTap: () => removeFromFavorites(item),
//           borderRadius: BorderRadius.circular(6),
//           child: Container(
//             padding: const EdgeInsets.all(8),
//             decoration: BoxDecoration(
//               color: Colors.grey[100],
//               borderRadius: BorderRadius.circular(6),
//             ),
//             child: Icon(
//               Icons.favorite,
//               size: 18,
//               color: Colors.red[400],
//             ),
//           ),
//         ),
//         const SizedBox(width: 8),
//
//         // Add to cart button
//         InkWell(
//           onTap: item.inStock ? () => moveToCart(item) : null,
//           borderRadius: BorderRadius.circular(6),
//           child: Container(
//             padding: const EdgeInsets.all(8),
//             decoration: BoxDecoration(
//               color: item.inStock ? theme.primaryColor : Colors.grey[300],
//               borderRadius: BorderRadius.circular(6),
//             ),
//             child: Icon(
//               Icons.shopping_cart_outlined,
//               size: 18,
//               color: Colors.white,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// // Example usage
// void main() {
//   runApp(MaterialApp(
//     theme: ThemeData(
//       primaryColor: const Color(0xFF2C3E50),
//       colorScheme: const ColorScheme.light(
//         primary: Color(0xFF2C3E50),
//         secondary: Color(0xFFE74C3C),
//       ),
//     ),
//     home: const FavoritesPage(),
//   ));
// }