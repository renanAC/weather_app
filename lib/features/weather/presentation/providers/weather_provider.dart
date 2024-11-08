import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/weather/data/data_sources/weather_data_source.dart';
import 'package:weather_app/features/weather/data/data_sources/weather_data_source_impl.dart';
import 'package:weather_app/features/weather/data/repositories/weather_repository_impl.dart';
import 'package:weather_app/features/weather/domain/repositories/weather_repository.dart';
import 'package:weather_app/features/weather/domain/usecases/delete_weather_use.dart';
import 'package:weather_app/features/weather/domain/usecases/save_weather_use.dart';
import 'package:weather_app/features/weather/domain/usecases/update_weather_use.dart';
import 'package:weather_app/features/weather/domain/usecases/weather_use_case.dart';
import 'package:weather_app/features/weather/presentation/blocs/weather_cubit.dart';
import 'package:weather_app/infrastructure/api/api_rest.dart';

class WeatherProvider extends StatelessWidget {
  const WeatherProvider({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        RepositoryProvider<WeatherDataSource>(
          create: (context) => WeatherDataSourceImpl(context.read<ApiRest>()),
        ),
        RepositoryProvider<WeatherRepository>(
          create: (context) =>
              WeatherRepositoryImpl(context.read<WeatherDataSource>()),
        ),
        RepositoryProvider<WeatherUseCase>(
          create: (context) =>
              WeatherUseCase(context.read<WeatherRepository>()),
        ),
        RepositoryProvider<DeleteWeatherUseCase>(
          create: (context) =>
              DeleteWeatherUseCase(context.read<WeatherRepository>()),
        ),
        RepositoryProvider<UpdateWeatherUseCase>(
          create: (context) =>
              UpdateWeatherUseCase(context.read<WeatherRepository>()),
        ),
        RepositoryProvider<SaveWeatherUseCase>(
          create: (context) =>
              SaveWeatherUseCase(context.read<WeatherRepository>()),
        ),
        BlocProvider<WeatherCubit>(
          create: (context) => WeatherCubit(
            context.read<WeatherUseCase>(),
            context.read<DeleteWeatherUseCase>(),
            context.read<UpdateWeatherUseCase>(),
            context.read<SaveWeatherUseCase>(),
          ),
        ),
      ],
      child: child,
    );
  }
}
