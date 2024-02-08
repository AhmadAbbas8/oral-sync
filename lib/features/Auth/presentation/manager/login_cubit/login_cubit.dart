import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:oralsync/features/Auth/domain/entities/user.dart';
import 'package:oralsync/features/Auth/domain/use_cases/login_use_case.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({required this.loginUseCase}) : super(LoginInitial());
  final LoginUseCase loginUseCase;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  bool obscurePassword =true;
  toggleVisibilityPassword(){
    obscurePassword = !obscurePassword;
    emit(ChangePasswordVisibility(obscurePassword: obscurePassword));
  }

  void login({
    required String email,
    required String password,
  }) async {
    emit(LoginLoading());
    final user = await loginUseCase.call(email: email, password: password);
    user.fold(
        (failure) => emit(const LoginError(
            messageAr: 'خطأ فى عملية التسجيل',
            messageEn: 'Error While Loading')), (user) {
      if (user.flag ?? false) {
        emit(LoginSuccess(user: user));
      } else {
        emit(LoginError(
            messageAr: 'مستخدم غير موجود',
            messageEn: 'User Not found'));
      }
    });
  }


}
