import 'package:dartz/dartz.dart';
import 'package:weather_app/features/weather/domain/models/weather_model.dart';
import 'package:weather_app/features/weather/domain/repositories/weather_repository.dart';
import 'package:weather_app/infrastructure/base/failure/app_failure.dart';
import 'package:weather_app/infrastructure/base/use_case_base.dart';

class WeatherUseCase extends UseCaseBase<List<WeatherModel>, String?> {
  WeatherUseCase(this._moviesRepository);

  final WeatherRepository _moviesRepository;

  @override
  Future<Either<AppFailure, Success<List<WeatherModel>>>> call(params) async {
    try {
      return success(await _moviesRepository.getCity(params));
    } on Exception catch (ex) {
      return failed(const AppFailure().map(ex));
    } catch (ex) {
      return failed(UnknowFailure());
    }
  }
}
