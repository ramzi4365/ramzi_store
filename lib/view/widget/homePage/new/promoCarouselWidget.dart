import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controller/homePageController.dart';


class PromoCarouselWidget extends StatelessWidget {
  final HomePageControllerImp controller;

  const PromoCarouselWidget({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomePageControllerImp>(
      builder: (controller) {
        return Column(
          children: [
            SizedBox(
              height: 180,
              child: PageView.builder(
                controller: controller.carouselController,
                onPageChanged: controller.updateCarouselIndex,
                itemCount: controller.promoData.length,
                itemBuilder: (context, index) {
                  final promo = controller.promoData[index];
                  return _buildPromoItem(context, promo);
                },
              ),
            ),
            const SizedBox(height: 16),
            _buildIndicatorDots(context, controller),
          ],
        );
      },
    );
  }

  Widget _buildPromoItem(BuildContext context, Map<String, dynamic> promo) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: promo['color'],
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: promo['color'].withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -50,
            top: -50,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.1),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  promo['title'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  promo['subtitle'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    'Shop Now',
                    style: TextStyle(
                      color: promo['color'],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIndicatorDots(BuildContext context, HomePageController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: controller.promoData.asMap().entries.map((entry) {
        return Container(
          width: controller.currentCarouselIndex == entry.key ? 24 : 8,
          height: 8,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Theme.of(context).primaryColor.withOpacity(
              controller.currentCarouselIndex == entry.key ? 0.9 : 0.3,
            ),
          ),
        );
      }).toList(),
    );
  }
}