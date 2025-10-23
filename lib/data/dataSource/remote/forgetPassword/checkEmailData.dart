import 'package:dartz/dartz.dart';
import 'package:ramzi_store/core/class/statusRequest.dart';
import 'package:ramzi_store/linkApi.dart';
import '../../../../core/class/crud.dart';

class CheckEmailData {
  Crud crud;
  CheckEmailData(this.crud);

  Future<Either<StatusRequest, Map>> postData( String email, ) async {
    var response = await crud.postData(AppiLink.check_email, {


      "email": email,

    });

    // Return the response as-is (Either<StatusRequest, Map>)
    return response;
  }
}