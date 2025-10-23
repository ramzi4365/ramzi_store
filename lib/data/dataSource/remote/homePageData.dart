import 'package:dartz/dartz.dart';
import 'package:ramzi_store/core/class/statusRequest.dart';
import 'package:ramzi_store/linkApi.dart';
import '../../../../core/class/crud.dart';

class HomePageData {
  Crud crud;
  HomePageData(this.crud);

  Future<Either<StatusRequest, Map>> postData() async {
    var response = await crud.postData(AppiLink.homePage , {

    });

    // Return the response as-is (Either<StatusRequest, Map>)
    return response;
  }

  Future<Either<StatusRequest, Map>> searchData(String search) async {
    var response = await crud.postData(AppiLink.search , {
      "search":search


    });

    // Return the response as-is (Either<StatusRequest, Map>)
    return response;
  }



}