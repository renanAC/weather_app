import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/infrastructure/api/api_rest.dart';
import 'package:weather_app/infrastructure/api/dio_api.dart';
import 'package:weather_app/infrastructure/services/secrets/secrets.dart';

class InfraProvider extends StatelessWidget {
  const InfraProvider({
    super.key,
    required this.child,
    required this.secrets,
  });
  final Widget child;
  final Secrets secrets;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        RepositoryProvider<Secrets>(
          create: (context) => secrets,
        ),
        RepositoryProvider<Dio>(
          create: (context) => Dio(),
        ),
        RepositoryProvider<ApiRest>(
          create: (context) => DioApi(
            secrets: context.read<Secrets>(),
            dio: context.read<Dio>(),
          ),
        ),
      ],
      child: child,
    );
  }
}
