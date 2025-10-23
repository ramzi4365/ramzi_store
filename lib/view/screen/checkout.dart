import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ramzi_store/view/widget/checkOut/orderSummarySectionWidget.dart';
import '../../controller/checkOutController.dart';

import '../widget/checkOut/addressSectionWidget.dart';
import '../widget/checkOut/bottomCheckoutWidget.dart';
import '../widget/checkOut/customAppBar.dart';
import '../widget/checkOut/paymentSectionWidget.dart';
import '../widget/checkOut/progressStepsWidget.dart';
import '../widget/checkOut/sectionCardWidget.dart';


class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final CheckoutController controller = Get.put(CheckoutController());

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: CustomAppBar(
        title: 'Checkout',
        onBackPressed: () => Get.back(),
        showSecureBadge: true,
      ),
      body: CustomScrollView(
        slivers: [
          // Progress Steps
          SliverToBoxAdapter(
            child: GetBuilder<CheckoutController>(
              builder: (controller) => Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: ProgressStepsWidget(currentStep: controller.currentStep),
              ),
            ),
          ),

          // Content
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Delivery Address Section
                GetBuilder<CheckoutController>(

                  builder: (controller) => SectionCardWidget(
                    title: 'Delivery Address',
                    icon: Icons.location_on_rounded,
                    iconColor: Colors.blue[600]!,
                    child: AddressSectionWidget(
                      addresses: controller.addresses,
                      selectedIndex: controller.selectedAddressIndex,
                      onAddressSelected: controller.selectAddress,
                      onAddNewAddress: () {
                        controller.goToAddNewAddress();
                        // Handle adding new address
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Payment Method Section
                GetBuilder<CheckoutController>(
                  builder: (controller) => SectionCardWidget(
                    title: 'Payment Method',
                    icon: Icons.payment_rounded,
                    iconColor: Colors.green[600]!,
                    child: PaymentSectionWidget(
                      paymentMethods: controller.paymentMethods,
                      selectedIndex: controller.selectedPaymentIndex,
                      onPaymentSelected: controller.selectPaymentMethod,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Order Summary Section
                GetBuilder<CheckoutController>(
                  builder: (controller) => SectionCardWidget(
                    title: 'Order Summary',
                    icon: Icons.receipt_long_rounded,
                    iconColor: Colors.orange[600]!,
                    child: OrderSummarySectionWidget(
                      //promoController: controller.promoController,
                     // onApplyPromo: controller.applyPromoCode,
                      itemsCartName: controller.itemsCartName,
                      subtotal: controller.getFormattedSubtotal(),
                      deliveryFee: controller.getFormattedDeliveryFee(),
                      tax: controller.getFormattedTax(),
                      total: controller.getFormattedTotal(),
                    ),
                  ),
                ),
                const SizedBox(height: 100),
              ]),
            ),
          ),
        ],
      ),
      bottomSheet: GetBuilder<CheckoutController>(
        builder: (controller) => BottomCheckoutWidget(
          total: controller.getFormattedTotal(),
          onPlaceOrder: controller.placeOrder,

        ),
      ),
    );
  }
}