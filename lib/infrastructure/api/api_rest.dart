abstract class ApiRest {
  Future<T> post<T>(String endpoint,
      {Map<String, dynamic>? queryParameters, Object? data});
  Future<T> get<T>(String endpoint, {Map<String, dynamic>? queryParameters});
  Future<T> put<T>(String endpoint,
      {Map<String, dynamic>? queryParameters, Object? data});
  Future<T> delete<T>(String endpoint,
      {Map<String, dynamic>? queryParameters, Object? data});
}
