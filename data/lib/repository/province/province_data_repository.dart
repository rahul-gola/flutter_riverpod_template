import 'package:data/db/utils/safe_db_call.dart';
import 'package:data/entity/local/province_db_entity.dart';
import 'package:data/entity/remote/response/province_response_entity.dart';
import 'package:data/network/utils/safe_api_call.dart';
import 'package:data/source/province/province_repository_datasources.dart';
import 'package:domain/error/database_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/province.dart';
import 'package:domain/repository/provice_data_repository.dart';

import 'package:dartz/dartz.dart';
import 'package:retrofit/retrofit.dart';

class ProvinceDataRepositoryImpl extends ProvinceDataRepository {
  final ProvinceRemoteRepoDataStore _provinceRemoteRepoDataStore;
  final ProvinceLocalRepoDataStore _provinceLocalRepoDataStore;

  ProvinceDataRepositoryImpl(
      this._provinceRemoteRepoDataStore, this._provinceLocalRepoDataStore);

  @override
  Future<Either<NetworkError, List<Province>>> getRemoteProvinceList() async {
    final response = await safeApiCall<HttpResponse<ProvinceResponseEntity>>(
        _provinceRemoteRepoDataStore.getProvinces());

    if (response == null) {
      return Left(NetworkError(message: 'Unknown network error', httpError: 0));
    }

    return response.fold(
        (left) => Left(left), (r) => Right(r.data.transform()));
  }

  @override
  Future<Either<DatabaseError, List<Province>>> saveProvinceList(
      List<Province> data) async {
    final result = await safeDbCall(_provinceLocalRepoDataStore
        .insertAll(data.map((e) => ProvinceDBEntity().restore(e)).toList()));
    return result.fold(
      (l) => Left(l),
      (r) => Right(data),
    );
  }
}
