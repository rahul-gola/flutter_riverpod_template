import 'package:dartz/dartz.dart';
import 'package:domain/error/database_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/province.dart';

abstract class ProvinceDataRepository {
  Future<Either<NetworkError, List<Province>>> getRemoteProvinceList();

  Future<Either<DatabaseError, List<Province>>> saveProvinceList(
      List<Province> data);
}
