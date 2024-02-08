import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:oralsync/core/helpers/custom_date_pickers.dart';
import 'package:oralsync/features/Auth/domain/entities/register.dart';
import 'package:oralsync/features/Auth/domain/use_cases/register_use_case.dart';
import 'package:oralsync/features/Auth/domain/use_cases/sign_up_doctor_use_case.dart';
import 'package:oralsync/features/Auth/domain/use_cases/sign_up_patient_use_case.dart';

part 'doctor_sign_up_state.dart';

class DoctorSignUpCubit extends Cubit<DoctorSignUpState> {
  DoctorSignUpCubit( {required this.registerUseCase,required this.signUpDoctorUseCase})
      : super(DoctorSignUpInitial());
  final RegisterUseCase registerUseCase;
  final SignUpDoctorUseCase signUpDoctorUseCase;

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
    emit(AddDoctorLoading());
    var res = await signUpDoctorUseCase.signUpDoctor(
      fName: fNameController.text,
      sName: sNameController.text,
      email: emailController.text,
      phone: phoneController.text,
      dob: dateOfBirthController.text,
      isMale: isMale ?? true,
      clinicGovernment: governorateClinicController.text,
      clinicCity: cityController.text,
      universityName: universityNameController.text,
      gradDate: gradDateController.text,
      academicYear: academicYearController.text,
      clinicFloor: floorController.text,
      clinicStreet: streetController.text,
      GPA: GPAController.text,
      isDoctor: true,
      other: otherController.text,
      password: passwordController.text,
    );
    res.fold(
            (failure) =>
            emit(const AddDoctorError(errMessage: 'Error While Loading')),
            (model) => emit(AddDoctorSuccess(message: model.message)));
  }
  void registerUser() async {
    emit(RegisterDoctorLoading());
    var res = await registerUseCase.register(
      name: '${fNameController.text} ${sNameController.text}',
      email: emailController.text,
      password: passwordController.text,
      confirmPassword: passwordController.text,
      phoneNumber: phoneController.text,
      isMale: isMale ?? true,
      isDoctor: true,
      isStudent: false,
      isPatient: false,
    );
    res.fold(
        (failure) =>
            emit(const RegisterDoctorError(errMessage: 'Error While Loading')),
        (model) async {
      if (model.flag ?? false) {
        await addDoctor();
        emit(RegisterDoctorSuccess(model: model));
      } else {
        emit(RegisterDoctorError(errMessage: model.message ?? ''));
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
  final TextEditingController governorateClinicController =
      TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController buildingController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController floorController = TextEditingController();
  final TextEditingController otherController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController universityNameController = TextEditingController();
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
  } onTapGradDate(BuildContext context) async {
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
