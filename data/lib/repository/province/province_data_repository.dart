import 'package:dartz/dartz.dart';
import 'package:data/utils/safe_db_call.dart';
import 'package:data/entity/local/province_db_entity.dart';
import 'package:data/entity/remote/response/province_response_entity.dart';
import 'package:data/source/province/province_repository_datasources.dart';
import 'package:data/utils/safe_api_call.dart';
import 'package:domain/error/database_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/province.dart';
import 'package:domain/repository/provice_data_repository.dart';
import 'package:retrofit/retrofit.dart';

class ProvinceDataRepositoryImpl extends ProvinceDataRepository {
  ProvinceDataRepositoryImpl(
    this._provinceRemoteRepoDataStore,
    this._provinceLocalRepoDataStore,
  );
  final ProvinceRemoteRepoDataStore _provinceRemoteRepoDataStore;
  final ProvinceLocalRepoDataStore _provinceLocalRepoDataStore;

  @override
  Future<Either<NetworkError, List<Province>>> getRemoteProvinceList() async {
    final response = await safeApiCall<HttpResponse<ProvinceResponseEntity>>(
      _provinceRemoteRepoDataStore.getProvinces(),
    );

    return response.fold(
      Left.new,
      (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<DatabaseError, List<Province>>> saveProvinceList(
    List<Province> data,
  ) async {
    final result = await safeDbCall(
      _provinceLocalRepoDataStore.insertAll(
        data.map((e) => ProvinceDBEntity().restore(e)).toList(),
      ),
    );
    return result.fold(
      Left.new,
      (r) => Right(data),
    );
  }
}
