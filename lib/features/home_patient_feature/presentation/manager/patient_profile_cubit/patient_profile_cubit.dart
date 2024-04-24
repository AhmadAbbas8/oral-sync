import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oralsync/core/cache_helper/cache_storage.dart';
import 'package:oralsync/core/error/error_model.dart';
import 'package:oralsync/core/shared_data_layer/edit_profile_data_layer/edit_repo.dart';

import '../../../../../core/cache_helper/shared_prefs_keys.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/helpers/custom_date_pickers.dart';
import '../../../../../core/service_locator/service_locator.dart';
import '../../../../Auth/data/models/user_model.dart';

part 'patient_profile_state.dart';

class PatientProfileCubit extends Cubit<PatientProfileState> {
  PatientProfileCubit(this._editProfileRepo, this._cacheStorage)
      : super(PatientProfileInitial());
  final picker = ServiceLocator.instance<ImagePicker>();
  final EditProfileRepo _editProfileRepo;
  final CacheStorage _cacheStorage;

  final formKey = GlobalKey<FormState>();
  bool? isMale;
  final lNameController = TextEditingController();
  final fNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final dateOfBirthController = TextEditingController();
  final cityController = TextEditingController();
  final governorateController = TextEditingController();
  final insuranceCompanyController = TextEditingController();

  UserModel getUserModel() {
    return UserModel.fromJson(
        jsonDecode(_cacheStorage.getData(key: SharedPrefsKeys.user)));
  }

  onOpenEditPage() {
    var patient = getUserModel().userDetails as PatientDetails;
    fNameController.text = patient.firstName ?? '';
    lNameController.text = patient.lastName ?? '';
    emailController.text = patient.email ?? '';
    phoneController.text = patient.phoneNumber ?? '';
    try {
      governorateController.text = patient.address![0];
      cityController.text = patient.address![1];
    } catch (e) {
      log(e.toString(), name: 'Error on Catch');
    }
    isMale = patient.isMale;
    dateOfBirthController.text = patient.birthDate ?? '';
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
      emit(DateChangedPatientEditState());
    } catch (e) {
      log(e.toString());
    }
  }

  changeProfileImage() async {
    var pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage == null) return;
    emit(ChangePatientProfileLoading());
    var res = await _editProfileRepo.updateImageProfile(data: {
      'formFile': await MultipartFile.fromFile(
        pickedImage.path,
        filename: pickedImage.path.split('/').last,
      )
    });

    res.fold(
      (failure) {
        if (failure is ServerFailure) {
          emit(ChangePatientProfileError(error: failure.errorModel));
        } else if (failure is OfflineFailure) {
          emit(ChangePatientProfileError(error: failure.model));
        }
      },
      (model) {
        emit(ChangePatientProfileSuccess(image: model.profileImage ?? ''));
      },
    );
  }

  updateStudentData() async {
    emit(UpdatePatientDataLoading());
    var res = await _editProfileRepo.updatePatientProfile(
      data: {
        "firstName": fNameController.text,
        "lastName": lNameController.text,
        "email": emailController.text,
        "isMale": isMale,
        "phoneNumber": phoneController.text,
        "address": [
          governorateController.text,
          cityController.text,
        ],
        "insuranceCompany": insuranceCompanyController.text,
        "birthDate": dateOfBirthController.text
      },
    );
    res.fold((failure) {
      if (failure is ServerFailure) {
        emit(UpdatePatientDataError(responseModel: failure.errorModel!));
      } else if (failure is OfflineFailure) {
        emit(UpdatePatientDataError(responseModel: failure.model!));
      }
    }, (unit) {
      emit(UpdatePatientDataSuccess());
    });
  }

  @override
  Future<void> close() {
    lNameController.dispose();
    fNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    dateOfBirthController.dispose();
    cityController.dispose();
    governorateController.dispose();
    insuranceCompanyController.dispose();
    return super.close();
  }
}
