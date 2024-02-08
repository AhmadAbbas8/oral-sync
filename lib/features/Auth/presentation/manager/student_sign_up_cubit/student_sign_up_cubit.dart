import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:oralsync/core/helpers/custom_date_pickers.dart';
import 'package:oralsync/features/Auth/domain/entities/register.dart';
import 'package:oralsync/features/Auth/domain/use_cases/register_use_case.dart';
import 'package:oralsync/features/Auth/domain/use_cases/sign_up_student_use_case.dart';

part 'student_sign_up_state.dart';

class StudentSignUpCubit extends Cubit<StudentSignUpState> {
  StudentSignUpCubit(
      {required this.registerUseCase, required this.signUpStudentUseCase})
      : super(StudentSignUpInitial());
  final RegisterUseCase registerUseCase;
  final SignUpStudentUseCase signUpStudentUseCase;

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

  Future<void> addDoctor() async {
    emit(AddStudentLoading());
    var res = await signUpStudentUseCase.signUpStudent(
      fName: fNameController.text,
      sName: sNameController.text,
      email: emailController.text,
      phone: phoneController.text,
      dob: dateOfBirthController.text,
      isMale: isMale ?? true,
      universityCity: cityController.text,
      universityName: universityNameController.text,
      academicYear: academicYearController.text,
      universityStreet: streetController.text,
      GPA: GPAController.text,
      isDoctor: true,
      other: otherController.text,
      universityGovernment: governorateController.text,
      password: passwordController.text,
    );
    res.fold(
        (failure) =>
            emit(const AddStudentError(errMessage: 'Error While Loading')),
        (model) => emit(AddStudentSuccess(message: model.message)));
  }

  void registerUser() async {
    emit(RegisterStudentLoading());
    var res = await registerUseCase.register(
      name: '${fNameController.text} ${sNameController.text}',
      email: emailController.text,
      password: passwordController.text,
      confirmPassword: passwordController.text,
      phoneNumber: phoneController.text,
      isMale: isMale ?? true,
      isDoctor: false,
      isStudent: true,
      isPatient: false,
    );
    res.fold(
        (failure) =>
            emit(const RegisterStudentError(errMessage: 'Error While Loading')),
        (model) async {
      if (model.flag ?? false) {
        await addDoctor();
        emit(RegisterStudentSuccess(model: model));
      } else {
        emit(RegisterStudentError(errMessage: model.message ?? ''));
      }
    });
  }

  final TextEditingController fNameController = TextEditingController();
  final TextEditingController sNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();
  final TextEditingController gradDateController = TextEditingController();
  final TextEditingController academicYearController = TextEditingController();
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
