import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ramzi_store/view/widget/cart/new/orderSummaryWidget.dart';

import '../../controller/cartController.dart';
import '../../core/class/handlingDataView.dart';

import '../../core/class/statusRequest.dart';
import '../widget/cart/new/attributeChipWidget.dart';
import '../widget/cart/new/checkoutButtonWidget.dart';
import '../widget/cart/new/checkoutCart.dart';
import '../widget/cart/new/customCardItemsCart.dart';
import '../widget/cart/new/emptyCartWidget.dart';
import '../widget/cart/new/promoCodeSectionWidget.dart';
import '../widget/cart/new/quantitySelectorWidget.dart';

class CartDetails extends GetView<CartController> {
  const CartDetails({super.key});

  @override
  Widget build(BuildContext context) {
    // Assuming you have followed the previous advice to fetch data here
    controller.viewItemCart();

    final bool fromBottomBar = Get.arguments?['fromBottomBar'] ?? true;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: GetBuilder<CartController>(
        builder: (controller) {
          return CustomScrollView(
            slivers: [
              // Custom App Bar - Always visible
              SliverAppBar(
                expandedHeight: 120,
                floating: false,
                pinned: true,
                backgroundColor: Colors.white,
                elevation: 0,
                leading: fromBottomBar
                    ? null
                    : Container(
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_new,
                      color: Theme.of(context).primaryColor,
                      size: 20,
                    ),
                    onPressed: () => Get.back(),
                  ),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Theme.of(context).primaryColor.withOpacity(0.05),
                          Colors.white,
                        ],
                      ),
                    ),
                    child: SafeArea(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 40),
                            Text(
                              'Shopping Cart',
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.shopping_bag_outlined,
                                    size: 16,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    '${controller.cartProduct.length} items',
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // ✅ Content Area - Call the new function here
              _buildContentSliver(controller),

              // Add some space before checkout section
              const SliverToBoxAdapter(
                child: SizedBox(height: 100),
              ),
            ],
          );
        },
      ),
      bottomSheet: GetBuilder<CartController>(
        builder: (controller) {
          if (controller.cartProduct.isEmpty) {
            return const SizedBox.shrink();
          }
          return CheckoutSectionCart(
            total: controller.calculateTotal(),
            buildPromoCodeSection: PromoCodeSectionWidget(
              controller: controller.promoController!,
              applyPromoCodeOnPressed: controller.applyPromoCode,
              couponName: controller.couponName,
            ),
            buildOrderSummary: OrderSummaryWidget(
              subtotal: controller.subTotalPrice,
              total: controller.calculateTotal(),
              discount: controller.calculateDiscount(),
              promoCode: controller.promoCode!,
              discountPercentage: controller.couponDiscount!,
            ),
            buildCheckoutButton: CheckoutButtonWidget(
              onPressed: controller.goToCheckout,
              isCartEmpty: controller.cartProduct.isEmpty,
            ),
          );
        },
      ),
    );
  }

  // ✅ HERE IS THE EXTRACTED FUNCTION
  Widget _buildContentSliver(CartController controller) {
    // Conditional rendering based on state
    if (controller.statusRequest == StatusRequest.loading) {
      return const SliverFillRemaining(
        child: Center(child: CircularProgressIndicator()),
      );
    }
    else if (controller.statusRequest == StatusRequest.serverfailure ||
        controller.statusRequest == StatusRequest.serverException) {
      return const SliverFillRemaining(
        child: Center(child: Text('Server Error')),
      );
    }
    else if (controller.statusRequest == StatusRequest.offlinefailure) {
      return const SliverFillRemaining(
        child: Center(child: Text('No Internet Connection')),
      );
    }
    else if (controller.cartProduct.isEmpty) {
      // Empty state
      return SliverFillRemaining(
        child: EmptyCartWidget(),
      );
    }
    else {
      // Cart items list
      return SliverPadding(
        padding: const EdgeInsets.all(20),
        sliver: SliverList(
          delegate: SliverChildBuilderDelegate(
                (context, index) {
              final itemCart = controller.cartProduct[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: CartListItemWidget(
                  itemCart: itemCart,
                  removeItemOnDismissed: (direction) =>
                      controller.removeItem(itemCart),
                  goToProductDetailOntap: () =>
                      controller.goToProductDetailsFromCart(itemCart),
                  buildQuantitySelector: QuantitySelectorWidget(
                    itemCart: itemCart,
                    isPending:
                    controller.pendingOperations[itemCart.itemsId.toString()] ==
                        true,
                    currentCount:
                    controller.optimisticCounts[itemCart.itemsId.toString()] ??
                        itemCart.countItems!,
                    removeOnPressed: () =>
                        controller.remove(itemCart.itemsId.toString()),
                    addOnPressed: () =>
                        controller.add(itemCart.itemsId.toString()),
                  ),
                ),
              );
            },
            childCount: controller.cartProduct.length,
          ),
        ),
      );
    }
  }
}