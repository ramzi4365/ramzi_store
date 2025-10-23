import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ramzi_store/data/model/itemsModel.dart';

import '../../../controller/homePageController.dart';
import '../../../linkApi.dart';

class ListItemHomePage extends GetView<HomePageControllerImp> {
  const ListItemHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(

      height: 200,


      child: ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(height: 30,),

          scrollDirection: Axis.horizontal,
          itemCount: controller.homeItems.length,
          itemBuilder: (context, index,){
            return ItemHome(itemsModel: controller.homeItems[index]);
          }
      ),
    );
  }
}



class ItemHome extends StatelessWidget {
  final ItemsModel itemsModel;
  const ItemHome({super.key, required this.itemsModel});


  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        margin: const EdgeInsets.only(right: 30),

        height: 200,
        width: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey[200],
        ),
        child: Image.network("${AppiLink.imageItems}/${itemsModel.itemsImage}",),
      ),
      Container(
        height: 200,
        width: 200,
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      Positioned(
        top:30,
        left: 20,
        child: Text("${itemsModel.itemsName}",style:  TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),),

      ),

    ],);
  }
}
