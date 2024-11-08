import 'package:weather_app/features/weather/domain/models/weather_model.dart';

abstract class WeatherRepository {
  Future<List<WeatherModel>> getCity(String? id);
  Future<WeatherModel> saveWeather(WeatherModel data);
  Future<void> updateWeather(WeatherModel data);
  Future<void> deleteWeather(String id);
}
