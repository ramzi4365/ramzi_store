import 'package:flutter/material.dart';
import 'package:ramzi_store/core/constant/color.dart';

class CustomButtonAuth extends StatelessWidget {
  final String text ;
  final void Function()? onPressed;
  const CustomButtonAuth ({Key? key, required this.text, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin:const EdgeInsets.only(top: 10),

        child: MaterialButton(
        padding: const EdgeInsets.symmetric(vertical: 13),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        onPressed: onPressed,

        color: AppColor.primaryColor,
        textColor: Colors.white,
        child: Text(text),
    )


    );
  }
}
