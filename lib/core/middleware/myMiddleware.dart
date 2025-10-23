//

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ramzi_store/core/constant/routes.dart';
import 'package:ramzi_store/core/services/services.dart';



// // class MyMiddleware extends GetMiddleware{
// //  MyServices myServices =Get.find();
// //
// // @override
// //   int? get priority => 1 ;
// //
// // @override
// //   RouteSettings? redirect(String? route) {
// //
// //
// //   if (myServices.sharedPreferences.getString("step") == "2") {
// //     return const RouteSettings(name: AppRoute.mainScreen);
// //   }
// //
// //   if (myServices.sharedPreferences.getString("step") == "1") {
// //     return const RouteSettings(name: AppRoute.login);
// //   }
// //
// //
// //
// //   return null;
// // }
// //
// // }
// //
//
//
//
//
//
//
//
//
//
// class MyMiddleware extends GetMiddleware {
// MyServices myServices = Get.find();
//
// @override
// int? get priority => 1;
//
// @override
// RouteSettings? redirect(String? route) {
//   final String? step = myServices.sharedPreferences.getString("step");
//
//   // Allow navigation to the items page without redirection
//   // if (route == AppRoute.items) {
//   //   return null;
//   // }
//
//   // If user is authenticated (step == "2")
//   if (step == "2") {
//     // Only redirect the root route to mainScreen
//     if (route == "/") {
//       return const RouteSettings(name: AppRoute.mainScreen);
//     }
//     // Allow all other navigation (items, etc.)
//     return null;
//   }
//
//   // If user completed onboarding but not logged in (step == "1")
//   if (step == "1") {
//     // Redirect to login
//     return const RouteSettings(name: AppRoute.login);
//   }
//
//   // If no step (new user), redirect to onboarding
//   if (step == null) {
//     return const RouteSettings(name: AppRoute.language);
//   }
//
//   return null;
// }
// }
//
//
//
//


class MyMiddleware extends GetMiddleware {
  MyServices myServices = Get.find();

  @override
  int? get priority => 1;

  @override
  RouteSettings? redirect(String? route) {
    final String? step = null;//myServices.sharedPreferences.getString("step");

    debugPrint('Middleware triggered: route=$route, step=$step');

    // If already on target route, don't redirect
    if (route == AppRoute.language && step == null) return null;
    if (route == AppRoute.login && step == "1") return null;
    if (route == AppRoute.mainScreen && step == "2") return null;

    // Redirect logic
    if (step == "2") {
      // Authenticated user - go to home
      return const RouteSettings(name: AppRoute.mainScreen);
    }
    else if (step == "1") {
      // Onboarded but not logged in - go to login
      return const RouteSettings(name: AppRoute.login);
    }
    else {
      // New user - always start from language
      return const RouteSettings(name: AppRoute.language);
    }
  }
}