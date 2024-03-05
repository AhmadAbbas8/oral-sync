import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:oralsync/core/cache_helper/cache_storage.dart';
import 'package:oralsync/core/cache_helper/shared_prefs_keys.dart';
import 'package:oralsync/core/error/error_model.dart';
import 'package:oralsync/core/error/failure.dart';
import 'package:oralsync/core/shared_data_layer/edit_profile_data_layer/edit_repo.dart';
import 'package:oralsync/features/Auth/data/models/user_model.dart';

import '../../../../../core/helpers/custom_date_pickers.dart';
import '../../../../../core/service_locator/service_locator.dart';

part 'student_edit_profile_state.dart';

class StudentEditProfileCubit extends Cubit<StudentEditProfileState> {
  StudentEditProfileCubit({required editProfileRepo, required cacheStorage})
      : _editProfileRepo = editProfileRepo,
        _cacheStorage = cacheStorage,
        super(StudentEditProfileInitial());

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool? isMale;
  final CacheStorage _cacheStorage;
  final picker = ServiceLocator.instance<ImagePicker>();
  String? userImage;

  final EditProfileRepo _editProfileRepo;
  final TextEditingController fNameController = TextEditingController();
  final TextEditingController lNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController universityController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController gradDateController = TextEditingController();
  final TextEditingController academicYearController = TextEditingController();
  final TextEditingController gpaController = TextEditingController();
  final TextEditingController universityGovernorateController =
      TextEditingController();
  final TextEditingController universityCityController =
      TextEditingController();

  UserModel getStudentModel() {
    return UserModel.fromJson(
        jsonDecode(_cacheStorage.getData(key: SharedPrefsKeys.user)));
  }

  changeProfileImage() async {
    var pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage == null) return;
    emit(ChangeProfileLoading());
    userImage = getStudentModel().profileImage ?? '';
    var res = await _editProfileRepo.updateImageProfile(data: {
      'formFile': await MultipartFile.fromFile(
        pickedImage.path,
        filename: pickedImage.path.split('/').last,
      )
    });

    res.fold(
      (failure) {
        if (failure is ServerFailure) {
          emit(ChangeProfileError(responseModel: failure.errorModel!));
        } else if (failure is OfflineFailure) {
          emit(ChangeProfileError(responseModel: failure.model!));
        }
      },
      (model) {
        userImage = getStudentModel().profileImage ?? '';
        emit(ChangeProfileSuccess(image: model.profileImage ?? ''));
      },
    );
  }

  onOpenEditPage() {
    UserModel studentData = getStudentModel();
    log(studentData.toJson().toString());
    var studentDetails = studentData.userDetails as StudentDetails;
    fNameController.text = studentDetails.firstName ?? '';
    isMale = studentDetails.isMale;
    lNameController.text = studentDetails.lastName ?? '';
    emailController.text = studentDetails.email ?? '';
    phoneController.text = studentDetails.phoneNumber ?? '';
    universityController.text = studentDetails.universityName ?? '';
    dobController.text = studentDetails.birthDate ?? '';
    gradDateController.text = '';
    academicYearController.text = studentDetails.academicYear?.toString() ?? '';
    gpaController.text = studentDetails.gpa?.toString() ?? '';
    try {
      universityGovernorateController.text =
          studentDetails.universitAddress![0] ?? '';
      universityCityController.text = studentDetails.universitAddress![1] ?? '';
    } catch (e) {
      universityGovernorateController.text = '';
      universityCityController.text = '';
    }
  }

  updateStudentData() async {
    emit(UpdateStudentDataLoading());
    var res = await _editProfileRepo.updateStudentProfile(data: {
      "firstName": fNameController.text,
      "lastName": lNameController.text,
      "email": emailController.text,
      "isMale": isMale,
      "phoneNumber": phoneController.text,
      "universityName": universityController.text,
      "universityAddress": [
        universityGovernorateController.text,
        universityCityController.text
      ],
      "gpa": gpaController.text,
      "birthDate": dobController.text,
      "academicYear": int.tryParse(academicYearController.text)
    });
    res.fold((failure) {
      if (failure is ServerFailure) {
        emit(UpdateStudentDataError(responseModel: failure.errorModel!));
      } else if (failure is OfflineFailure) {
        emit(UpdateStudentDataError(responseModel: failure.model!));
      }
    }, (unit) {
      emit(UpdateStudentDataSuccess());
    });
  }

  onChangedGender(bool? value) {
    isMale = value;
    emit(ChangeGender(isMale: isMale!));
  }

  var dateFormat = DateFormat('yyyy/MM/dd');

  onTapBirthDate(BuildContext context) async {
    try {
      var selectedDate = await showCustomDatePicker(context,
          initialDate: dobController.text.isEmpty
              ? null
              : dateFormat.parse(dobController.text));
      dobController.text = dateFormat.format(selectedDate!);
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
    try {
      fNameController.dispose();
      lNameController.dispose();
      emailController.dispose();
      phoneController.dispose();
      universityController.dispose();
      dobController.dispose();
      gradDateController.dispose();
      academicYearController.dispose();
      gpaController.dispose();
      universityGovernorateController.dispose();
      universityCityController.dispose();
    } catch (e) {
      log(e.toString());
    }
    return super.close();
  }
}
