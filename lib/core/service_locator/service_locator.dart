import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:oralsync/core/cache_helper/cache_storage.dart';
import 'package:oralsync/core/cache_helper/shared_prefs_cache.dart';
import 'package:oralsync/core/network/api/api_consumer.dart';
import 'package:oralsync/core/network/api/dio_consumer.dart';
import 'package:oralsync/core/network/network_info.dart';
import 'package:oralsync/core/shared_data_layer/edit_profile_data_layer/edit_profile_remote_data_source.dart';
import 'package:oralsync/core/shared_data_layer/edit_profile_data_layer/edit_repo.dart';
import 'package:oralsync/core/utils/end_points.dart';
import 'package:oralsync/features/Auth/data/data_sources/auth_local_data_source.dart';
import 'package:oralsync/features/Auth/data/data_sources/auth_local_data_source_impl.dart';
import 'package:oralsync/features/Auth/data/data_sources/auth_remote_data_source.dart';
import 'package:oralsync/features/Auth/data/data_sources/auth_remote_data_source_impl.dart';
import 'package:oralsync/features/Auth/data/repositories/auth_repository_impl.dart';
import 'package:oralsync/features/Auth/domain/repositories/auth_repository.dart';
import 'package:oralsync/features/Auth/domain/use_cases/login_use_case.dart';
import 'package:oralsync/features/Auth/domain/use_cases/register_use_case.dart';
import 'package:oralsync/core/shared_data_layer/actions_data_layer/actions_reomte_data_source.dart';
import 'package:oralsync/features/doctor_profile_feature/presentation/manager/doctor_profile_cubit/doctor_profile_cubit.dart';
import 'package:oralsync/features/home_patient_feature/data/data_sources/paid_reservaion_local_data_source.dart';
import 'package:oralsync/features/home_patient_feature/data/data_sources/paid_reservaion_remote_data_source.dart';
import 'package:oralsync/features/home_patient_feature/data/repositories/paid_reservation_repo.dart';
import 'package:oralsync/features/home_patient_feature/presentation/manager/free_paid_reservation_cubit/free_paid_reservation_cubit.dart';
import 'package:oralsync/features/home_patient_feature/presentation/manager/paid_reservation_cubit/paid_reservation_cubit.dart';
import 'package:oralsync/features/home_student_feature/data/data_sources/student_post_local_data_source.dart';
import 'package:oralsync/features/home_student_feature/data/data_sources/sudent_post_remote_data_source.dart';
import 'package:oralsync/features/home_student_feature/data/repositories/student_post_repo_impl.dart';
import 'package:oralsync/core/shared_data_layer/actions_data_layer/actions_repo.dart';
import 'package:oralsync/features/home_student_feature/domain/repositories/student_post_repo.dart';
import 'package:oralsync/features/home_student_feature/domain/use_cases/archive_and_unarchive_post_use_case.dart';
import 'package:oralsync/features/home_student_feature/domain/use_cases/create_post_use_case.dart';
import 'package:oralsync/features/home_student_feature/domain/use_cases/do_comment_use_case.dart';
import 'package:oralsync/features/home_student_feature/domain/use_cases/get_all_posts_archived_use_case.dart';
import 'package:oralsync/features/home_student_feature/domain/use_cases/get_all_posts_use_case.dart';
import 'package:oralsync/features/home_student_feature/domain/use_cases/get_notifications_use_case.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../features/contact_us_feature/contact_us_data_layer/contact_us_data_source.dart';
import '../../features/contact_us_feature/contact_us_data_layer/contact_us_repo.dart';
import '../shared_data_layer/actions_data_layer/actions_repo_impl.dart';

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
    // * BloC/Cubit
    instance.registerLazySingleton<FreePaidReservationCubit>(
        () => FreePaidReservationCubit(
              actionsRepo: instance(),
              doCommentUseCase: instance(),
              studentPostRepo: instance(),
            ));
    instance
        .registerLazySingleton<DoctorProfileCubit>(() => DoctorProfileCubit(instance()));
    instance.registerLazySingleton<PaidReservationCubit>(
      () => PaidReservationCubit(
        reservationRepo: instance(),
      ),
      dispose: (param) async => await param.close(),
    );
    // * Datasources
    instance.registerLazySingleton<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImp(apiConsumer: instance()));
    instance.registerLazySingleton<AuthLocalDataSource>(
        () => AuthLocalDataSourceImpl(cacheStorage: instance()));
    instance.registerLazySingleton<StudentPostRemoteDataSource>(
        () => StudentPostRemoteDataSourceImpl(apiConsumer: instance()));
    instance.registerLazySingleton<StudentPostLocalDataSource>(
        () => StudentPostLocalDataSourceImpl(cacheStorage: instance()));
    instance.registerLazySingleton<EditProfileRemoteDataSource>(
        () => EditProfileRemoteDataSourceIml(apiConsumer: instance()));
    instance.registerLazySingleton<ActionsRemoteDataSource>(
        () => ActionsRemoteDataSourceImpl(apiConsumer: instance()));
    instance.registerLazySingleton<ContactUsDataSource>(
        () => ContactUsDataSourceImpl(apiConsumer: instance()));
    instance.registerLazySingleton<PaidReservationRemoteDataSource>(
        () => PaidReservationRemoteDataSourceImpl(apiConsumer: instance()));
    instance.registerLazySingleton<PaidReservationLocalDataSource>(
        () => PaidReservationLocalDataSourceImpl(cacheStorage: instance()));

    // * Repository
    instance.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
        authRemoteDataSource: instance(),
        networkInfo: instance(),
        authLocalDataSource: instance()));
    instance.registerLazySingleton<StudentPostRepo>(() => StudentPostRepoImpl(
        networkInfo: instance(),
        studentPostRemoteDataSource: instance(),
        studentPostLocalDataSource: instance()));
    instance.registerLazySingleton<EditProfileRepo>(() => EditProfileRepoImpl(
        networkInfo: instance(),
        authLocalDataSource: instance(),
        editProfileRemoteDataSource: instance()));
    instance.registerLazySingleton<ActionsRepo>(() => ActionsRepoImpl(
        networkInfo: instance(), actionsRemoteDataSource: instance()));
    instance.registerLazySingleton<ContactUsRepo>(() =>
        ContactUsRepoImpl(networkInfo: instance(), dataSource: instance()));
    instance.registerLazySingleton<PaidReservationRepo>(
      () => PaidReservationRepoImpl(
          networkInfo: instance(),
          localDataSource: instance(),
          remoteDataSource: instance()),
    );

    // * UseCases

    instance.registerLazySingleton<LoginUseCase>(
        () => LoginUseCase(authRepository: instance()));
    instance.registerLazySingleton<RegisterUseCase>(
        () => RegisterUseCase(authRepository: instance()));
    instance.registerLazySingleton<CreatePostUseCase>(
        () => CreatePostUseCase(studentPostRepo: instance()));
    instance.registerLazySingleton<GetAllPostsStudentUseCase>(
        () => GetAllPostsStudentUseCase(studentPostRepo: instance()));
    instance.registerLazySingleton<GetNotificationsUseCase>(
        () => GetNotificationsUseCase(actionsRepo: instance()));
    instance.registerLazySingleton<DoCommentUseCase>(
        () => DoCommentUseCase(postRepo: instance()));
    instance.registerLazySingleton<ArchiveAndUnArchivePostUseCase>(
        () => ArchiveAndUnArchivePostUseCase(postRepo: instance()));
    instance.registerLazySingleton<GetAllPostsArchivedUseCase>(
        () => GetAllPostsArchivedUseCase(postRepo: instance()));
  }
}
