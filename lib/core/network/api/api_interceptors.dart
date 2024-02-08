import 'package:dio/dio.dart';

class ApiInterceptor extends Interceptor {
  // @override
  // void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
  //
  //   super.onRequest(options, handler);
  // }
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // TODO: implement onError
     handler.reject(err);
    super.onError(err, handler);
  }
  // @override
  // void onResponse(Response response, ResponseInterceptorHandler handler) {
  //   // TODO: implement onResponse
  //   super.onResponse(response, handler);
  // }
}