



import 'package:dartz/dartz.dart';
import 'package:ramzi_store/core/class/statusRequest.dart';
import 'package:ramzi_store/linkApi.dart';
import '../../../../core/class/crud.dart';

class CheckoutData {
  Crud crud;

  CheckoutData(this.crud,);

  Future<Either<StatusRequest, Map>> checkout(Map data) async {
    var response = await crud.postData(AppiLink.checkout, data);

    // Return the response as-is (Either<StatusRequest, Map>)
    return response;
  }

}