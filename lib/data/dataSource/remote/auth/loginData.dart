import 'package:dartz/dartz.dart';
import 'package:ramzi_store/core/class/statusRequest.dart';
import 'package:ramzi_store/linkApi.dart';
import '../../../../core/class/crud.dart';

class LoginData {
  Crud crud;
  LoginData(this.crud);

  Future<Either<StatusRequest, Map>> postData( String email,String password,  ) async {
    var response = await crud.postData(AppiLink.login, {

      "password": password,
      "email": email,

    });

    // Return the response as-is (Either<StatusRequest, Map>)
    return response;
  }
}