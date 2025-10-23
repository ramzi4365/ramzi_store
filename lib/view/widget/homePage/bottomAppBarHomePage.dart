// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../../controller/mainScreenController.dart';
// import 'customBottonAppBar.dart';
//
// class BottomAppBarHomePage extends StatelessWidget {
//   const BottomAppBarHomePage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<MainScreenControllerImp>(
//         builder: (controller) =>BottomAppBar(
//       shape: const CircularNotchedRectangle(),
//       notchMargin: 10,
//       child: Row(
//         children: [
//
//
//           ...List.generate(
//
//             controller.pages.length + 1,
//
//                 (index)  {
//               int i =index>2 ? index-1 : index;
//               return index==2 ? const Spacer():
//               CustomBouttonAppBar(
//                 onPressed: () {
//                   controller.changePage(i);
//
//                 },
//                 textBotton: controller.titleBottomAppBar[i], // Consider making this dynamic
//                 iconData: controller.icons[i],
//                 active: controller.currentPage == i, // No need for ? true : false
//               );
//             }
//
//             ,
//           ),
//
//         ],
//       )
//       ,
//     )
//     );
//   }
// }
