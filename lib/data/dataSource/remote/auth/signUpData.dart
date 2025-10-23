import 'package:dartz/dartz.dart';
import 'package:ramzi_store/core/class/statusRequest.dart';
import 'package:ramzi_store/linkApi.dart';
import '../../../../core/class/crud.dart';

class SignUpData {
  Crud crud;
  SignUpData(this.crud);

  Future<Either<StatusRequest, Map>> postData(String username, String password, String email, String phone) async {
    var response = await crud.postData(AppiLink.signUp, {
      "username": username,
      "password": password,
      "email": email,
      "phone": phone,
    });

    // Return the response as-is (Either<StatusRequest, Map>)
    return response;
  }
}