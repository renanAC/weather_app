import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/design_system/components/custom_shimmer.dart';
import 'package:weather_app/design_system/components/inputs/text_input.dart';
import 'package:weather_app/design_system/tokens/tokens_provider.dart';
import 'package:weather_app/design_system/typography/typography_extension.dart';
import 'package:weather_app/features/weather/domain/models/weather_model.dart';
import 'package:weather_app/features/weather/presentation/blocs/weather_cubit.dart';
import 'package:weather_app/features/weather/presentation/blocs/weather_state.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_item.dart';

class WeatherList extends StatefulWidget {
  const WeatherList({super.key, required this.title});
  final String title;

  @override
  State<WeatherList> createState() => _WeatherCarrouselState();
}

class _WeatherCarrouselState extends State<WeatherList> {
  late final WeatherCubit _weathersCubit;
  TextEditingController cityControlleText = TextEditingController();

  @override
  void initState() {
    _weathersCubit = context.read<WeatherCubit>();
    _weathersCubit.getWeather();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WeatherCubit, WeatherState>(
      listener: (context, state) {
        if (state is WeatherErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.error),
          ));
        }
      },
      builder: (context, state) {
        return Expanded(
          child: Padding(
            padding: EdgeInsets.all(context.dimessions.spacers.spacer16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Inputs(),
                SizedBox(
                  height: context.dimessions.spacers.spacer16,
                ),
                Text(
                  widget.title,
                  style: context.typography.title.h2,
                ),
                SizedBox(
                  height: context.dimessions.spacers.spacer16,
                ),
                if (context.read<WeatherCubit>().weathers.isNotEmpty) ...{
                  _WeathersLoaded(
                    onTapItem: (weather) => _editDialog(context, weather),
                  )
                },
                if (state is WeatherLoadingState) ...{_WeathersLoading()},
              ],
            ),
          ),
        );
      },
    );
  }

  Future<dynamic> _editDialog(BuildContext context, WeatherModel weather) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Edit Name"),
        titleTextStyle: context.typography.title.h2.black,
        actions: [
          ElevatedButton(
            onPressed: () {
              context.read<WeatherCubit>().update(weather);
              Navigator.of(context).pop();
              context.read<WeatherCubit>().filterCity = null;
              cityControlleText.text = '';
            },
            child: Text(
              "Save",
              style: context.typography.body.large,
            ),
          ),
        ],
        content: Row(
          children: [
            Expanded(
              child: TextInput(
                hintText: 'Name',
                text: '',
                textChange: (text) =>
                    context.read<WeatherCubit>().filterCity = text,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Inputs extends StatelessWidget {
  _Inputs();

  final TextEditingController inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextInput(
            hintText: 'Track city here',
            text: '',
            textChange: (text) =>
                context.read<WeatherCubit>().filterCity = text,
          ),
        ),
        SizedBox(
          width: context.dimessions.spacers.spacer16,
        ),
        SizedBox(
          height: 60,
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              backgroundColor: context.colors.foreground.primary.white,
            ),
            onPressed: () {
              context.read<WeatherCubit>().save();
              inputController.text = '';
            },
            child: const Text('ADD'),
          ),
        )
      ],
    );
  }
}

class _WeathersLoaded extends StatelessWidget {
  const _WeathersLoaded({
    required this.onTapItem,
  });

  final void Function(WeatherModel weather) onTapItem;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              var weather = context.read<WeatherCubit>().weathers[index];
              return GestureDetector(
                onTap: () => onTapItem(weather),
                child: SizedBox(
                  width: 200,
                  height: 200,
                  child: WeatherItem(
                    image: weather.avatar,
                    semanticLabel: weather.temperature,
                    temperature: weather.temperature,
                    cityName: weather.city,
                    id: weather.id,
                  ),
                ),
              );
            },
            childCount: context.read<WeatherCubit>().weathers.length,
          ),
        )
      ],
    ));
  }
}

class _WeathersLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomShimmer(
        child: ListView.builder(
          itemCount: 3,
          itemBuilder: (context, index) => Column(
            children: [
              const SizedBox(
                width: double.infinity,
                height: 180,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        20,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: context.dimessions.spacers.spacer16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
