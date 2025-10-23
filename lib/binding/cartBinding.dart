import 'package:get/get.dart';

import '../controller/cartController.dart';


class CartBinding extends Bindings {
  @override
  void dependencies() {
    // This will create a new instance every time the cart page is accessed
    Get.lazyPut<CartController>(() => CartController(), fenix: true);
  }
}