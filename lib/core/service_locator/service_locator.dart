import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:oralsync/core/cache_helper/cache_storage.dart';
import 'package:oralsync/core/cache_helper/shared_prefs_cache.dart';
import 'package:oralsync/core/network/api/api_consumer.dart';
import 'package:oralsync/core/network/api/dio_consumer.dart';
import 'package:oralsync/core/network/network_info.dart';
import 'package:oralsync/core/utils/end_points.dart';
import 'package:oralsync/features/Auth/data/data_sources/auth_local_data_source.dart';
import 'package:oralsync/features/Auth/data/data_sources/auth_local_data_source_impl.dart';
import 'package:oralsync/features/Auth/data/data_sources/auth_remote_data_source.dart';
import 'package:oralsync/features/Auth/data/data_sources/auth_remote_data_source_impl.dart';
import 'package:oralsync/features/Auth/data/repositories/auth_repository_impl.dart';
import 'package:oralsync/features/Auth/domain/repositories/auth_repository.dart';
import 'package:oralsync/features/Auth/domain/use_cases/login_use_case.dart';
import 'package:oralsync/features/Auth/domain/use_cases/new_register_use_case.dart';
import 'package:oralsync/features/home_student_feature/data/data_sources/sudent_post_remote_data_source.dart';
import 'package:oralsync/features/home_student_feature/data/repositories/student_post_repo_impl.dart';
import 'package:oralsync/features/home_student_feature/domain/repositories/student_post_repo.dart';
import 'package:oralsync/features/home_student_feature/domain/use_cases/create_post_use_case.dart';

import 'package:shared_preferences/shared_preferences.dart';

class ServiceLocator {
  ServiceLocator._();

  static final instance = GetIt.instance;

  static Future<void> setup() async {
    // * Core
    final prefs = await SharedPreferences.getInstance();
    instance.registerLazySingleton<CacheStorage>(() => SharedPrefsCache(prefs));
    instance.registerLazySingleton<ImagePicker>(() => ImagePicker());

    instance.registerLazySingleton<NetworkInfo>(
        () => NetWorkInfoImpl(InternetConnectionChecker.createInstance()));
    instance.registerLazySingleton<ApiConsumer>(() => DioConsumer(
            dio: Dio(BaseOptions(
          baseUrl: EndPoints.BASE_URL,
          validateStatus: (status) => true,
          headers: {
            'Content-Type': 'application/json',
          },
        ))));

    // * Datasources
    instance.registerLazySingleton<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImp(apiConsumer: instance()));
    instance.registerLazySingleton<AuthLocalDataSource>(
        () => AuthLocalDataSourceImpl(cacheStorage: instance()));
    instance.registerLazySingleton<StudentPostRemoteDataSource>(
        () => StudentPostRemoteDataSourceImpl(apiConsumer: instance()));

    // * Repository
    instance.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
        authRemoteDataSource: instance(),
        networkInfo: instance(),
        authLocalDataSource: instance()));
    instance.registerLazySingleton<StudentPostRepo>(() => StudentPostRepoImpl(
        networkInfo: instance(), studentPostRemoteDataSource: instance()));

    // * UseCases

    instance.registerLazySingleton<LoginUseCase>(
        () => LoginUseCase(authRepository: instance()));
    instance.registerLazySingleton<NewRegisterUseCase>(
        () => NewRegisterUseCase(authRepository: instance()));
    instance.registerLazySingleton<CreatePostUseCase>(
        () => CreatePostUseCase(studentPostRepo: instance()));
  }
}
