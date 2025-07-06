import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/base_error.dart';
import 'package:domain/model/province.dart';
import 'package:domain/repository/provice_data_repository.dart';

import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class FetchProvinceUseCase
    extends BaseUseCase<FetchProvinceParams, List<Province>> {
  FetchProvinceUseCase(this._provinceRepository);
  final ProvinceDataRepository _provinceRepository;

  @override
  Future<Either<BaseError, List<Province>>> execute({
    required FetchProvinceParams params,
  }) async {
    return Future.value(
      (await _provinceRepository.getRemoteProvinceList()).fold(
        Left.new,
        Right.new,
      ),
    );
  }
}

class FetchProvinceParams extends Params {
  @override
  Either<AppError, bool> verify() {
    return const Right(true);
  }
}
