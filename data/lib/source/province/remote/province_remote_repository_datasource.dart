import 'package:data/entity/remote/response/province_response_entity.dart';
import 'package:data/network/api/api_service.dart';
import 'package:data/source/province/province_repository_datasources.dart';
import 'package:retrofit/retrofit.dart';

class ProvinceRemoteRepositoryDataSourceImpl
    implements ProvinceRemoteRepoDataStore {
  ProvinceRemoteRepositoryDataSourceImpl(this._apiService);
  final ApiService _apiService;

  @override
  Future<HttpResponse<ProvinceResponseEntity>> getProvinces() {
    return _apiService.getProvince();
  }
}
