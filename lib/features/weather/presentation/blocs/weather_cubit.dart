import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/weather/domain/models/weather_model.dart';
import 'package:weather_app/features/weather/domain/usecases/delete_weather_use.dart';
import 'package:weather_app/features/weather/domain/usecases/save_weather_use.dart';
import 'package:weather_app/features/weather/domain/usecases/update_weather_use.dart';
import 'package:weather_app/features/weather/domain/usecases/weather_use_case.dart';
import 'package:weather_app/features/weather/presentation/blocs/weather_state.dart';
import 'package:weather_app/infrastructure/base/failure/app_failure.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit(
    this._useCaseWeather,
    this._deleteWeatherUseCase,
    this._updateWeatherUseCase,
    this._saveWeatherUseCase,
  ) : super(WeatherIddleState());
  final WeatherUseCase _useCaseWeather;
  final DeleteWeatherUseCase _deleteWeatherUseCase;
  final UpdateWeatherUseCase _updateWeatherUseCase;
  final SaveWeatherUseCase _saveWeatherUseCase;

  String? _filterCity;
  String? get filterCity => _filterCity;
  set filterCity(String? value) =>
      value?.isNotEmpty ?? false ? _filterCity = value : null;

  List<WeatherModel> weathers = [];

  Future<void> getWeather() async {
    emit(WeatherLoadingState());
    var responseWeather = await _useCaseWeather.call(filterCity);
    responseWeather.fold(
      (failure) => _resolveFailue(failure, 'Request Error:'),
      (success) {
        weathers = success.result.reversed.toList();
        emit(WeatherSuccessState());
      },
    );
  }

  Future<bool> delete(String id) async {
    emit(WeatherIddleState());
    var success = false;
    var responseWeather = await _deleteWeatherUseCase.call(id);
    responseWeather.fold(
      (failure) => _resolveFailue(failure, 'Delete Error:'),
      (_) => success = true,
    );
    return success;
  }

  Future<void> save() async {
    emit(WeatherIddleState());

    final saveParams = SaveParams(_getId, filterCity ?? '');
    final responseWeather = await _saveWeatherUseCase.call(saveParams);

    responseWeather.fold(
      (failure) => _resolveFailue(failure, 'Save Error:'),
      (success) {
        weathers.insert(0, success.result);
        emit(WeatherSuccessState());
      },
    );

    filterCity = null;
  }

  String get _getId => (int.parse(weathers.first.id) + 1).toString();

  Future<void> update(WeatherModel weather) async {
    final updateWether = weather.copyWith(city: filterCity);
    final responseWeather = await _updateWeatherUseCase.call(updateWether);

    responseWeather.fold(
      (failure) => _resolveFailue(failure, 'Update Error:'),
      (_) => _updateItem(updateWether),
    );
  }

  void _updateItem(WeatherModel weather) {
    emit(WeatherIddleState());
    final index = weathers.indexWhere((e) => e.id == weather.id);
    weathers[index] = weather;
    emit(WeatherSuccessState());
  }

  _resolveFailue(AppFailure failure, String customReturn) {
    if (failure is InternetFailure) {
      emit(const WeatherErrorState('Internet Error!!'));
      return;
    }
    if (failure is ResponseFailure) {
      emit(WeatherErrorState('$customReturn ${failure.message}'));
      return;
    }

    emit(const WeatherErrorState('Generic Erro!!'));
  }

  void removeItem(String id) {
    emit(WeatherIddleState());
    weathers.removeWhere((e) => e.id == id);
    emit(WeatherSuccessState());
  }
}
