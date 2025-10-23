import 'package:dartz/dartz.dart';
import 'package:ramzi_store/core/class/statusRequest.dart';
import 'package:ramzi_store/linkApi.dart';
import '../../../../core/class/crud.dart';

class MyFavoriteData {
  Crud crud;
  MyFavoriteData(this.crud,);

  Future<Either<StatusRequest, Map>> postData(String id) async {
    var response = await crud.postData(AppiLink.myfavorite , {

      "id":id ,


    }
    );

    // Return the response as-is (Either<StatusRequest, Map>)
    return response;

  }

}