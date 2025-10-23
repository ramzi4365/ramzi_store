// // In your testView.dart
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:ramzi_store/controller/testController.dart';
// import 'package:ramzi_store/core/class/statusRequest.dart';
//
// class TestView extends StatelessWidget {
//   const TestView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(title: Text("title"),),
//         body: GetBuilder<TestController>(
//              // Add this line
//             builder: (controller) {
//               if(controller.statusRequest == StatusRequest.loading){
//                 return const Center(child: Text("loading"));
//               }else if(controller.statusRequest == StatusRequest.offlinefailure){
//                 return const Center(child: Text("Offline Failure"),);
//               }else if(controller.statusRequest == StatusRequest.serverfailure){
//                 return const Center(child: Text("server Failure",
//                   style:   TextStyle(fontSize: 19,color: Colors.red),),);
//
//               }else{
//                 return ListView.builder(
//                     itemCount: controller.data.length,
//                     itemBuilder: (context, index){
//                       return Text("${controller.data[index]}"); // Fixed: access individual item
//                     }
//                 );
//               }
//             }
//         )
//     );
//   }
// }