



import 'package:get/get.dart';

import 'package:ramzi_store/core/constant/routes.dart';
import 'package:ramzi_store/core/middleware/myMiddleware.dart';
import 'package:ramzi_store/view/screen/address/add.dart';
import 'package:ramzi_store/view/screen/address/edite.dart';
import 'package:ramzi_store/view/screen/address/view.dart';

import 'package:ramzi_store/view/screen/auth/forgetPassword/forgetPassword.dart';
import 'package:ramzi_store/view/screen/auth/login.dart';
import 'package:ramzi_store/view/screen/auth/forgetPassword/resetPassword.dart';
import 'package:ramzi_store/view/screen/cartIDetails.dart';
import 'package:ramzi_store/view/screen/checkout.dart';
import 'package:ramzi_store/view/screen/homePage.dart';
import 'package:ramzi_store/view/screen/mainScreen.dart';

import 'package:ramzi_store/view/screen/mainScreen.dart';
import 'package:ramzi_store/view/screen/items.dart';
import 'package:ramzi_store/view/screen/language.dart';
import 'package:ramzi_store/view/screen/myFavorite.dart';

import 'package:ramzi_store/view/screen/onBoarding.dart';
import 'package:ramzi_store/view/screen/auth/signUp.dart';
import 'package:ramzi_store/view/screen/productDetails.dart';
import 'package:ramzi_store/view/screen/trackOrderPage.dart';


import 'binding/cartBinding.dart';
import 'binding/trackOrderBinding.dart';
import 'view/screen/auth/forgetPassword/successResetPassword.dart';

import 'view/screen/auth/successSignUp.dart';
import 'view/screen/auth/forgetPassword/verifyCode.dart';
import 'view/screen/auth/verifyCodeSignUp.dart';

List<GetPage<dynamic>> routes = [
    GetPage(
        name: "/",
        page: () => const Language(),     // dummy, will be replaced
        middlewares: [MyMiddleware()],    // middleware attached only here
    ),
    GetPage(name: AppRoute.language, page: () => const Language()),
    // ─── Auth ────────────────────────────────────────────────────────────
    GetPage(name: AppRoute.login,         page: () => const Login()),
    GetPage(name: AppRoute.signUp,        page: () => const SignUp()),
    GetPage(name: AppRoute.forgetPassword,page: () => const ForgetPassword()),
    GetPage(name: AppRoute.verifyCode,    page: () => const VerifyCode()),
    GetPage(name: AppRoute.resetPassword, page: () => const ResetPassword()),
    GetPage(name: AppRoute.successResetPassword,
        page: () => const SuccessResetPassword()),
    GetPage(name: AppRoute.successSignUp, page: () => const SuccessSignUp()),
    GetPage(name: AppRoute.verifyCodeSignUp,
        page: () => const VerifyCodeSignUp()),

    // ─── On-boarding ──────────────────────────────────────────────────────
    GetPage(name: AppRoute.onBoarding, page: () => const OnBoarding()),

    // ─── App pages ───────────────────────────────────────────────────────
    GetPage(name: AppRoute.homePage,   page: () => const HomePage()),
    GetPage(name: AppRoute.mainScreen, page: () => MainScreen()),
    GetPage(name: AppRoute.items,      page: () => const Items()),
    GetPage(name: AppRoute.productDetails,      page: () =>  ProductDetails()),
    GetPage(name: AppRoute.cartDetails,      page: () =>  const CartDetails(),binding: CartBinding()),
    GetPage(name: AppRoute.myFavorite,      page: () => const MyFavorite()),


    GetPage(name: AppRoute.addressAdd,      page: () =>  AddressAdd()),
    GetPage(name: AppRoute.addressEdit,      page: () => const AddressEdite()),
    GetPage(name: AppRoute.addressView,      page: () =>  AddressView()),
    GetPage(name: AppRoute.checkout,      page: () => const CheckoutPage()),
    GetPage(name: AppRoute.trackOrder,      page: () => const TrackOrderPage() ,binding: TrackOrderBinding()),


];







