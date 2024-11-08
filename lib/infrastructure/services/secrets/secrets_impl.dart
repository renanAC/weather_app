import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:weather_app/infrastructure/services/secrets/exceptions/secrets_exceptions.dart';
import 'package:weather_app/infrastructure/services/secrets/secrets.dart';
import 'package:weather_app/infrastructure/services/secrets/secrets_enum.dart';

class SecretsImpl implements Secrets {
  SecretsImpl();

  Map<String, dynamic>? secretsFile;
  final String fileLocation = "assets/secrets/secrets.json";

  @override
  getKey({required SecretsKey keyIdentifier}) {
    final secret = secretsFile?[keyIdentifier.value];
    if (secret == null) throw SecretKeyNotFoundException();
    return secret;
  }

  @override
  Future<void> init() async => secretsFile ??= await getSecretsFile();

  Future<Map<String, dynamic>> getSecretsFile() async {
    final secretsFile = await fetchSecrets();
    if (_checkSecretsFileIsEmpty(secretsFile)) {
      throw SecretFileNotFoundException();
    }
    return secretsFile;
  }

  bool _checkSecretsFileIsEmpty(dynamic secretsFile) => secretsFile == null;

  Future<dynamic> fetchSecrets() async =>
      jsonDecode(await rootBundle.loadString(fileLocation));
}
