import 'package:dartz/dartz.dart';
import 'package:ramzi_store/core/class/statusRequest.dart';
import 'package:ramzi_store/linkApi.dart';
import '../../../../core/class/crud.dart';

class ItemsData {
  Crud crud;
  ItemsData(this.crud,);

  Future<Either<StatusRequest, Map>> postData(String id ,String userid) async {
    var response = await crud.postData(AppiLink.items , {

      "id":id.toString() ,
      "userid":userid


    });

    // Return the response as-is (Either<StatusRequest, Map>)
    return response;
  }
}