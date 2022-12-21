import 'package:data/db/floor_db_service.dart';
import 'package:data/entity/local/province_db_entity.dart';

import '../province_repository_datasources.dart';

class ProvinceLocalRepositoryDataSourceImpl
    implements ProvinceLocalRepoDataStore {
  final FloorDbService _database;

  ProvinceLocalRepositoryDataSourceImpl(this._database);

  @override
  Future<List<ProvinceDBEntity>> getProvinces() async {
    final database = await _database.db;
    if (database == null) {
      return [];
    }
    return database.provinceDao.getProvinces();
  }

  @override
  Future<bool> insertAll(List<ProvinceDBEntity> list) async {
    final database = await _database.db;
    if (database == null) {
      return false;
    }
    final result = await database.provinceDao.insertDataList(list);
    return result.isNotEmpty;
  }
}
