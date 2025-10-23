import 'package:dartz/dartz.dart';
import 'package:ramzi_store/core/class/statusRequest.dart';
import 'package:ramzi_store/linkApi.dart';
import '../../../../core/class/crud.dart';

class AddressData {
  Crud crud;
  AddressData(this.crud,);

  Future<Either<StatusRequest, Map>> addressAdd(String  userid ,String addressName,String city,String street,String phoneNumber,String details) async {
    var response = await crud.postData(AppiLink.addressAdd , {

      "userid":userid ,
      "addressName":addressName,
      "city":city ,
      "street":street,
      "phoneNumber":phoneNumber,
      "details":details,
    }
    );

    // Return the response as-is (Either<StatusRequest, Map>)
    return response;

  }


  Future<Either<StatusRequest, Map>> addressDelete(String  addressid ) async {
    var response = await crud.postData(AppiLink.addressDelete , {

      "addressid":addressid ,



    }
    );

    // Return the response as-is (Either<StatusRequest, Map>)
    return response;
  }

  Future<Either<StatusRequest, Map>> addressView(String  userid ) async {
    var response = await crud.postData(AppiLink.addressView , {

      "userid":userid ,


    }
    );

    // Return the response as-is (Either<StatusRequest, Map>)
    return response;

  }







}