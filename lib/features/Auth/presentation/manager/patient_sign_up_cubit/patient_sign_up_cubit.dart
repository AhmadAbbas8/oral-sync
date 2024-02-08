import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:oralsync/core/helpers/custom_date_pickers.dart';
import 'package:oralsync/features/Auth/domain/entities/register.dart';
import 'package:oralsync/features/Auth/domain/use_cases/register_use_case.dart';
import 'package:oralsync/features/Auth/domain/use_cases/sign_up_patient_use_case.dart';
import 'package:intl/intl.dart';

part 'patient_sign_up_state.dart';

class PatientSignUpCubit extends Cubit<PatientSignUpState> {
  PatientSignUpCubit({
    required this.registerUseCase,
    required this.signUpPatientUseCase,
  }) : super(PatientSignUpInitial());
  final RegisterUseCase registerUseCase;

  final SignUpPatientUseCase signUpPatientUseCase;
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

  void registerUser() async {
    emit(RegisterPatientLoading());
    var res = await registerUseCase.register(
      name: '${fNameController.text} ${lNameController.text}',
      email: emailController.text,
      password: passwordController.text,
      confirmPassword: passwordController.text,
      phoneNumber: phoneController.text,
      isMale: isMale ?? true,
      isDoctor: false,
      isStudent: false,
      isPatient: true,
    );
    res.fold(
        (failure) =>
            emit(const RegisterPatientError(errMessage: 'Error While Loading')),
        (model) async {
      if (model.flag ?? false) {
        await addPatient();
        emit(RegisterPatientSuccess(model: model));
      } else {
        emit(RegisterPatientError(errMessage: model.message ?? ''));
      }
    });
  }

  Future<void> addPatient() async {
    emit(AddedPatientLoading());
    var res = await signUpPatientUseCase.signUpPatient(
      fName: fNameController.text,
      sName: lNameController.text,
      email: emailController.text,
      phone: phoneController.text,
      dob: dateOfBirthController.text,
      isMale: isMale ?? true,
      government: governorateController.text,
      city: cityController.text,
    );
    res.fold(
        (failure) =>
            emit(const AddedPatientError(errMessage: 'Error While Loading')),
        (model) => emit(AddedPatientSuccess(message: model.message)));
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
