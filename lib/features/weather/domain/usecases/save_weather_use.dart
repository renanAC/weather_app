import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:weather_app/features/weather/domain/models/weather_model.dart';
import 'package:weather_app/features/weather/domain/repositories/weather_repository.dart';
import 'package:weather_app/infrastructure/base/failure/app_failure.dart';
import 'package:weather_app/infrastructure/base/use_case_base.dart';

class SaveWeatherUseCase extends UseCaseBase<WeatherModel, SaveParams> {
  SaveWeatherUseCase(this._moviesRepository);

  final WeatherRepository _moviesRepository;
  Random random = Random();

  @override
  Future<Either<AppFailure, Success<WeatherModel>>> call(params) async {
    try {
      final model = _makeWetherModel(
        params.city,
        params.id,
      );
      final result = await _moviesRepository.saveWeather(model);
      return success(result);
    } on Exception catch (ex) {
      return failed(const AppFailure().map(ex));
    } catch (ex) {
      return failed(UnknowFailure());
    }
  }

  WeatherModel _makeWetherModel(String city, String id) {
    return WeatherModel(
      avatar: 'https://openweathermap.org/img/wn/10d@2x.png',
      createdAt: DateTime.now().toString(),
      city: city,
      temperature: random.nextInt(45).toString(),
      description: 'description',
      id: id,
    );
  }
}

class SaveParams {
  const SaveParams(this.id, this.city);

  final String id;
  final String city;
}
