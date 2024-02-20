import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:oralsync/core/cache_helper/shared_prefs_keys.dart';
import 'package:oralsync/core/cache_helper/cache_storage.dart';
import 'package:oralsync/core/error/error_model.dart';
import 'package:oralsync/core/error/failure.dart';
import 'package:oralsync/core/service_locator/service_locator.dart';
import 'package:oralsync/features/Auth/data/models/user_model.dart';
import 'package:oralsync/features/Auth/domain/use_cases/login_use_case.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({required this.loginUseCase})
      : super(LoginInitial());

  final LoginUseCase loginUseCase;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  bool obscurePassword = true;
  bool keepMeLoggedIn = false;

  void onTapKeepMeLoggedIn() {
    keepMeLoggedIn = !keepMeLoggedIn;
    emit(ChangeKeepMeLoggedInState(state: keepMeLoggedIn));
  }

  toggleVisibilityPassword() {
    obscurePassword = !obscurePassword;
    emit(ChangePasswordVisibility(obscurePassword: obscurePassword));
  }

  void login({
    required String email,
    required String password,
  }) async {
    emit(LoginLoading());
    final user = await loginUseCase.call(email: email, password: password);
    user.fold((failure) {
      if (failure is ServerFailure) {
        emit(LoginError(errorModel: failure.errorModel));
      } else {
        emit(LoginError(
            errorModel: ResponseModel(
                messageEn: 'Please Check your internet Connection',
                messageAr: 'من فضلك افحص اتصال الانترنت لديك')));
      }
    }, (user) async {
      await ServiceLocator.instance<CacheStorage>().setData(
          key: SharedPrefsKeys.keepMeLoggedIn, value: keepMeLoggedIn);
      emit(LoginSuccess(user: user));

    });
  }

// void loginUpdate({
//   required String email,
//   required String password,
// }) async {
//   emit(LoginLoading());
//   final user =
//       await loginUpdateUseCase.call(email: email, password: password);
//   user.fold(
//       (failure) => emit(const LoginError(
//           messageAr: 'خطأ فى عملية التسجيل',
//           messageEn: 'Error While Loading')), (user) {
//     if (user.flag ?? false) {
//       emit(LoginSuccess(user: user));
//     } else {
//       emit(LoginError(
//           messageAr: 'مستخدم غير موجود', messageEn: 'User Not found'));
//     }
//   });
// }
}
