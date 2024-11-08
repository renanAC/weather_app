class NoInternetConnectionException implements Exception {}

class ConnectionTimeoutException implements Exception {}

class SendTimeoutException implements Exception {}

class ReceiveTimeoutException implements Exception {}

class BadCertificateException implements Exception {}

class BadResponseException implements Exception {
  const BadResponseException(this.message);
  final String? message;
}

class CancelException implements Exception {}

class ConnectionErrorException implements Exception {}

class UnknowApiException implements Exception {}
