import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/infrastructure/base/failure/app_failure.dart';

abstract class UseCaseBase<Result, Params> {
  Future<Either<AppFailure, Success<Result>>> call(Params params);

  Either<AppFailure, Success<Result>> success(Result result) =>
      Right(Success<Result>(result: result));
  Either<AppFailure, Success<Result>> failed(AppFailure failure) =>
      Left(failure);
}

class Success<T> extends Equatable {
  const Success({
    required this.result,
  });
  final T result;

  @override
  List<Object?> get props => [result];
}
