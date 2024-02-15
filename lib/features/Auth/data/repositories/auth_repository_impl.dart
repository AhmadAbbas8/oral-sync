import 'package:dartz/dartz.dart';
import 'package:oralsync/core/error/exception.dart';
import 'package:oralsync/core/error/failure.dart';
import 'package:oralsync/core/network/network_info.dart';
import 'package:oralsync/features/Auth/data/data_sources/auth_local_data_source.dart';
import 'package:oralsync/features/Auth/data/data_sources/auth_remote_data_source.dart';
import 'package:oralsync/features/Auth/data/models/register_body_model.dart';
import 'package:oralsync/features/Auth/data/models/user_model.dart';

import 'package:oralsync/features/Auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final AuthLocalDataSource authLocalDataSource;

  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    required this.authRemoteDataSource,
    required this.networkInfo,
    required this.authLocalDataSource,
  });

  @override
  Future<Either<Failure, UserModel>> login({
    required String email,
    required String password,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        var user =
            await authRemoteDataSource.login(email: email, password: password);
        await authLocalDataSource.cacheToken(token: user.token ?? '');
        await authLocalDataSource.cacheUser(userModel: user);

        return Right(user);
      } on ServerException catch (e) {
        return Left(ServerFailure(errorModel: e.errorModel));
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, RegisterBodyModel>> newRegister({
    required String email,
    required String password,
    required String confirmPassword,
    required bool isMale,
    required String phoneNumber,
    required bool isDoctor,
    required bool isStudent,
    required bool isPatient,
    required String fName,
    required String lName,
    String? universityName,
    List<String>? clinicAddress,
    List<String>? insuranceCompanies,
    List<String>? certificates,
    String? clinicNumber,
    double? gpa,
    String? birthDate,
    String? graduationDate,
    List<String>? address,
    String? insuranceCompany,
    List<String>? universitAddress,
    int? academicYear,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        var model = await authRemoteDataSource.newRegister(
          email: email,
          password: password,
          confirmPassword: confirmPassword,
          isMale: isMale,
          phoneNumber: phoneNumber,
          isDoctor: isDoctor,
          isStudent: isStudent,
          isPatient: isPatient,
          fName: fName,
          lName: lName,
          universityName: universityName,
          academicYear: academicYear,
          address: address,
          birthDate: birthDate,
          certificates: certificates,
          clinicAddress: clinicAddress,
          clinicNumber: clinicNumber,
          gpa: gpa,
          graduationDate: graduationDate,
          insuranceCompanies: insuranceCompanies,
          insuranceCompany: insuranceCompany,
          universitAddress: universitAddress,
        );

        return Right(model);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
