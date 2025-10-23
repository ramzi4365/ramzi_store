

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ramzi_store/core/constant/routes.dart';
import 'package:ramzi_store/core/services/services.dart';
import 'package:ramzi_store/data/dataSource/static/static.dart';
import 'package:ramzi_store/data/model/onboardingmodel.dart';

abstract class OnBoardingController extends GetxController{
  next();
  OnPageChanged(int index);


}



class OnBoardingControllerImp extends OnBoardingController{


  MyServices myServices = Get.find();
  late PageController pageController ;


  int currentPage = 0;
  @override
  next(){
    currentPage++;
    if (currentPage > (onBoardingList.length-1)){
      myServices.sharedPreferences.setString("step" , '1');
      Get.offAllNamed(AppRoute.login);

    }


    else{
      pageController.animateToPage(currentPage,
          duration: Duration(milliseconds: 900),
          curve: Curves.easeInOut);
    }
  }

  @override
  OnPageChanged(int index){

    currentPage = index;

    update();
  }
  void onInit(){
    pageController = PageController();
    super.onInit();
  }


}