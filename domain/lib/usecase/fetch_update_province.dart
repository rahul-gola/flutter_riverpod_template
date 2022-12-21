import 'package:domain/error/app_error.dart';
import 'package:domain/error/base_error.dart';
import 'package:domain/model/province.dart';
import 'package:domain/repository/provice_data_repository.dart';
import 'package:dartz/dartz.dart';

import 'base/base_usecase.dart';
import 'base/params.dart';

class FetchUpdateProvinceUseCase
    extends BaseUseCase<FetchUpdateProvinceParams, List<Province>> {
  final ProvinceDataRepository _provinceRepository;

  FetchUpdateProvinceUseCase(this._provinceRepository);

  @override
  Future<Either<BaseError, List<Province>>> execute(
      {required FetchUpdateProvinceParams params}) async {
    return Future.value((await _provinceRepository.getRemoteProvinceList())
        .fold((l) => Left(l), (r) {
      return _provinceRepository.saveProvinceList(r);
    }));
  }
}

class FetchUpdateProvinceParams extends Params {
  @override
  Either<AppError, bool> verify() {
    return const Right(true);
  }
}
