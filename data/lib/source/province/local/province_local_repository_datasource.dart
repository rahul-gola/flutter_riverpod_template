import 'package:data/db/floor_db_service.dart';
import 'package:data/entity/local/province_db_entity.dart';

import 'package:data/source/province/province_repository_datasources.dart';

class ProvinceLocalRepositoryDataSourceImpl
    implements ProvinceLocalRepoDataStore {
  ProvinceLocalRepositoryDataSourceImpl(this._database);
  final FloorDbService _database;

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
