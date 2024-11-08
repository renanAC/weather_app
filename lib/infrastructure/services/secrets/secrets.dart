import 'package:weather_app/infrastructure/services/secrets/secrets_enum.dart';

abstract class Secrets {
  String getKey({required SecretsKey keyIdentifier});
  Future<void> init();
}
