import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<bool>alertExitApp(){
  Get.defaultDialog(
    title: "Alert",
    middleText: "Do you want to exit from app ",
    actions: [
      ElevatedButton( onPressed : (){
        exit(0);

  }, child: Text("Coniform")),
      ElevatedButton( onPressed: (){
        Get.back();
  }, child: Text("Cancel"))

    ]
  );
  return Future.value(true);
}

