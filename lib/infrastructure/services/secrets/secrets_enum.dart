enum SecretsKey { apiKey, apiUrl, apiToken }

extension SecretsKeyExtentsions on SecretsKey {
  String get value => switch (this) {
        SecretsKey.apiKey => 'api_key',
        SecretsKey.apiUrl => 'api_url',
        SecretsKey.apiToken => 'api_token'
      };
}
