// import 'package:flutter/material.dart';
// import 'package:badges/badges.dart' as badges;
// import 'package:flutter/services.dart';
//
// void main() {
//   runApp(const ShoppingApp());
// }
//
// class ShoppingApp extends StatelessWidget {
//   const ShoppingApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Shopping App',
//       theme: ThemeData(
//         fontFamily: "Cairo",
//         primaryColor: const Color(0xFF2C3E50),
//         colorScheme: const ColorScheme.light(
//           primary: Color(0xFF2C3E50),
//           secondary: Color(0xFFE74C3C),
//           surface: Color(0xFFF8F9FA),
//         ),
//         appBarTheme: const AppBarTheme(
//           elevation: 0,
//           backgroundColor: Colors.transparent,
//           systemOverlayStyle: SystemUiOverlayStyle.dark,
//         ),
//       ),
//       home: const HomePage(),
//     );
//   }
// }
//
// class HomePage extends StatefulWidget {
//   const HomePage({super.key});
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
//   final TextEditingController _searchController = TextEditingController();
//   final PageController _carouselController = PageController();
//   int _currentCarouselIndex = 0;
//   int _cartItemCount = 3; // Example cart item count
//
//   // Mock data for the app
//   final List<String> _promoImages = [
//     'https://via.placeholder.com/400x200?text=Promo+1',
//     'https://via.placeholder.com/400x200?text=Promo+2',
//     'https://via.placeholder.com/400x200?text=Promo+3',
//     'https://via.placeholder.com/400x200?text=Promo+4',
//   ];
//
//   final List<Map<String, dynamic>> _categories = [
//     {'icon': Icons.phone_android, 'name': 'Electronics'},
//     {'icon': Icons.directions_car, 'name': 'Automotive'},
//     {'icon': Icons.home, 'name': 'Home'},
//     {'icon': Icons.watch, 'name': 'Accessories'},
//     {'icon': Icons.sports_esports, 'name': 'Gaming'},
//     {'icon': Icons.local_drink, 'name': 'Beverages'},
//     {'icon': Icons.child_care, 'name': 'Kids'},
//     {'icon': Icons.more_horiz, 'name': 'More'},
//   ];
//
//   final List<Map<String, dynamic>> _topSellingProducts = [
//     {'name': 'Wireless Headphones', 'price': '\$79.99', 'image': 'https://via.placeholder.com/150?text=Headphones'},
//     {'name': 'Smart Watch', 'price': '\$129.99', 'image': 'https://via.placeholder.com/150?text=Watch'},
//     {'name': 'Running Shoes', 'price': '\$59.99', 'image': 'https://via.placeholder.com/150?text=Shoes'},
//     {'name': 'Backpack', 'price': '\$49.99', 'image': 'https://via.placeholder.com/150?text=Backpack'},
//     {'name': 'Water Bottle', 'price': '\$19.99', 'image': 'https://via.placeholder.com/150?text=Bottle'},
//   ];
//
//   final List<Map<String, dynamic>> _newProducts = [
//     {'name': 'Wireless Charger', 'price': '\$29.99', 'image': 'https://via.placeholder.com/150?text=Charger'},
//     {'name': 'Bluetooth Speaker', 'price': '\$45.99', 'image': 'https://via.placeholder.com/150?text=Speaker'},
//     {'name': 'Fitness Tracker', 'price': '\$89.99', 'image': 'https://via.placeholder.com/150?text=Tracker'},
//     {'name': 'Desk Lamp', 'price': '\$35.99', 'image': 'https://via.placeholder.com/150?text=Lamp'},
//     {'name': 'Phone Case', 'price': '\$15.99', 'image': 'https://via.placeholder.com/150?text=Case'},
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//     // Auto-scroll the carousel
//     _startCarouselAutoScroll();
//   }
//
//   void _startCarouselAutoScroll() {
//     Future.delayed(const Duration(seconds: 3), () {
//       if (_carouselController.hasClients) {
//         int nextPage = _currentCarouselIndex + 1;
//         if (nextPage >= _promoImages.length) nextPage = 0;
//
//         _carouselController.animateToPage(
//           nextPage,
//           duration: const Duration(milliseconds: 500),
//           curve: Curves.easeInOut,
//         );
//         _startCarouselAutoScroll();
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     _searchController.dispose();
//     _carouselController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Theme.of(context).colorScheme.surface,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Search Bar with notification and cart
//               _buildSearchBar(context),
//               const SizedBox(height: 16),
//
//               // Promotional Carousel
//               _buildPromoCarousel(),
//               const SizedBox(height: 24),
//
//               // Category Icons
//               _buildCategorySection(),
//               const SizedBox(height: 24),
//
//               // Top Selling Section
//               _buildProductSection(
//                   title: "Top Selling",
//                   products: _topSellingProducts
//               ),
//               const SizedBox(height: 24),
//
//               // New Arrivals Section
//               _buildProductSection(
//                   title: "New Arrivals",
//                   products: _newProducts
//               ),
//               const SizedBox(height: 24),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildSearchBar(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//       child: Row(
//         children: [
//           Expanded(
//             child: Container(
//               height: 50,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(12),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.withOpacity(0.2),
//                     spreadRadius: 1,
//                     blurRadius: 4,
//                     offset: const Offset(0, 2),
//                   ),
//                 ],
//               ),
//               child: TextField(
//                 controller: _searchController,
//                 decoration: InputDecoration(
//                   hintText: "Search products...",
//                   hintStyle: TextStyle(
//                     color: Colors.grey.shade500,
//                     fontFamily: 'Cairo',
//                   ),
//                   border: InputBorder.none,
//                   prefixIcon: Icon(Icons.search, color: Theme.of(context).primaryColor),
//                   contentPadding: const EdgeInsets.symmetric(vertical: 15),
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(width: 12),
//           // Notification Icon
//           Container(
//             width: 50,
//             height: 50,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(12),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.2),
//                   spreadRadius: 1,
//                   blurRadius: 4,
//                   offset: const Offset(0, 2),
//                 ),
//               ],
//             ),
//             child: IconButton(
//               icon: Icon(Icons.notifications_none, color: Theme.of(context).primaryColor),
//               onPressed: () {},
//             ),
//           ),
//           const SizedBox(width: 12),
//           // Cart Icon with Badge
//           Container(
//             width: 50,
//             height: 50,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(12),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.2),
//                   spreadRadius: 1,
//                   blurRadius: 4,
//                   offset: const Offset(0, 2),
//                 ),
//               ],
//             ),
//             child: badges.Badge(
//               position: badges.BadgePosition.topEnd(top: -5, end: -5),
//               badgeContent: Text(
//                 _cartItemCount.toString(),
//                 style: const TextStyle(color: Colors.white, fontSize: 10),
//               ),
//               badgeStyle: const badges.BadgeStyle(
//                 badgeColor: Color(0xFFE74C3C),
//               ),
//               child: IconButton(
//                 icon: Icon(Icons.shopping_cart_outlined, color: Theme.of(context).primaryColor),
//                 onPressed: () {},
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildPromoCarousel() {
//     return Column(
//       children: [
//         SizedBox(
//           height: 180,
//           child: PageView.builder(
//             controller: _carouselController,
//             itemCount: _promoImages.length,
//             onPageChanged: (index) {
//               setState(() {
//                 _currentCarouselIndex = index;
//               });
//             },
//             itemBuilder: (context, index) {
//               return Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(16),
//                   child: Image.network(
//                     _promoImages[index],
//                     fit: BoxFit.cover,
//                     width: double.infinity,
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//         const SizedBox(height: 12),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: _promoImages.asMap().entries.map((entry) {
//             return Container(
//               width: 8.0,
//               height: 8.0,
//               margin: const EdgeInsets.symmetric(horizontal: 4.0),
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: Theme.of(context).primaryColor.withOpacity(
//                     _currentCarouselIndex == entry.key ? 0.9 : 0.4
//                 ),
//               ),
//             );
//           }).toList(),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildCategorySection() {
//     return SizedBox(
//       height: 100,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: _categories.length,
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         itemBuilder: (context, index) {
//           return Container(
//             width: 80,
//             margin: const EdgeInsets.only(right: 16),
//             child: Column(
//               children: [
//                 Container(
//                   width: 60,
//                   height: 60,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(12),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey.withOpacity(0.2),
//                         spreadRadius: 1,
//                         blurRadius: 4,
//                         offset: const Offset(0, 2),
//                       ),
//                     ],
//                   ),
//                   child: Icon(
//                     _categories[index]['icon'],
//                     color: Theme.of(context).primaryColor,
//                     size: 30,
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   _categories[index]['name'],
//                   style: TextStyle(
//                     fontFamily: 'Cairo',
//                     fontSize: 12,
//                     color: Theme.of(context).primaryColor,
//                   ),
//                   textAlign: TextAlign.center,
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   Widget _buildProductSection({required String title, required List<Map<String, dynamic>> products}) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0),
//           child: Text(
//             title,
//             style: TextStyle(
//               fontFamily: 'Cairo',
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//               color: Theme.of(context).primaryColor,
//             ),
//           ),
//         ),
//         const SizedBox(height: 16),
//         SizedBox(
//           height: 220,
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: products.length,
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             itemBuilder: (context, index) {
//               return Container(
//                 width: 150,
//                 margin: const EdgeInsets.only(right: 16),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(16),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.withOpacity(0.2),
//                       spreadRadius: 1,
//                       blurRadius: 4,
//                       offset: const Offset(0, 2),
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     ClipRRect(
//                       borderRadius: const BorderRadius.only(
//                         topLeft: Radius.circular(16),
//                         topRight: Radius.circular(16),
//                       ),
//                       child: Image.network(
//                         products[index]['image'],
//                         height: 120,
//                         width: double.infinity,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             products[index]['name'],
//                             style: TextStyle(
//                               fontFamily: 'Cairo',
//                               fontSize: 14,
//                               fontWeight: FontWeight.w600,
//                               color: Theme.of(context).primaryColor,
//                             ),
//                             maxLines: 1,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                           const SizedBox(height: 4),
//                           Text(
//                             products[index]['price'],
//                             style: TextStyle(
//                               fontFamily: 'Cairo',
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                               color: Theme.of(context).colorScheme.secondary,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }
//
//
//
//
//
//
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
//
//
//
//
//
//
// import 'package:flutter/material.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_instance/src/extension_instance.dart';
// import 'package:get/get_navigation/src/root/get_material_app.dart';
// import 'package:ramzi_store/binding.dart';
// import 'package:ramzi_store/binding/initialBinding.dart';
// import 'package:ramzi_store/core/constant/color.dart';
// import 'package:ramzi_store/core/constant/routes.dart';
// import 'package:ramzi_store/core/localization/chageLocal.dart';
// import 'package:ramzi_store/core/localization/translation.dart';
// import 'package:ramzi_store/core/services/services.dart';
// import 'package:ramzi_store/routes.dart';
// import 'package:ramzi_store/test.dart';
// import 'package:ramzi_store/view/screen/onBoarding.dart';
//
// import 'view/screen/language.dart';
//
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await initialServices();
//   runApp(const MyApp());
// }
//
//
//
//
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     LocaleController controller = Get.put(LocaleController());
//     return GetMaterialApp(
//       translations: MyTranslation(),
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Demo',
//       locale: controller.language,
//       theme: controller.appTheme,
//       initialBinding: InitialBinding(),
//
//
//       //routes: routes,
//       getPages: routes,
//     );
//   }
// }
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
//
//
//
//
//
