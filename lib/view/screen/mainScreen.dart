// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:ramzi_store/core/constant/color.dart';
// import 'package:badges/badges.dart' as badges;
//
// import '../../controller/mainScreenController.dart';
//
// class MainScreen extends StatelessWidget {
//   MainScreen({super.key});
//
//   final MainScreenController controller = Get.put(MainScreenController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GetBuilder<MainScreenController>(
//         builder: (controller) => controller.pages[controller.currentIndex],
//       ),
//       bottomNavigationBar: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.1),
//               blurRadius: 20,
//               offset: const Offset(0, -5),
//             ),
//           ],
//         ),
//         child: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 _buildNavItem(context, Icons.home, Icons.home_outlined, 'Home', 0),
//                 _buildNavItem(context, Icons.shopping_cart, Icons.shopping_cart_outlined, 'Cart', 1),
//                 _buildNavItem(context, Icons.favorite, Icons.favorite_outline, 'Favorites', 2),
//                 _buildNavItem(context, Icons.person, Icons.person_outline, 'Profile', 3),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildNavItem(BuildContext context, IconData activeIcon, IconData inactiveIcon, String label, int index) {
//     return GetBuilder<MainScreenController>(
//       builder: (controller) {
//         final isActive = controller.currentIndex == index;
//         final color = isActive ? Theme.of(context).primaryColor : Colors.grey;
//         final badge = index == 1 ? controller.cartItemCount : null;
//
//         return InkWell(
//           onTap: () => controller.changePage(index),
//           borderRadius: BorderRadius.circular(12),
//           child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(12),
//               color: isActive ? Theme.of(context).primaryColor.withAlpha((255 * 0.1).round()) : Colors.transparent,
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 badge != null
//                     ? badges.Badge(
//                   badgeContent: Text(
//                     badge.toString(),
//                     style: const TextStyle(color: Colors.white, fontSize: 10),
//                   ),
//                   badgeStyle: badges.BadgeStyle(
//                     badgeColor: Theme.of(context).colorScheme.secondary,
//                   ),
//                   child: Icon(
//                     isActive ? activeIcon : inactiveIcon,
//                     color: color,
//                     size: 24,
//                   ),
//                 )
//                     : Icon(
//                   isActive ? activeIcon : inactiveIcon,
//                   color: color,
//                   size: 24,
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   label,
//                   style: TextStyle(
//                     color: color,
//                     fontSize: 12,
//                     fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
//
//
//
// class FavoritesPage extends StatelessWidget {
//   const FavoritesPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('My Favorites'),
//         centerTitle: true,
//       ),
//       body: const Center(
//         child: Text('Favorites Page'),
//       ),
//     );
//   }
// }
//
//
//
//
// class ProfilePage extends StatelessWidget {
//   const ProfilePage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('My Profile'),
//         centerTitle: true,
//       ),
//       body: const Center(
//         child: Text('Profile Page'),
//       ),
//     );
//   }
// }
//





import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ramzi_store/core/constant/color.dart';
import 'package:badges/badges.dart' as badges;
import 'package:ramzi_store/view/screen/profileDrawer.dart';

import '../../controller/mainScreenController.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final MainScreenController controller = Get.put(MainScreenController());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const ProfileDrawer(),
      body: GetBuilder<MainScreenController>(
        builder: (controller) => controller.pages[controller.currentIndex],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(context, Icons.home, Icons.home_outlined, 'Home', 0),
                _buildNavItem(context, Icons.shopping_cart, Icons.shopping_cart_outlined, 'Cart', 1),
                _buildNavItem(context, Icons.favorite, Icons.favorite_outline, 'Favorites', 2),
                _buildNavItem(context, Icons.person, Icons.person_outline, 'Profile', 3, isProfile: true),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, IconData activeIcon, IconData inactiveIcon, String label, int index, {bool isProfile = false}) {
    return GetBuilder<MainScreenController>(
      builder: (controller) {
        final isActive = controller.currentIndex == index;
        final color = isActive ? Theme.of(context).primaryColor : Colors.grey;
        final badge = index == 1 ? controller.cartItemCount : null;

        return InkWell(
          onTap: isProfile
              ? () => _scaffoldKey.currentState?.openDrawer()
              : () => controller.changePage(index),
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: isActive ? Theme.of(context).primaryColor.withAlpha((255 * 0.1).round()) : Colors.transparent,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                badge != null
                    ? badges.Badge(
                  badgeContent: Text(
                    badge.toString(),
                    style: const TextStyle(color: Colors.white, fontSize: 10),
                  ),
                  badgeStyle: badges.BadgeStyle(
                    badgeColor: Theme.of(context).colorScheme.secondary,
                  ),
                  child: Icon(
                    isActive ? activeIcon : inactiveIcon,
                    color: color,
                    size: 24,
                  ),
                )
                    : Icon(
                  isActive ? activeIcon : inactiveIcon,
                  color: color,
                  size: 24,
                ),
                const SizedBox(height: 4),
                Text(
                  label,
                  style: TextStyle(
                    color: color,
                    fontSize: 12,
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// Profile Drawer Widget
// Profile Drawer Widget with Improved Design


// Updated FavoritesPage (simplified for example)
class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Favorites'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('Favorites Page'),
      ),
    );
  }
}