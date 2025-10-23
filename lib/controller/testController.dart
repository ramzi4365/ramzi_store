import 'package:get/get.dart';
import 'package:ramzi_store/core/class/statusRequest.dart';
import 'package:ramzi_store/data/dataSource/remote/testData.dart';

import '../core/functions/handlingData.dart';


class TestController extends GetxController {
  List data = [];
  StatusRequest statusRequest = StatusRequest.loading;
  TestData testData = TestData(Get.find());

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  getData() async {
    statusRequest = StatusRequest.loading;
    update(); // Notify UI about loading state

    var response = await testData.getData();
    print("API Response: $response"); // Debug print

    statusRequest = handlingData(response);
    print("Status after handling: $statusRequest"); // Debug print

    if (StatusRequest.success == statusRequest) {
     if(response['status']=="success"){

        print("Data loaded: $data"); // Debug print
      }else {
        statusRequest == StatusRequest.failure;        // Debug print
     }
    }
    update(); // Notify UI about state change
  }
}