

import 'package:get/get.dart';
import 'package:ramzi_store/core/constant/routes.dart';

abstract class SuccessResetPasswordController  extends  GetxController{




  goToPageLogin();

}
class SuccessResetPasswordControllerImp extends SuccessResetPasswordController{





  @override
  void onInit(){


    super.onInit();
  }



  @override
  goToPageLogin() {
    Get.offNamed(AppRoute.login);

  }






}
