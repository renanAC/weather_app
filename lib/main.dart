import 'dart:async';

import 'package:flutter/material.dart';
import 'package:weather_app/design_system/tokens/tokens_provider.dart';
import 'package:weather_app/features/weather/presentation/Weather.dart';
import 'package:weather_app/features/weather/presentation/providers/weather_provider.dart';
import 'package:weather_app/infrastructure/provider/infra_provider.dart';
import 'package:weather_app/infrastructure/services/secrets/secrets.dart';
import 'package:weather_app/infrastructure/services/secrets/secrets_impl.dart';

void main() {
  final Secrets secrets = SecretsImpl();

  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await secrets.init();
    runApp(MyApp(secrets: secrets));
  }, (_, __) {});
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.secrets});
  final Secrets secrets;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return TokensProvider(
      child: InfraProvider(
        secrets: secrets,
        child: const WeatherProvider(
          child: MaterialApp(
            title: 'Wheater',
            home: Weather(),
          ),
        ),
      ),
    );
  }
}
