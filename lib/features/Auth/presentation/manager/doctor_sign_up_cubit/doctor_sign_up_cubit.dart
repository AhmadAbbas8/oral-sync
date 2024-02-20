import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:oralsync/core/error/error_model.dart';
import 'package:oralsync/core/error/failure.dart';
import 'package:oralsync/core/helpers/custom_date_pickers.dart';
import 'package:oralsync/features/Auth/data/models/user_model.dart';

import 'package:oralsync/features/Auth/domain/use_cases/login_use_case.dart';
import 'package:oralsync/features/Auth/domain/use_cases/new_register_use_case.dart';

part 'doctor_sign_up_state.dart';

class DoctorSignUpCubit extends Cubit<DoctorSignUpState> {
  DoctorSignUpCubit(
      {required this.loginUseCase, required this.newRegisterUseCase})
      : super(DoctorSignUpInitial());

  final LoginUseCase loginUseCase;
  final NewRegisterUseCase newRegisterUseCase;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool? isMale;
  bool obscurePassword = true;

  toggleVisibilityPassword() {
    obscurePassword = !obscurePassword;
    emit(ChangePasswordVisibility(obscurePassword: obscurePassword));
  }

  void register() async {
    var address = [
      governorateClinicController.text,
      cityController.text,
      streetController.text,
      buildingController.text,
      floorController.text,
      otherController.text
    ];
    emit(RegisterDoctorLoading());
    var res = await newRegisterUseCase.call(
      email: emailController.text,
      password: passwordController.text,
      confirmPassword: passwordController.text,
      isMale: isMale ?? true,
      phoneNumber: phoneController.text,
      isDoctor: true,
      isStudent: false,
      isPatient: false,
      fName: fNameController.text,
      lName: sNameController.text,
      universityName: universityNameController.text,
      graduationDate: gradDateController.text,
      clinicAddress: address,
      /// TODO : SOON
      insuranceCompanies: null,
      certificates: null,
      clinicNumber: clinicPhoneController.text,
      gpa: double.tryParse(GPAController.text) ?? 0,
      birthDate: dateOfBirthController.text,
      academicYear: int.tryParse(academicYearController.text),
    );
    res.fold((failure) {
      if (failure is OfflineFailure) {
        emit(RegisterDoctorError(
            errorModel: ResponseModel(
                messageEn: 'Please Check your internet Connection',
                messageAr: 'من فضلك افحص اتصال الانترنت لديك')));
      }
      emit(RegisterDoctorError(
          errorModel: ResponseModel(
              messageEn: 'User registered already',
              messageAr: 'هذا المستخدم مسجل بالفعل')));
    }, (model) async {
      if (model.flag ?? false) {
        await loginDoc();
      } else {
        emit(RegisterDoctorError(
            errorModel: ResponseModel(
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
        emit(RegisterDoctorError(errorModel: failure.errorModel));
      } else {
        emit(RegisterDoctorError(
            errorModel: ResponseModel(
                messageEn: 'Please Check your internet Connection',
                messageAr: 'من فضلك افحص اتصال الانترنت لديك')));
      }
    }, (user) {
      emit(RegisterDoctorSuccess(user: user));
    });
  }

  onChangedGender(bool? value) {
    isMale = value;
    emit(GenderChangedState(isMale: isMale!));
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
  final TextEditingController governorateClinicController =
      TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController buildingController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController floorController = TextEditingController();
  final TextEditingController otherController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController clinicPhoneController = TextEditingController();
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
    clinicPhoneController.dispose();
    emailController.dispose();
    phoneController.dispose();
    dateOfBirthController.dispose();
    academicYearController.dispose();
    GPAController.dispose();
    governorateClinicController.dispose();
    cityController.dispose();
    buildingController.dispose();
    passwordController.dispose();
    streetController.dispose();
    floorController.dispose();
    otherController.dispose();
    gradDateController.dispose();
    universityNameController.dispose();
    return super.close();
  }
}
