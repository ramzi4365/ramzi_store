import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import 'package:ramzi_store/data/model/categoriesModel.dart';

import '../../../controller/homePageController.dart';
import '../../../core/functions/translateDatabase.dart';
import '../../../linkApi.dart';

class CustomCategoriesHomePage extends GetView<HomePageControllerImp> {

  const CustomCategoriesHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height:100 ,
        width: double.infinity,

        child: ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(width: 20,),

            scrollDirection: Axis.horizontal,
            itemCount: controller.categories.length,
            itemBuilder: (context, index) {

              return Categories(
                i : index, categoriesModel: controller.categories[index],);


            }

        )


    );
  }
}



class Categories extends GetView<HomePageControllerImp> {
  final int? i;
  final CategoriesModel categoriesModel;

  const Categories(  {super.key, required this.categoriesModel,required this.i ,});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        controller.goToItems(controller.categories,i!,categoriesModel.categoriesId.toString()!);
      },
      child: Column(children: [


      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey[200],
        ),
        width: 70,
        height: 70,
        padding: const EdgeInsets.all(10),
        //margin: EdgeInsets.only(right: 10),
        child: SvgPicture.network("${AppiLink.imageCategories}/${categoriesModel.categoriesImage}",),

      ),
      Text("${translateDatabase(categoriesModel.categoriesNameAr,categoriesModel.categoriesName)}",style: const TextStyle(color: Colors.black,fontSize: 15),),

    ],));
  }
}


//
//
// class Categories extends GetView<HomePageControllerImp> {
//   final int? i;
//   final CategoriesModel categoriesModel;
//   const Categories({super.key, required this.categoriesModel, required this.i});
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         controller.goToItems(controller.categories, i!);
//       },
//       child: Column(
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(20),
//               color: Colors.grey[200],
//             ),
//             width: 70,
//             height: 70,
//             padding: const EdgeInsets.all(10),
//             // USE ICONS INSTEAD OF SVG - NO MORE ERRORS
//             child: _getCategoryIcon(categoriesModel.categoriesName!),
//           ),
//           Text(
//             "${categoriesModel.categoriesName}",
//             style: const TextStyle(color: Colors.black, fontSize: 15),
//           ),
//         ],
//       ),
//     );
//   }

//
//   // Helper method to get appropriate icons for each category
//   Icon _getCategoryIcon(String categoryName) {
//     switch (categoryName.toLowerCase()) {
//       case 'laptop':
//         return const Icon(Icons.laptop_mac, color: Colors.blue, size: 30);
//       case 'camera':
//         return const Icon(Icons.camera_alt, color: Colors.blue, size: 30);
//       case 'mobile':
//         return const Icon(Icons.smartphone, color: Colors.blue, size: 30);
//       case 'shoes':
//         return const Icon(Icons.shopping_bag, color: Colors.blue, size: 30);
//       case 'dress':
//         return const Icon(Icons.checkroom, color: Colors.blue, size: 30);
//       default:
//         return const Icon(Icons.category, color: Colors.blue, size: 30);
//     }
//   }
// }