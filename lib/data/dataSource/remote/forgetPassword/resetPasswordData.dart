import 'package:dartz/dartz.dart';
import 'package:ramzi_store/core/class/statusRequest.dart';
import 'package:ramzi_store/linkApi.dart';
import '../../../../core/class/crud.dart';

class ResetPasswordData {
  Crud crud;
  ResetPasswordData (this.crud);

  Future<Either<StatusRequest, Map>> postData( String email,String password,  ) async {
    var response = await crud.postData(AppiLink.reset_password, {

      "email" : email,
      "password": password,

    });

    // Return the response as-is (Either<StatusRequest, Map>)
    return response;
  }
}