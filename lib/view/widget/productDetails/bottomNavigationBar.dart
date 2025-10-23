//
//
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../../controller/productDetailsController.dart';
// import '../../../core/constant/color.dart';
//
// class BottomNavigationBarItem extends GetView<ProductDetailsControllerImp> {
//
//
//   const BottomNavigationBarItem({super.key,});
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         margin: EdgeInsets.only(bottom: 40,left: 20,right: 20),
//
//
//
//         height: 40,
//         width: 50,
//         child: MaterialButton(
//           padding: const EdgeInsets.symmetric(vertical: 2),
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//
//
//           color: AppColor.primaryColor,
//           textColor: Colors.white,
//           onPressed: (){
//             controller.goToCartDetails();
//
//
//           },
//
//           child: Text("Add to cart",style: TextStyle(fontSize: 17)),
//         )
//     );
//   }
// }
