import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:oralsync/core/error/Error_model.dart';
import 'package:oralsync/core/helpers/custom_date_pickers.dart';
import 'package:oralsync/features/Auth/data/models/user_model.dart';
import 'package:oralsync/features/Auth/domain/use_cases/login_use_case.dart';
import 'package:oralsync/features/Auth/domain/use_cases/new_register_use_case.dart';

import 'package:intl/intl.dart';

import '../../../../../core/error/failure.dart';

part 'patient_sign_up_state.dart';

class PatientSignUpCubit extends Cubit<PatientSignUpState> {
  PatientSignUpCubit({
    required this.newRegisterUseCase,
    required this.loginUseCase,
  }) : super(PatientSignUpInitial());
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

  void register() async {
    emit(RegisterPatientLoading());
    var res = await newRegisterUseCase.call(
      email: emailController.text,
      password: passwordController.text,
      confirmPassword: passwordController.text,
      isMale: isMale ?? true,
      phoneNumber: phoneController.text,
      isDoctor: false,
      isStudent: false,
      isPatient: true,
      fName: fNameController.text,
      lName: lNameController.text,

      /// TODO : SOON
      address: [
        governorateController.text,
        cityController.text,
      ],
      insuranceCompany: null,
      birthDate: dateOfBirthController.text,
    );

    res.fold((failure) {
      if (failure is OfflineFailure) {
        emit(RegisterPatientError(
            errorModel: ErrorModel(
                messageEn: 'Please Check your internet Connection',
                messageAr: 'من فضلك افحص اتصال الانترنت لديك')));
      }
      emit(RegisterPatientError(
          errorModel: ErrorModel(
              messageEn: 'User registered already',
              messageAr: 'هذا المستخدم مسجل بالفعل')));
    }, (model) async {
      if (model.flag ?? false) {
        await loginDoc();
      } else {
        emit(RegisterPatientError(
            errorModel: ErrorModel(
                messageEn: 'User registered already',
                messageAr: 'هذا المستخدم مسجل بالفعل')));
      }
    });
  }

  Future<void> loginDoc() async {
    var user = await loginUseCase.call(
        email: emailController.text, password: passwordController.text);
    user.fold((failure) {
      if (failure is ServerFailure) {
        emit(RegisterPatientError(errorModel: failure.errorModel));
      } else {
        emit(RegisterPatientError(
            errorModel: ErrorModel(
                messageEn: 'Please Check your internet Connection',
                messageAr: 'من فضلك افحص اتصال الانترنت لديك')));
      }
    }, (user) {
      emit(RegisterPatientSuccess(model: user));
    });
  }

  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController governorateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Future<void> close() {
    fNameController.dispose();
    lNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    dateOfBirthController.dispose();
    governorateController.dispose();
    cityController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
