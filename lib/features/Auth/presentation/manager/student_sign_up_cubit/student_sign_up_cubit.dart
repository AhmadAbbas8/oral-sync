import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:oralsync/core/error/error_model.dart';
import 'package:oralsync/core/helpers/custom_date_pickers.dart';
import 'package:oralsync/features/Auth/data/models/user_model.dart';
import 'package:oralsync/features/Auth/domain/use_cases/login_use_case.dart';
import 'package:oralsync/features/Auth/domain/use_cases/new_register_use_case.dart';

import 'package:intl/intl.dart';

import '../../../../../core/error/failure.dart';

part 'student_sign_up_state.dart';

class StudentSignUpCubit extends Cubit<StudentSignUpState> {
  StudentSignUpCubit({
    required this.newRegisterUseCase,
    required this.loginUseCase,
  }) : super(StudentSignUpInitial());
  final NewRegisterUseCase newRegisterUseCase;

  final LoginUseCase loginUseCase;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool? isMale;
  bool obscurePassword = true;

  toggleVisibilityPassword() {
    obscurePassword = !obscurePassword;
    emit(ChangePasswordVisibility(obscurePassword: obscurePassword));
  }

  onChangedGender(bool? value) {
    isMale = value;
    emit(GenderChangedState(isMale: isMale!));
  }
  void register() async {
    emit(RegisterStudentLoading());
    var res = await newRegisterUseCase.call(
      email: emailController.text,
      password: passwordController.text,
      confirmPassword: passwordController.text,
      isMale: isMale ?? true,
      phoneNumber: phoneController.text,
      isDoctor: false,
      isStudent: true,
      isPatient: false,
      fName: fNameController.text,
      lName: sNameController.text,
universityName: universityNameController.text,
      gpa:double.tryParse( GPAController.text),
      academicYear:int.tryParse( academicYearController.text),
      graduationDate: gradDateController.text,

      birthDate: dateOfBirthController.text,
    );

    res.fold((failure) {
      if (failure is OfflineFailure) {
        emit(RegisterStudentError(
            errorModel: ResponseModel(
                messageEn: 'Please Check your internet Connection',
                messageAr: 'من فضلك افحص اتصال الانترنت لديك')));
      }
      emit(RegisterStudentError(
          errorModel: ResponseModel(
              messageEn: 'User registered already',
              messageAr: 'هذا المستخدم مسجل بالفعل')));
    }, (model) async {
      if (model.flag ?? false) {
        await login();
      } else {
        emit(RegisterStudentError(
            errorModel: ResponseModel(
                messageEn: 'User registered already',
                messageAr: 'هذا المستخدم مسجل بالفعل')));
      }
    });
  }

  Future<void> login() async {
    var user = await loginUseCase.call(
        email: emailController.text, password: passwordController.text);
    user.fold((failure) {
      if (failure is ServerFailure) {
        emit(RegisterStudentError(errorModel: failure.errorModel));
      } else {
        emit(RegisterStudentError(
            errorModel: ResponseModel(
                messageEn: 'Please Check your internet Connection',
                messageAr: 'من فضلك افحص اتصال الانترنت لديك')));
      }
    }, (user) {
      emit(RegisterStudentSuccess(model: user));
    });
  }

  final TextEditingController fNameController = TextEditingController();
  final TextEditingController sNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();
  final TextEditingController gradDateController = TextEditingController();
  final TextEditingController academicYearController = TextEditingController();
  // ignore: non_constant_identifier_names
  final TextEditingController GPAController = TextEditingController();
  final TextEditingController governorateController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController streetController = TextEditingController();

  final TextEditingController otherController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController universityNameController =
  TextEditingController();
  var dateFormat = DateFormat('yyyy/MM/dd');

  onTapBirthDate(BuildContext context) async {
    try {
      var selectedDate = await showCustomDatePicker(context,
          initialDate: dateOfBirthController.text.isEmpty
              ? null
              : dateFormat.parse(dateOfBirthController.text));
      dateOfBirthController.text = dateFormat.format(selectedDate!);
      emit(DateChangedState());
    } catch (e) {
      log(e.toString());
    }
  }

  onTapGradDate(BuildContext context) async {
    try {
      var selectedDate = await showCustomDatePicker(context,
          initialDate: gradDateController.text.isEmpty
              ? null
              : dateFormat.parse(gradDateController.text));
      gradDateController.text = dateFormat.format(selectedDate!);
      emit(DateChangedState());
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Future<void> close() {
    fNameController.dispose();
    sNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    dateOfBirthController.dispose();
    academicYearController.dispose();
    GPAController.dispose();
    governorateController.dispose();
    cityController.dispose();

    passwordController.dispose();
    streetController.dispose();

    otherController.dispose();
    gradDateController.dispose();
    universityNameController.dispose();
    return super.close();
  }
}
