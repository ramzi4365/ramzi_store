import 'package:get/get_utils/get_utils.dart';
import 'package:ramzi_store/core/constant/imageasset.dart';
import 'package:ramzi_store/data/model/onboardingmodel.dart';

List<OnBoardingModel> onBoardingList = [
  // Use parentheses () for constructors, not curly braces {}
  OnBoardingModel(
      title: "2".tr,
      body: "3".tr,
      // Use the lowerCamelCase variable name we fixed earlier
      image: AppImageAsset.onBoardingImageOne
  ),
  OnBoardingModel(
      title: "4".tr,
      body: "5".tr,
      // Corrected spelling and naming convention
      image: AppImageAsset.onBoardingImageTwo
  ),
  OnBoardingModel(
      title: "6".tr,
      body: "7".tr,
      image: AppImageAsset.onBoardingImageThree
  ),



];