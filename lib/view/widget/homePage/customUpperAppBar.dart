
import 'package:flutter/material.dart';

class CustumUpperAppBar extends StatelessWidget {
  final String titleAppBar;
  final void Function()? onPressedNotification;
  final void Function()? onPressedSearch;
  final void Function()? onPressedFavorite;

  const CustumUpperAppBar({super.key, required this.titleAppBar, required this.onPressedSearch,required this.onPressedNotification,  required this.onPressedFavorite});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: const EdgeInsets.only(top: 24),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              decoration: InputDecoration(
                prefixIcon: IconButton(onPressed: onPressedSearch, icon: const Icon(Icons.search),),
                hintText: titleAppBar,
                hintStyle: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(20),
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
          ),
          const SizedBox(width: 7),
          Container(
            padding: const EdgeInsets.only(bottom: 25),
            child: IconButton(
              onPressed: onPressedNotification,
              icon: Icon(
                Icons.notifications_active_outlined,
                size: 30,
                color: Colors.grey[600],
              ),
            ),
          ),

          Container(
            padding: const EdgeInsets.only(bottom: 25),
            child: IconButton(
              onPressed: onPressedFavorite,
              icon: Icon(
                Icons.favorite_border_outlined,
                size: 30,
                color: Colors.grey[600],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
