import 'package:dio/dio.dart';

class DioInterceptorManager {
  Dio? _dio;
  InterceptorsWrapper? _interceptors;

  Dio get dioInstance {
    if (_dio == null) {
      _dio = Dio();
      _dio!.interceptors.add(interceptors);
    }
    return _dio!;
  }

  InterceptorsWrapper get interceptors {
    _interceptors = InterceptorsWrapper(
      onError: (DioException e, ErrorInterceptorHandler handler) {
        if (e.response?.statusCode == 201) {
          return handler.next(e);
        }
        return handler.resolve(e.response!);
      },
      onResponse: (response, handler) {
        return handler.next(response);
      },
    );
    return _interceptors!;
  }
}
