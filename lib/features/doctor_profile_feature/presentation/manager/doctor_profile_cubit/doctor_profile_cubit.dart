import 'dart:convert';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oralsync/core/cache_helper/cache_storage.dart';
import 'package:oralsync/core/error/error_model.dart';
import 'package:oralsync/core/shared_data_layer/edit_profile_data_layer/edit_repo.dart';

import '../../../../../core/cache_helper/shared_prefs_keys.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/helpers/custom_date_pickers.dart';
import '../../../../../core/service_locator/service_locator.dart';
import '../../../../Auth/data/models/user_model.dart';

part 'doctor_profile_state.dart';

class DoctorProfileCubit extends Cubit<DoctorProfileState> {
  DoctorProfileCubit(this._cacheStorage, this._editProfileRepo)
      : super(DoctorProfileInitial());
  final CacheStorage _cacheStorage;
  final EditProfileRepo _editProfileRepo;
  final picker = ServiceLocator.instance<ImagePicker>();
  bool? isMale;
  bool obscurePassword = true;
  final formKey = GlobalKey<FormState>();
  final fNameController = TextEditingController();
  final sNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final universityNameController = TextEditingController();
  final dateOfBirthController = TextEditingController();
  final gradDateController = TextEditingController();
  final GPAController = TextEditingController();
  final academicYearController = TextEditingController();
  final cityController = TextEditingController();
  final governorateClinicController = TextEditingController();
  final streetController = TextEditingController();
  final buildingController = TextEditingController();
  final otherController = TextEditingController();
  final floorController = TextEditingController();
  final clinicPhoneController = TextEditingController();
  var dateFormat = DateFormat('yyyy/MM/dd');
  List<String> insuranceCompanies = [];

  onTapBirthDate(BuildContext context) async {
    try {
      var selectedDate = await showCustomDatePicker(context,
          initialDate: dateOfBirthController.text.isEmpty
              ? null
              : dateFormat.parse(dateOfBirthController.text));
      dateOfBirthController.text = dateFormat.format(selectedDate!);
      emit(DateChangedStateDoctor());
    } catch (e) {
      var selectedDate = await showCustomDatePicker(context);
      dateOfBirthController.text = dateFormat.format(selectedDate!);
      emit(DateChangedStateDoctor());
    }
  }

  UserModel getUserModel() {
    return UserModel.fromJson(
        jsonDecode(_cacheStorage.getData(key: SharedPrefsKeys.user)));
  }

  changeProfileImage() async {
    var pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage == null) return;
    emit(ChangeDoctorProfileLoading());
    var res = await _editProfileRepo.updateImageProfile(
      data: {
        'formFile': await MultipartFile.fromFile(
          pickedImage.path,
          filename: pickedImage.path.split('/').last,
        )
      },
    );

    res.fold(
      (failure) {
        if (failure is ServerFailure) {
          emit(ChangeDoctorProfileError(model: failure.errorModel!));
        } else if (failure is OfflineFailure) {
          emit(ChangeDoctorProfileError(model: failure.model!));
        }
      },
      (model) {
        emit(ChangeDoctorProfileSuccess(image: model.profileImage ?? ''));
      },
    );
  }

  onTapGradDate(BuildContext context) async {
    try {
      var selectedDate = await showCustomDatePicker(context,
          initialDate: gradDateController.text.isEmpty
              ? null
              : dateFormat.parse(gradDateController.text));
      gradDateController.text = dateFormat.format(selectedDate!);
      emit(DateChangedStateDoctor());
    } catch (e) {
      var selectedDate = await showCustomDatePicker(context);
      gradDateController.text = dateFormat.format(selectedDate!);
      emit(DateChangedStateDoctor());
    }
  }

  onChangedGender(bool? value) {
    isMale = value;
    emit(GenderChangedStateDoctor(isMale: isMale!));
  }

  onAddInsuranceCompany(List<String> companies) {
    insuranceCompanies = companies;
    log(insuranceCompanies.toString());
  }

  updateDoctorData() async {
    var address = [
      governorateClinicController.text,
      cityController.text,
      streetController.text,
      buildingController.text,
      floorController.text,
      otherController.text
    ];
    emit(UpdateDoctorDataLoading());
    var res = await _editProfileRepo.updateDoctorProfile(
      data: {
        "firstName": fNameController.text,
        "lastName": sNameController.text,
        "email": emailController.text,
        "Governorate": governorateClinicController.text,
        "isMale": isMale ?? true,
        "phoneNumber": phoneController.text,
        "universityName": universityNameController.text,
        "clinicAddress": address,
        "clinicNumber": clinicPhoneController.text,
        "insuranceCompanies": insuranceCompanies,
        "certificates": ["string"],
        "gpa": double.tryParse(GPAController.text),
        "birthDate": dateOfBirthController.text,
        "graduationDate": gradDateController.text,
      },
    );
    res.fold((failure) {
      if (failure is ServerFailure) {
        emit(UpdateDoctorDataError(responseModel: failure.errorModel!));
      } else if (failure is OfflineFailure) {
        emit(UpdateDoctorDataError(responseModel: failure.model!));
      }
    }, (unit) {
      emit(UpdateDoctorDataSuccess());
    });
  }

  onOpenEditPage() {
    var doctor = getUserModel().userDetails as DoctorDetails;
    isMale = doctor.isMale;
    fNameController.text = doctor.firstName ?? '';
    sNameController.text = doctor.lastName ?? '';
    emailController.text = doctor.email ?? '';
    phoneController.text = doctor.phoneNumber ?? '';
    universityNameController.text = doctor.universityName ?? '';
    dateOfBirthController.text = doctor.birthDate ?? '';
    gradDateController.text = doctor.graduationDate ?? '';
    GPAController.text = doctor.gpa.toString();
    academicYearController.text = doctor.graduationDate ?? '';
    try {
      governorateClinicController.text = doctor.clinicAddress![0]!;
      cityController.text = doctor.clinicAddress![1]!;
      streetController.text = doctor.clinicAddress![2]!;
      buildingController.text = doctor.clinicAddress![3]!;
      floorController.text = doctor.clinicAddress![4]!;
      otherController.text = doctor.clinicAddress![5]!;
    } catch (error) {
      log(error.toString());
    }

    clinicPhoneController.text = doctor.clinicNumber ?? '';
  }

  @override
  Future<void> close() {
    fNameController.dispose();
    sNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    universityNameController.dispose();
    dateOfBirthController.dispose();
    gradDateController.dispose();
    GPAController.dispose();
    academicYearController.dispose();
    cityController.dispose();
    governorateClinicController.dispose();
    streetController.dispose();
    buildingController.dispose();
    otherController.dispose();
    floorController.dispose();
    clinicPhoneController.dispose();
    return super.close();
  }
}
