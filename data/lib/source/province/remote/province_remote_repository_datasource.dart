import 'package:data/entity/remote/response/province_response_entity.dart';
import 'package:data/network/api/api_service.dart';
import 'package:retrofit/retrofit.dart';

import '../province_repository_datasources.dart';

class ProvinceRemoteRepositoryDataSourceImpl
    implements ProvinceRemoteRepoDataStore {
  final ApiService _apiService;

  ProvinceRemoteRepositoryDataSourceImpl(this._apiService);

  @override
  Future<HttpResponse<ProvinceResponseEntity>> getProvinces() {
    return _apiService.getProvince();
  }
}
