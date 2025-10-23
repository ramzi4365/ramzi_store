import 'package:flutter/material.dart';
import 'package:path/path.dart';







class HeaderAppBarItems extends StatelessWidget {

  final VoidCallback onPressedNotification;
  final VoidCallback onPressedCart;

  final VoidCallback onPressedFavorite;

  const HeaderAppBarItems({super.key, required this.onPressedNotification,  required this.onPressedFavorite, required this.onPressedCart});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Logo and Welcome
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ShopEasy',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: Theme
                          .of(context)
                          .primaryColor,
                      letterSpacing: -0.5,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Discover amazing products',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),

              // Action Icons
              Row(
                children: [
                  buildHeaderIcon(
                    icon:Icons.notifications_none_outlined,
                    onPressed: () {
                      onPressedNotification;
                    },
                    badge: '2',
                  ),
                  SizedBox(width: 12),
                  buildHeaderIcon(
                    icon:Icons.favorite_border_outlined,
                    onPressed: () {
                      onPressedFavorite;
                    },
                  ),
                  SizedBox(width: 12),
                  buildHeaderIcon(
                    icon: Icons.shopping_cart,
                    onPressed: onPressedCart,
                    //badge: _cartCount.toString(),
                    isCart: true,
                  ),
                ],
              ),
            ],
          ),


          // Search Bar

        ],
      ),
    );
  }
}



//
// Widget _buildHeaderIcon(IconData icon, {
//   required VoidCallback onPressed,
//   String? badge,
//   bool isCart = false,
// }) {

  class buildHeaderIcon extends StatelessWidget {
    final IconData icon;
    final VoidCallback onPressed;
    final String? badge;
    final bool isCart;




  const buildHeaderIcon({super.key,
    required this.icon,
    required this.onPressed,
    this.badge,
    this.isCart = false});
  @override
  Widget build(BuildContext context) {
  return Container(
    height: 44,
    width: 44,
    child: Stack(
      children: [
        Center(
          child: IconButton(
            icon: Icon(icon, size: 26),
            onPressed: onPressed,
            color: Theme
                .of(context as BuildContext)
                .primaryColor,
          ),
        ),
        if (badge != null)
          Positioned(
            right: 6,
            top: 6,
            child: Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: isCart
                    ? Theme
                    .of(context )
                    .colorScheme
                    .secondary
                    : Theme
                    .of(context)
                    .primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              constraints: BoxConstraints(
                minWidth: 20,
                minHeight: 20,
              ),
              child: Text(
                badge!,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    ),
  );
}
}
