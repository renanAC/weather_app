import 'package:weather_app/features/weather/domain/models/weather_model.dart';

abstract class WeatherDataSource {
  Future<List<dynamic>> getCity(String? city);
  Future<dynamic> saveWeather(WeatherModel data);
  Future<void> updateWeather(WeatherModel data);
  Future<void> deleteWeather(String id);
}
