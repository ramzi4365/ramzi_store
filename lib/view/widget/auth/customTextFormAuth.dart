
import 'package:flutter/material.dart';


class  CustomTextFormAuth extends StatelessWidget {
  final String hintText ;
  final String labeltext ;
  final IconData iconData;
  final TextEditingController? myController ;
  final String? Function(String? )? valid;
  final bool isNumber;
  final bool? obscureText;
  final bool? Function()? onTapIcon;


  const CustomTextFormAuth({Key?  key,

    this.onTapIcon,
    required this.hintText,
    required this.labeltext,
    required this.iconData,
    required this.myController,
    required this.valid,
    required this.isNumber,
    this.obscureText}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return   Container(
      margin: const EdgeInsets.only(bottom: 25),
      child: TextFormField(
        keyboardType:
        isNumber? TextInputType.numberWithOptions(decimal: true):TextInputType.text,

        validator: valid ,
        obscureText:obscureText == null || obscureText == false ? false : true ,
      controller: myController,

      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.normal) ,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding: EdgeInsets.symmetric(vertical: 5 , horizontal: 30),
          label: Container(
            margin: const EdgeInsets.symmetric(horizontal: 7),
            child: Text(labeltext),
          ),
          suffixIcon:  InkWell(child: Icon(iconData),onTap: onTapIcon,),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30)
          )
      ),
    )
    );

  }
}
