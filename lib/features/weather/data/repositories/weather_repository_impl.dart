import 'package:weather_app/features/weather/data/data_sources/weather_data_source.dart';
import 'package:weather_app/features/weather/domain/models/weather_model.dart';
import 'package:weather_app/features/weather/domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  WeatherRepositoryImpl(this._weatherDataSource);
  final WeatherDataSource _weatherDataSource;

  @override
  Future<List<WeatherModel>> getCity(String? city) async {
    final response = await _weatherDataSource.getCity(city);
    return response.map((e) => WeatherModel.fromJson(e)).toList();
  }

  @override
  Future<WeatherModel> saveWeather(WeatherModel data) async {
    final result = await _weatherDataSource.saveWeather(data);
    return WeatherModel.fromJson(result);
  }

  @override
  Future<void> updateWeather(WeatherModel data) async =>
      await _weatherDataSource.updateWeather(data);

  @override
  Future<void> deleteWeather(String id) async =>
      await _weatherDataSource.deleteWeather(id);
}
