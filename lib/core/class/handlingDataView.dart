
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:ramzi_store/core/class/statusRequest.dart';
import 'package:ramzi_store/core/functions/loadingIndicator.dart';

import '../constant/imageasset.dart';


class HandlingDataViewWithEmpty extends StatelessWidget {
  final StatusRequest statusRequest;
  final Widget widget;
  final bool isEmpty;
  final Widget emptyWidget;

  const HandlingDataViewWithEmpty({
    Key? key,
    required this.statusRequest,
    required this.widget,
    required this.isEmpty,
    required this.emptyWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return statusRequest == StatusRequest.loading
        ? loadingIndicator('loading...')
        : statusRequest == StatusRequest.offlinefailure
        ? Center(child: Lottie.asset(AppImageAsset.server, width: 250, height: 250))
        : statusRequest == StatusRequest.serverfailure
        ? Center(child: Lottie.asset(AppImageAsset.server, width: 250, height: 250))
        : statusRequest == StatusRequest.failure
        ? Center(child: Lottie.asset(AppImageAsset.server, width: 250, height: 250)) //Center(child: Lottie.asset(AppImageAsset.noData, width: 250, height: 250, repeat: true))
        : isEmpty
        ? emptyWidget
        : widget;
  }
}
