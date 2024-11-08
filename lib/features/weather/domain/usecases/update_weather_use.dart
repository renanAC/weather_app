import 'package:dartz/dartz.dart';
import 'package:weather_app/features/weather/domain/models/weather_model.dart';
import 'package:weather_app/features/weather/domain/repositories/weather_repository.dart';
import 'package:weather_app/infrastructure/base/failure/app_failure.dart';
import 'package:weather_app/infrastructure/base/use_case_base.dart';

class UpdateWeatherUseCase extends UseCaseBase<void, WeatherModel> {
  UpdateWeatherUseCase(this._moviesRepository);

  final WeatherRepository _moviesRepository;

  @override
  Future<Either<AppFailure, Success<void>>> call(params) async {
    try {
      await _moviesRepository.updateWeather(params);
      return success(null);
    } on Exception catch (ex) {
      return failed(const AppFailure().map(ex));
    } catch (ex) {
      return failed(UnknowFailure());
    }
  }
}
