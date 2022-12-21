import 'package:data/db/floor_db_service.dart';
import 'package:data/di/network_module.dart';
import 'package:data/repository/province/province_data_repository.dart';
import 'package:data/source/province/local/province_local_repository_datasource.dart';
import 'package:data/source/province/province_repository_datasources.dart';
import 'package:data/source/province/remote/province_remote_repository_datasource.dart';
import 'package:domain/repository/provice_data_repository.dart';
import 'package:riverpod/riverpod.dart';

class DatabaseProperties {
  static const String DB_NAME = "appDb.db";
  static const int DB_VERSION = 1; //BuildConfig.DB_VERSION;
}

final floorAppDatabase = Provider<FloorDbService>(
  (ref) => FloorDbService(
    DatabaseProperties.DB_NAME,
  ),
);

final provinceRemoteDataSourceProvider = Provider<ProvinceRemoteRepoDataStore>(
    (ref) =>
        ProvinceRemoteRepositoryDataSourceImpl(ref.read(apiServiceProvider)));

final provinceLocalDataSourceProvider = Provider<ProvinceLocalRepoDataStore>(
    (ref) => ProvinceLocalRepositoryDataSourceImpl(ref.read(floorAppDatabase)));

final provinceDataRepositoryProvider = Provider<ProvinceDataRepository>((ref) =>
    ProvinceDataRepositoryImpl(ref.read(provinceRemoteDataSourceProvider),
        ref.read(provinceLocalDataSourceProvider)));
