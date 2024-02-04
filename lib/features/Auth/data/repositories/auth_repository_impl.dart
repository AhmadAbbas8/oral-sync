import 'package:dartz/dartz.dart';
import 'package:oralsync/core/error/exception.dart';
import 'package:oralsync/core/error/failure.dart';
import 'package:oralsync/core/network/network_info.dart';
import 'package:oralsync/features/Auth/data/data_sources/auth_remote_data_source.dart';
import 'package:oralsync/features/Auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  final NetworkInfo networkInfo;

  AuthRepositoryImpl(
      {required this.authRemoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, Unit>> login(
      {required String email, required String password}) async {
    if (await networkInfo.isConnected) {
      try {
        await authRemoteDataSource.login(email: email, password: password);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> register(
      {required String fName,
      required String sName,
      required String email,
      required String password,
      required String confirmPassword,
      required String phoneNumber,
      required bool isMale,
      required bool isDoctor,
      required bool isStudent,
      required bool isPatient}) async {
    if (await networkInfo.isConnected) {
      try {
        await authRemoteDataSource.register(
            fName: fName,
            sName: sName,
            email: email,
            password: password,
            confirmPassword: confirmPassword,
            phoneNumber: phoneNumber,
            isMale: isMale,
            isDoctor: isDoctor,
            isStudent: isStudent,
            isPatient: isPatient);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> signUpDoctor(
      {required String fName,
      required String sName,
      required String email,
      required String phone,
      required String dob,
      required bool gender,
      required bool isDoctor,
      required String academicYear,
      required String GPA,
      required String clinicGovernment,
      required String clinicCity,
      required String clinicStreet,
      required String clinicFloor,
      required String other,
      required String password}) async {
    if (await networkInfo.isConnected) {
      try {
        await authRemoteDataSource.signUpDoctor(
            fName: fName,
            sName: sName,
            email: email,
            phone: phone,
            dob: dob,
            gender: gender,
            isDoctor: isDoctor,
            academicYear: academicYear,
            GPA: GPA,
            clinicGovernment: clinicGovernment,
            clinicCity: clinicCity,
            clinicStreet: clinicStreet,
            clinicFloor: clinicFloor,
            other: other,
            password: password);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> signUpPatient(
      {required String fName,
      required String sName,
      required String email,
      required String phone,
      required String dob,
      required bool gender,
      required String government,
      required String city}) async {
    if (await networkInfo.isConnected) {
      try {
        await authRemoteDataSource.signUpPatient(
            fName: fName,
            sName: sName,
            email: email,
            phone: phone,
            dob: dob,
            gender: gender,
            government: government,
            city: city);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> signUpStudent(
      {required String fName,
      required String sName,
      required String email,
      required String phone,
      required String dob,
      required bool gender,
      required bool isDoctor,
      required String academicYear,
      required String GPA,
      required String universityGovernment,
      required String universityCity,
      required String universityStreet,
      required String other,
      required String password}) async {
    if (await networkInfo.isConnected) {
      try {
        await authRemoteDataSource.signUpStudent(
            fName: fName,
            sName: sName,
            email: email,
            phone: phone,
            dob: dob,
            gender: gender,
            isDoctor: isDoctor,
            academicYear: academicYear,
            GPA: GPA,
            universityGovernment: universityGovernment,
            universityCity: universityCity,
            universityStreet: universityStreet,
            other: other,
            password: password);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}