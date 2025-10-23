import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ramzi_store/controller/cartController.dart';
import 'package:ramzi_store/data/model/cartModel.dart';

class QuantitySelectorWidget extends StatelessWidget {
  final MyCartModel itemCart;
  final bool isPending;
  final int currentCount;
  final VoidCallback? removeOnPressed;
  final VoidCallback? addOnPressed;



  const QuantitySelectorWidget({
    super.key,
    required this.itemCart,
    required this.isPending,
    required this.currentCount,
    required this.removeOnPressed,
    required this.addOnPressed,

  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
      builder: (controller) {

        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                isPending ? Colors.grey[100]! : Theme.of(context).primaryColor.withOpacity(0.05),
                isPending ? Colors.grey[50]! : Theme.of(context).primaryColor.withOpacity(0.1),
              ],
            ),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isPending
                  ? Colors.grey[300]!
                  : Theme.of(context).primaryColor.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              // Remove Button
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: isPending || currentCount <= 0
                      ? null
                      :removeOnPressed,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: isPending
                        ? SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.grey[400]!,
                        ),
                      ),
                    )
                        : Icon(
                      Icons.remove,
                      size: 18,
                      color: currentCount > 1
                          ? Theme.of(context).primaryColor
                          : Colors.grey[400],
                    ),
                  ),
                ),
              ),

              // Count Display
              Container(
                constraints: const BoxConstraints(minWidth: 40),
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  border: Border.symmetric(
                    vertical: BorderSide(
                      color: isPending
                          ? Colors.grey[300]!
                          : Theme.of(context).primaryColor.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                ),
                child: Text(
                  isPending ? "..." : "$currentCount",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: isPending
                        ? Colors.grey[500]
                        : Theme.of(context).primaryColor,
                  ),
                ),
              ),

              // Add Button
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: isPending ? null : addOnPressed,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: isPending
                        ? SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.grey[400]!,
                        ),
                      ),
                    )
                        : Icon(
                      Icons.add,
                      size: 18,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}