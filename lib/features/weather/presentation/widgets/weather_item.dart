import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/design_system/components/custom_shimmer.dart';
import 'package:weather_app/design_system/tokens/tokens_provider.dart';
import 'package:weather_app/features/weather/presentation/blocs/weather_cubit.dart';

class WeatherItem extends StatelessWidget {
  const WeatherItem({
    super.key,
    required this.image,
    required this.semanticLabel,
    required this.temperature,
    required this.cityName,
    required this.id,
  });

  final String image;
  final String semanticLabel;
  final String temperature;
  final String cityName;
  final String id;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(id),
      confirmDismiss: (_) async {
        return await context.read<WeatherCubit>().delete(id);
      },
      onDismissed: (_) => context.read<WeatherCubit>().removeItem(id),
      direction: DismissDirection.endToStart,
      background: DecoratedBox(
        decoration: BoxDecoration(
          color: context.colors.alert.error,
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(right: context.dimessions.spacers.spacer16),
          child: Align(
            alignment: Alignment.centerRight,
            child: Icon(
              Icons.delete,
              color: context.colors.foreground.primary.dark,
              size: 45.0,
            ),
          ),
        ),
      ),
      child: _CardWidget(
        temperature: temperature,
        cityName: cityName,
      ),
    );
  }
}

class _CardWidget extends StatelessWidget {
  const _CardWidget({
    required this.temperature,
    required this.cityName,
  });

  final String temperature;
  final String cityName;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: context.colors.foreground.primary.white,
      child: Padding(
        padding: EdgeInsets.all(context.dimessions.spacers.spacer16),
        child: Row(children: [
          SizedBox(
            width: 150,
            height: 150,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: context.colors.foreground.primary.medium,
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: CachedNetworkImage(
                imageUrl: "https://openweathermap.org/img/wn/10d@2x.png",
                placeholder: (context, url) => CustomShimmer(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: context.colors.foreground.primary.medium,
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$temperature°C',
                  style: context.typography.title.h1,
                ),
                Text(
                  cityName,
                  style: context.typography.title.h2,
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
