import 'package:equatable/equatable.dart';

class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object?> get props => [];
}

class WeatherIddleState extends WeatherState {}

class WeatherLoadingState extends WeatherState {}

class WeatherErrorState extends WeatherState {
  const WeatherErrorState(this.error);
  final String error;

  @override
  List<Object?> get props => [error];
}

class WeatherSuccessState extends WeatherState {}
