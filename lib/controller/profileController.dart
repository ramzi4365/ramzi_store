


import 'package:get/get.dart';
import 'package:ramzi_store/core/constant/routes.dart';
import 'package:ramzi_store/core/services/services.dart';
import 'package:ramzi_store/routes.dart';

abstract class ProfileController extends GetxController{
  logOut();

}

class SettigsControllerImp extends ProfileController{

  MyServices myServices = Get.find();
  @override
  logOut() {
    myServices.sharedPreferences.remove("step");

    myServices.sharedPreferences.clear();
    Get.offAllNamed(AppRoute.login);
    // TODO: implement logOut

  }

}