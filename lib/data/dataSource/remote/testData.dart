import 'package:ramzi_store/linkApi.dart';

import '../../../core/class/crud.dart';

class TestData {
  Crud crud ;

  TestData(this.crud);

  getData()async{
    var response = await crud.postData(AppiLink.test,{});
    return response.fold((l) => 1, (r) => r);
  }


}