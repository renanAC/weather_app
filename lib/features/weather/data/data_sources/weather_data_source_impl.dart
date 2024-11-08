import 'package:weather_app/features/weather/data/data_sources/weather_data_source.dart';
import 'package:weather_app/features/weather/domain/models/weather_model.dart';
import 'package:weather_app/infrastructure/api/api_rest.dart';

class WeatherDataSourceImpl implements WeatherDataSource {
  WeatherDataSourceImpl(this._apiRest);
  final ApiRest _apiRest;
  final String _getCityEndPoint = 'city';
  final String _deleteCityEndPoint = 'city';
  final String _updateCityEndPoint = 'city';
  final String _saveCityEndPoint = 'city';

  @override
  Future<List<dynamic>> getCity(String? id) async => await _apiRest.get(
        '$_getCityEndPoint${id != null ? '/$id' : ''}',
      );

  @override
  Future<void> deleteWeather(String id) async =>
      await _apiRest.delete('$_deleteCityEndPoint/$id');

  @override
  Future<dynamic> saveWeather(WeatherModel data) async =>
      await _apiRest.post(_saveCityEndPoint, data: data.toJson());

  @override
  Future<void> updateWeather(WeatherModel data) async => await _apiRest
      .put('$_updateCityEndPoint/${data.id}', data: data.toJson());
}
