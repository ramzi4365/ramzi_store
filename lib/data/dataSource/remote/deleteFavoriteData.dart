import 'package:dartz/dartz.dart';
import 'package:ramzi_store/core/class/statusRequest.dart';
import 'package:ramzi_store/linkApi.dart';
import '../../../../core/class/crud.dart';

class DeleteFavoriteData {
  Crud crud;
  DeleteFavoriteData(this.crud,);

  Future<Either<StatusRequest, Map>> deleteFavorite(String  favorite_id ) async {
    var response = await crud.postData(AppiLink.deleteFavoriteItems , {

      "id":favorite_id ,


    }
    );

    // Return the response as-is (Either<StatusRequest, Map>)
    return response;

  }





}