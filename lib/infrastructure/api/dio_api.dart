import 'dart:io';

import 'package:dio/dio.dart';
import 'package:weather_app/infrastructure/api/api_rest.dart';
import 'package:weather_app/infrastructure/exceptions/api_exceptions.dart';
import 'package:weather_app/infrastructure/services/secrets/secrets.dart';
import 'package:weather_app/infrastructure/services/secrets/secrets_enum.dart';

class DioApi implements ApiRest {
  DioApi({required this.secrets, required this.dio}) {
    initDio();
  }

  final Dio dio;
  final Secrets secrets;

  void initDio() {
    final String apiUrl = secrets.getKey(keyIdentifier: SecretsKey.apiUrl);

    dio.options.baseUrl = apiUrl;
    dio.options.connectTimeout = const Duration(seconds: 5);
    dio.options.receiveTimeout = const Duration(seconds: 3);
  }

  @override
  Future<T> delete<T>(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    Object? data,
  }) async {
    try {
      await _hasNetwork();
      final Response response = await dio.delete(
        endpoint,
        queryParameters: queryParameters,
        data: data,
      );
      return response.data;
    } on DioException catch (e) {
      throw e.handleError();
    } catch (_) {
      throw UnknowApiException();
    }
  }

  @override
  Future<T> get<T>(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      await _hasNetwork();
      final Response response =
          await dio.get(endpoint, queryParameters: queryParameters);
      return response.data;
    } on DioException catch (e) {
      throw e.handleError();
    } catch (_) {
      throw UnknowApiException();
    }
  }

  @override
  Future<T> post<T>(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    Object? data,
  }) async {
    await _hasNetwork();
    try {
      final Response response = await dio.post(
        endpoint,
        queryParameters: queryParameters,
        data: data,
      );
      return response.data;
    } on DioException catch (e) {
      throw e.handleError();
    } catch (_) {
      throw UnknowApiException();
    }
  }

  @override
  Future<T> put<T>(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    Object? data,
  }) async {
    await _hasNetwork();
    try {
      final Response response = await dio.get(
        endpoint,
        queryParameters: queryParameters,
        data: data,
      );
      return response.data;
    } on DioException catch (e) {
      throw e.handleError();
    } catch (_) {
      throw UnknowApiException();
    }
  }

  Future<void> _hasNetwork() async {
    try {
      await InternetAddress.lookup('www.google.com');
    } on SocketException catch (_) {
      throw NoInternetConnectionException();
    }
  }
}

extension DioExceptionExtension on DioException {
  Exception handleError() {
    switch (type) {
      case DioExceptionType.connectionTimeout:
        return ConnectionTimeoutException();
      case DioExceptionType.sendTimeout:
        return SendTimeoutException();
      case DioExceptionType.receiveTimeout:
        return ReceiveTimeoutException();
      case DioExceptionType.badCertificate:
        return BadCertificateException();
      case DioExceptionType.badResponse:
        return BadResponseException(response?.statusMessage ?? '');
      case DioExceptionType.cancel:
        return CancelException();
      case DioExceptionType.connectionError:
        return ConnectionErrorException();
      case DioExceptionType.unknown:
        return UnknowApiException();
    }
  }
}
