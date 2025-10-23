import 'package:get/get.dart';
import 'package:ramzi_store/controller/auth/loginController.dart';
import 'package:ramzi_store/controller/testController.dart';
import 'package:ramzi_store/core/class/crud.dart';
import 'package:ramzi_store/data/dataSource/remote/testData.dart';

import '../controller/auth/signUpController.dart';
import '../controller/cartController.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // Add all your dependencies here
    Get.lazyPut(()=> SignUpControllerImp(),fenix: true);
    Get.lazyPut<CartController>(() => CartController(), fenix: true);

    Get.put(Crud());
    Get.put(TestData(Get.find())); // Add TestData dependency
    Get.put(TestController()); // Add TestController dependency
  }
}