import 'package:dartz/dartz.dart';
import 'package:domain/error/database_error.dart';

Future<Either<DatabaseError, T>> safeDbCall<T>(Future<T> dbCall) async {
  try {
    final originalResponse = await dbCall;
    return Right(originalResponse);
  } catch (throwable) {
    return Left(
      DatabaseError(
        message: throwable.toString(),
      ),
    );
  }
}
