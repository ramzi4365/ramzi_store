import 'package:dartz/dartz.dart';
import 'package:ramzi_store/core/class/statusRequest.dart';
import 'package:ramzi_store/linkApi.dart';
import '../../../../core/class/crud.dart';

class AddRemoveFavoriteData {
  Crud crud;
  AddRemoveFavoriteData(this.crud,);

  Future<Either<StatusRequest, Map>> addFavorite(String  userId ,String itemId) async {
    var response = await crud.postData(AppiLink.add_favorite , {

      "userid":userId ,
      "itemid":itemId


    }
    );

    // Return the response as-is (Either<StatusRequest, Map>)
    return response;

  }



  Future<Either<StatusRequest, Map>> removeFavorite(String  userId ,String itemId) async {
    var response = await crud.postData(AppiLink.remove_favorite , {

      "userid":userId ,
      "itemid":itemId


    }
    );

    // Return the response as-is (Either<StatusRequest, Map>)
    return response;

  }

}