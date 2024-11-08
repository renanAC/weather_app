import 'package:weather_app/infrastructure/exceptions/api_exceptions.dart';

class AppFailure {
  const AppFailure();
}

class UnknowFailure extends AppFailure {}

class InternetFailure extends AppFailure {}

class ResponseFailure extends AppFailure {
  const ResponseFailure(this.message);
  final String message;
}

class ConnectionFailure extends AppFailure {}

extension AppFailureExtension on AppFailure {
  AppFailure map(Exception ex) {
    if (ex is NoInternetConnectionException) {
      return InternetFailure();
    }

    if (ex is ConnectionTimeoutException ||
        ex is ConnectionTimeoutException ||
        ex is ReceiveTimeoutException ||
        ex is BadCertificateException ||
        ex is CancelException ||
        ex is ConnectionErrorException) {
      return ConnectionFailure();
    }

    if (ex is BadResponseException) {
      return ResponseFailure(ex.message ?? '');
    }

    if (ex is UnknowApiException) {
      return UnknowFailure();
    }

    throw ex;
  }
}
