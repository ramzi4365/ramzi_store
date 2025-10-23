import 'package:dartz/dartz.dart';
import 'package:ramzi_store/core/class/statusRequest.dart';
import 'package:ramzi_store/linkApi.dart';
import '../../../../core/class/crud.dart';

class CartData {
  Crud crud;
  CartData(this.crud,);

  Future<Either<StatusRequest, Map>> cartAdd(String  userId ,String itemId) async {
    var response = await crud.postData(AppiLink.cartAdd , {

      "userid":userId ,
      "itemid":itemId
    }
    );

    // Return the response as-is (Either<StatusRequest, Map>)
    return response;

  }


  Future<Either<StatusRequest, Map>> cartRemove(String  userId ,String itemId) async {
    var response = await crud.postData(AppiLink.cartRemove , {

      "userid":userId ,
      "itemid":itemId


    }
    );

    // Return the response as-is (Either<StatusRequest, Map>)
    return response;
  }

  Future<Either<StatusRequest, Map>> cartCount(String  userId ,String itemId) async {
    var response = await crud.postData(AppiLink.cartCount , {

      "userid":userId ,
      "itemid":itemId


    }
    );

    // Return the response as-is (Either<StatusRequest, Map>)
    return response;

  }


  Future<Either<StatusRequest, Map>> cartView(String  userId ) async {
    var response = await crud.postData(AppiLink.cartView , {

      "userid":userId ,
    }
    );

    // Return the response as-is (Either<StatusRequest, Map>)
    return response;

  }


  Future<Either<StatusRequest, Map>> checkCoupon(String  couponName , ) async {
    var response = await crud.postData(AppiLink.coupon , {

      "couponName":couponName ,
    }
    );

    // Return the response as-is (Either<StatusRequest, Map>)
    return response;

  }






}