import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:oralsync/core/cache_helper/cache_storage.dart';
import 'package:oralsync/core/cache_helper/shared_prefs_keys.dart';
import 'package:oralsync/core/routing/app_router.dart';
import 'package:oralsync/core/service_locator/service_locator.dart';
import 'package:oralsync/features/Auth/presentation/pages/login_page.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log('${ServiceLocator.instance<CacheStorage>().getData(key: SharedPrefsKeys.token)}',name: 'token');
    options.headers['Authorization'] =
        'Bearer ${ServiceLocator.instance<CacheStorage>().getData(key: SharedPrefsKeys.token)}';
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    log('--------------------onError--------------------------------');
    if (err.response?.statusCode == 401) {
      log('UnAuth', name: 'Interceptor');
      AppRouter.navigatorKey.currentState
          ?.pushNamedAndRemoveUntil(LoginPage.routeName, (route) => false);
    }
    super.onError(err, handler);
  }

  @override
  Future<void> onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    log('---------------------onResponse-------------------------------');
    if (response.statusCode == 401) {
      log('UnAuth', name: 'Interceptor');
      await ServiceLocator.instance<CacheStorage>().removeAllData();
      AppRouter.navigatorKey.currentState
          ?.pushNamedAndRemoveUntil(LoginPage.routeName, (route) => false);
    }
    super.onResponse(response, handler);
  }
}
