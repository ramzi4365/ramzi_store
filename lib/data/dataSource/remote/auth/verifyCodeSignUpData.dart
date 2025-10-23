import 'package:dartz/dartz.dart';
import 'package:ramzi_store/core/class/statusRequest.dart';
import 'package:ramzi_store/linkApi.dart';
import '../../../../core/class/crud.dart';

class VerifyCodeSignUpData {
  Crud crud;
  VerifyCodeSignUpData(this.crud);

  Future<Either<StatusRequest, Map>> postData( String email, String verifyCode) async {
    var response = await crud.postData(AppiLink.verify_code, {

      "verifyCode": verifyCode,
      "email": email,

    });

    // Return the response as-is (Either<StatusRequest, Map>)
    return response;
  }
}