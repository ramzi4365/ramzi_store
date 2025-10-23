

import 'package:get/get.dart';
import 'package:ramzi_store/core/constant/routes.dart';

abstract class SuccessSignUpController  extends  GetxController{




  goToPageLogin();

}
class SuccessSignUpControllerImp extends SuccessSignUpController{





  @override
  void onInit(){


    super.onInit();
  }



  @override
  goToPageLogin() {
    Get.offNamed(AppRoute.login);

  }






}
