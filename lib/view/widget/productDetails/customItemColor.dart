import 'package:flutter/material.dart';

import '../../../core/constant/color.dart';

class CusttomItemColor extends StatelessWidget {



  const CusttomItemColor({super.key,});

  @override
  Widget build(BuildContext context) {
    return

      Row(


        children: [
        ...List.generate(3, (index) => Container(
        margin: EdgeInsets.only(right: 15),
        alignment: Alignment.center,
        height: 60,
        width: 80,
        decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey)
        ),
        child: const Text("Red",
          style: TextStyle(fontSize: 15,
              color: AppColor.black,
              fontWeight: FontWeight.bold),),
      ),


        )],
      );
  }
}
