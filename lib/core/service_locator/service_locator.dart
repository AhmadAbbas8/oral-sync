import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:oralsync/core/cache_helper/cache_storage.dart';
import 'package:oralsync/core/cache_helper/shared_prefs_cache.dart';
import 'package:oralsync/core/network/api/api_consumer.dart';
import 'package:oralsync/core/network/api/dio_consumer.dart';
import 'package:oralsync/core/network/network_info.dart';
import 'package:oralsync/core/utils/end_points.dart';
import 'package:oralsync/features/Auth/data/data_sources/auth_remote_data_source.dart';
import 'package:oralsync/features/Auth/data/data_sources/auth_remote_data_source_impl.dart';
import 'package:oralsync/features/Auth/data/repositories/auth_repository_impl.dart';
import 'package:oralsync/features/Auth/domain/repositories/auth_repository.dart';
import 'package:oralsync/features/Auth/domain/use_cases/login_use_case.dart';
import 'package:oralsync/features/Auth/domain/use_cases/register_use_case.dart';
import 'package:oralsync/features/Auth/domain/use_cases/sign_up_doctor_use_case.dart';
import 'package:oralsync/features/Auth/domain/use_cases/sign_up_patient_use_case.dart';
import 'package:oralsync/features/Auth/domain/use_cases/sign_up_student_use_case.dart';
import 'package:oralsync/features/Auth/presentation/pages/sign_up_patient_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ServiceLocator {
  ServiceLocator._();

  static final instance = GetIt.instance;

  static Future<void> setup() async {
    // * Core
    final prefs = await SharedPreferences.getInstance();
    instance.registerLazySingleton<CacheStorage>(() => SharedPrefsCache(prefs));

    instance.registerLazySingleton<NetworkInfo>(
        () => NetWorkInfoImpl(InternetConnectionChecker.createInstance()));
    instance.registerFactory<ApiConsumer>(() => DioConsumer(
            dio: Dio(BaseOptions(
                baseUrl: EndPoints.BASE_URL,
                validateStatus: (status) => true,
                headers: {
              'Content-Type': 'application/json',
            },))));
    // instance.registerLazySingleton(
    //   () => Dio(
    //     BaseOptions(
    //       validateStatus: (status) => status == 200,
    //       baseUrl: EndPoints.BASE_URL,
    //       headers: const {
    //         'accept': '*/*',
    //         'Content-Type': 'application/json',
    //       },
    //     ),
    //   ),
    // );
    // * Datasources
    instance.registerLazySingleton<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImp(apiConsumer: instance()));

    // * Repository
    instance.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
        authRemoteDataSource: instance(), networkInfo: instance()));

    // * UseCases
    instance.registerLazySingleton<LoginUseCase>(
        () => LoginUseCase(authRepository: instance()));
    instance.registerLazySingleton<RegisterUseCase>(
        () => RegisterUseCase(authRepository: instance()));
    instance.registerLazySingleton<SignUpDoctorUseCase>(
        () => SignUpDoctorUseCase(authRepository: instance()));
    instance.registerLazySingleton<SignUpPatientUseCase>(
        () => SignUpPatientUseCase(authRepository: instance()));
    instance.registerLazySingleton<SignUpStudentUseCase>(
        () => SignUpStudentUseCase(authRepository: instance()));
  }
}
