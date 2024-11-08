import 'package:flutter/material.dart';
import 'package:weather_app/design_system/components/app_bar/app_bar_movie_app.dart';
import 'package:weather_app/design_system/tokens/tokens_provider.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_list.dart';

class Weather extends StatelessWidget {
  const Weather({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.foreground.primary.light,
      appBar: const AppBarWheather(
        title: 'Weather App',
      ),
      body: const Column(
        children: [
          WeatherList(
            title: 'My Cities',
          ),
        ],
      ),
    );
  }
}
