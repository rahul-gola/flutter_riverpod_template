import 'package:data/entity/local/province_db_entity.dart';
import 'package:data/entity/remote/response/province_response_entity.dart';
import 'package:retrofit/dio.dart';

abstract class ProvinceRemoteRepoDataStore {
  Future<HttpResponse<ProvinceResponseEntity>> getProvinces();
}

abstract class ProvinceLocalRepoDataStore {
  Future<List<ProvinceDBEntity>> getProvinces();

  Future<bool> insertAll(List<ProvinceDBEntity> data);
}
