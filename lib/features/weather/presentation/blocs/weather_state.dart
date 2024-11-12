import 'package:equatable/equatable.dart';

class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object?> get props => [];
}

class WeatherIddleState extends WeatherState {
  const WeatherIddleState();
}

class WeatherLoadingState extends WeatherState {
  const WeatherLoadingState();
}

class WeatherErrorState extends WeatherState {
  const WeatherErrorState(this.error);
  final String error;

  @override
  List<Object?> get props => [error];
}

class WeatherSuccessSaveState extends WeatherState {
  const WeatherSuccessSaveState();
}

class WeatherSuccessDeleteState extends WeatherState {
  const WeatherSuccessDeleteState(this.index);
  final int index;

  @override
  List<Object?> get props => [index];
}

class WeatherSuccessState extends WeatherState {
  const WeatherSuccessState();
}
