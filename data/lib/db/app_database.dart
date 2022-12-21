import 'dart:async';

import 'package:data/di/data_module.dart';
import 'package:data/entity/local/province_db_entity.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'dao/province_dao.dart';

part 'app_database.g.dart';

@Database(version: DatabaseProperties.DB_VERSION, entities: [ProvinceDBEntity])
abstract class AppDatabase extends FloorDatabase {
  ProvinceDao get provinceDao;
}
