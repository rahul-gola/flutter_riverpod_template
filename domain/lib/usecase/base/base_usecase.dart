import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:domain/error/base_error.dart';

import 'params.dart';

abstract class BaseUseCase<P extends Params, T> {
  Future<Either<BaseError, T>> execute({required P params});
}
