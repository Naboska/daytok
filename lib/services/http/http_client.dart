import 'package:dio/dio.dart';

class HttpClient {
  HttpClient({required String baseUrl}) {
    _dio.options.baseUrl = baseUrl;

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: _onRequest,
        onError: _onError,
      ),
    );
  }

  final Dio _dio = Dio();

  Dio get instance => _dio;

  void _onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    return handler.next(options);
  }

  void _onError(
    DioException error,
    ErrorInterceptorHandler handler,
  ) async {
    return handler.next(error);
  }
}
