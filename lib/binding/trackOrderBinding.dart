// bindings/track_order_binding.dart
import 'package:get/get.dart';

import '../controller/trackOrderController.dart';


class TrackOrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TrackOrderController>(() => TrackOrderController());
  }
}