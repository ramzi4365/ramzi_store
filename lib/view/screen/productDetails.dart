








// Compact Product Detail Page
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controller/productDetailsController.dart';
import '../../linkApi.dart';
import '../widget/productDetails/new/colorSelectionWidget.dart';
import '../widget/productDetails/new/customBottomAppBar.dart';
import '../widget/productDetails/new/descriptionSectionWidget.dart';
import '../widget/productDetails/new/infoGridWidget.dart';
import '../widget/productDetails/new/priceRatingWidget.dart';
import '../widget/productDetails/new/productHeaderWidget.dart';
import '../widget/productDetails/new/quantitySectionWidget.dart';
import '../widget/productDetails/new/sizeSelectionWidget.dart';



class ProductDetails extends StatelessWidget {
  ProductDetails({super.key});

  final ProductDetailsControllerImp controller = Get.put(
      ProductDetailsControllerImp());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenHeight = MediaQuery
        .of(context)
        .size
        .height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              // Image Gallery
              SliverAppBar(
                expandedHeight: screenHeight * 0.45,
                pinned: true,
                backgroundColor: Colors.white,
                elevation: 0,
                leading: _buildAppBarButton(
                  icon: Icons.arrow_back_ios_new,
                  onPressed: () => Get.back(),
                ),
                actions: [
                  GetBuilder<ProductDetailsControllerImp>(
                    builder: (controller) =>
                        _buildAppBarButton(
                          icon: controller.isFavorite!
                              ? Icons.favorite
                              : Icons.favorite_outline,
                          onPressed: () =>controller.toggleFavorite(),
                          color: controller.isFavorite! ? Colors.red : null,
                        ),
                  ),
                  _buildAppBarButton(
                    icon: Icons.share_outlined,
                    onPressed: () {},
                  ),
                  const SizedBox(width: 8),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    children: [
                      // Single Image instead of PageView
                      GetBuilder<ProductDetailsControllerImp>(
                        builder: (controller) {
                          final imageUrl = controller.itemsModel.itemsImage != null
                              ? "${AppiLink.imageItems}/${controller.itemsModel.itemsImage}"
                              : 'https://via.placeholder.com/400x400/9B59B6/FFFFFF?text=No+Image';

                          return Container(
                            margin: const EdgeInsets.only(top: 60),
                            //padding: const EdgeInsets.only(left: 60),
                            width: 400,
                            height:400 ,
                            child: CachedNetworkImage(
                              imageUrl: imageUrl,
                              fit: BoxFit.fill,
                              placeholder: (context, url) => Container(
                                color: Colors.grey[200],
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                              errorWidget: (context, url, error) => Container(
                                color: Colors.grey[200],
                                child: const Center(
                                  child: Icon(
                                    Icons.image_not_supported,
                                    size: 50,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),

                      // Badges
                      Positioned(
                        top: 80,
                        left: 16,
                        child: GetBuilder<ProductDetailsControllerImp>(
                          builder: (controller) =>
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (controller.itemsModel.itemsDiscount !=
                                      null &&
                                      controller.itemsModel.itemsDiscount! > 0)
                                    _buildBadge(
                                      '${controller.itemsModel
                                          .itemsDiscount}% OFF',
                                      theme.colorScheme.secondary,
                                    ),
                                  // You can add other badges here if needed
                                ],
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Product Details
              SliverToBoxAdapter(
                child: FadeTransition(
                  opacity: controller.fadeAnimation,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(24),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Product Header
                          GetBuilder<ProductDetailsControllerImp>(
                            builder: (controller) => ProductHeader(
                              product: controller.itemsModel,
                              categoryName: controller.itemsModel.categoriesName ?? 'Category',
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Price Rating
                          GetBuilder<ProductDetailsControllerImp>(
                            builder: (controller) => PriceRating(
                              product: controller.itemsModel,
                              savedAmount: controller.calculateSavedAmount,
                              rating: 4.6, // You can get this from your model
                              reviewCount: 123, // You can get this from your model
                            ),
                          ),
                          const SizedBox(height: 24),

                          // Color Selection
                          GetBuilder<ProductDetailsControllerImp>(
                            builder: (controller) => ColorSelection(
                              product: controller.itemsModel,
                              colors: controller.availableColors,
                              selectedIndex: controller.selectedColorIndex,
                              onColorSelected: controller.changeColorIndex,
                            ),
                          ),
                          const SizedBox(height: 24),

                          // Size Selection
                          GetBuilder<ProductDetailsControllerImp>(
                            builder: (controller) => SizeSelection(
                              product: controller.itemsModel,
                              sizes: controller.availableSizes,
                              selectedIndex: controller.selectedSizeIndex,
                              onSizeSelected: controller.changeSizeIndex,
                              onSizeGuidePressed: () {
                                // Handle size guide press
                              },
                            ),
                          ),
                          const SizedBox(height: 28),

                          // Quantity Section
                          GetBuilder<ProductDetailsControllerImp>(
                            builder: (controller) => QuantitySection(
                              product: controller.itemsModel,
                              quantity: controller.quantity,
                              onIncrement:() => controller.add(controller.itemsModel.itemsId.toString()),
                              onDecrement: () => controller.remove(controller.itemsModel.itemsId.toString()),
                            ),
                          ),
                          const SizedBox(height: 24),
                          GetBuilder<ProductDetailsControllerImp>(
                            builder: (controller) => DescriptionSection(
                              product: controller.itemsModel,
                              showFullDescription: controller.showFullDescription,
                              onToggleDescription: controller.toggleDescription,
                            ),
                          ),
                          const SizedBox(height: 24),

                          // Info Grid (static - no controller needed)
                          const InfoGrid(),
                          // Bottom Bar
                          GetBuilder<ProductDetailsControllerImp>(
                            builder: (controller) => ProductBottomBar(
                              product: controller.itemsModel,
                              isFavorite: controller.isFavorite!,
                              isAddingToCart: controller.isAddingToCart,
                              quantity: controller.quantity,
                              onToggleFavorite: controller.toggleFavorite,
                              onAddToCart: () => controller.addToCart(controller.itemsModel),
                            ),
                          ),


                          // ... rest of your widgets
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Bottom Bar

        ],
      ),
    );
  }


  Widget _buildBadge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }


  Widget _buildAppBarButton({
    required IconData icon,
    required VoidCallback onPressed,
    Color? color,
  }) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(icon, color: color ?? Colors.black87, size: 18),
        onPressed: onPressed,
      ),
    );
  }


}



