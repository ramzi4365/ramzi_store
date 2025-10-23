import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../../../controller/productDetailsController.dart';
import '../../../core/constant/color.dart';

class CustomItemCountAndPrice extends GetView<ProductDetailsControllerImp> {
  const CustomItemCountAndPrice({super.key});

  @override
  Widget build(BuildContext context) {
    // REMOVE THIS LINE: Get.put(ProductDetailsControllerImp());
    // Use Get.find() instead or just use 'controller' directly since you're extending GetView

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            IconButton(
                onPressed: () {
                  controller.add(controller.itemsModel.itemsId.toString());
                },
                icon: Icon(Icons.add_circle)
            ),
            Container(
              height: 38,
              width: 30,
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 12),
              color: Colors.white,
              child: GetBuilder<ProductDetailsControllerImp>(
                builder: (controller) {
                  final currentCount = controller.optimisticCounts[controller.itemsModel.itemsId.toString()] ?? 0;
                  return Text(
                    "$currentCount",
                    style: TextStyle(
                        fontSize: 18,
                        color: AppColor.primaryColor
                    ),
                  );
                },
              ),
            ),
            IconButton(
                onPressed: () {
                  controller.remove(controller.itemsModel.itemsId.toString());
                },
                icon: Icon(Icons.remove_circle)
            ),
          ],
        ),
        Spacer(),
        GetBuilder<ProductDetailsControllerImp>(
          builder: (controller) {
            final currentCount = controller.optimisticCounts[controller.itemsModel.itemsId.toString()] ?? 0;
            return Text(
              currentCount == 1 ?
              "${controller.itemsModel.itemsPrice} \$" :
              "${controller.totalPrices} \$",
              style: TextStyle(
                  fontSize: 15,
                  color: AppColor.primaryColor,
                  fontWeight: FontWeight.bold
              ),
            );
          },
        )
      ],
    );
  }
}