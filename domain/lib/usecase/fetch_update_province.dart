import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/base_error.dart';
import 'package:domain/model/province.dart';
import 'package:domain/repository/provice_data_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class FetchUpdateProvinceUseCase
    extends BaseUseCase<FetchUpdateProvinceParams, List<Province>> {
  FetchUpdateProvinceUseCase(this._provinceRepository);
  final ProvinceDataRepository _provinceRepository;

  @override
  Future<Either<BaseError, List<Province>>> execute({
    required FetchUpdateProvinceParams params,
  }) async {
    return Future.value(
      (await _provinceRepository.getRemoteProvinceList()).fold(
        Left.new,
        _provinceRepository.saveProvinceList,
      ),
    );
  }
}

class FetchUpdateProvinceParams extends Params {
  @override
  Either<AppError, bool> verify() {
    return const Right(true);
  }
}
