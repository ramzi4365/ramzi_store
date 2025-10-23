import 'package:flutter/material.dart';
import '../../../core/constant/imageasset.dart';

class LogoAuth extends StatelessWidget {
  const LogoAuth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
          border: Border.all(
            color: Colors.grey.shade200,
            width: 2,
          ),
        ),
        padding: const EdgeInsets.all(15),
        child: ClipOval(
          child: Image.asset(
            AppImageAsset.logo,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}