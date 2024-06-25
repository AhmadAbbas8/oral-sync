import "dart:convert";
import "dart:developer";

import "package:easy_localization/easy_localization.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:flutter_switch/flutter_switch.dart";
import "package:oralsync/core/helpers/custom_progress_indicator.dart";
import "package:oralsync/core/helpers/extensions/navigation_extensions.dart";
import "package:oralsync/core/helpers/snackbars.dart";
import "package:oralsync/core/service_locator/service_locator.dart";
import "package:oralsync/core/utils/colors_palette.dart";
import "package:oralsync/features/Auth/presentation/pages/login_page.dart";
import "package:oralsync/features/settings_feature/presentation/logic/settings__cubit.dart";

import "../../../../core/cache_helper/cache_storage.dart";
import "../../../../core/cache_helper/shared_prefs_keys.dart";
import "../../../../core/helpers/check_language.dart";
import "../../../../core/helpers/general_validators.dart";
import "../../../../core/utils/icon_broken.dart";
import "../../../../core/utils/size_helper.dart";
import "../../../../translations/locale_keys.g.dart";
import "../../../Auth/data/models/user_model.dart";
import "../../../Auth/presentation/widgets/custom_login_button_widget.dart";
import "../../../Auth/presentation/widgets/custom_text_form_field_login.dart";
import "../widgets/change_account_to_doctor_dialog.dart";

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({
    super.key,
    required this.userId,
  });

  static const String routeName = "/SettingsScreen";
  final String userId;

  @override
  Widget build(BuildContext context) {
    log(userId);
    var cache = ServiceLocator.instance<CacheStorage>();
    var userDecoded = json.decode(cache.getData(key: SharedPrefsKeys.user));
    var user = UserModel.fromJson(userDecoded);
    final size = MediaQuery.sizeOf(context);
    return BlocProvider(
      create: (_) => ServiceLocator.instance<SettingsCubit>(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(LocaleKeys.settings).tr(),
        ),
        body: Container(
          height: size.height * 0.7,
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            color: Color(0xFFF9F9F9),
          ),
          child: BlocConsumer<SettingsCubit, SettingsState>(
            listener: (context, state) {
              handleConvertStudentStates(state, context);
              handleUpdatePasswordStates(state, context);
            },
            builder: (context, state) {
              var cubit = context.read<SettingsCubit>();
              return Form(
                key: cubit.formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ListTile(
                      leading: const Icon(Icons.language),
                      title: const Text(
                        LocaleKeys.language,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ).tr(),
                      trailing: FittedBox(
                        child: FlutterSwitch(
                          value: isArabic(context) ? true : false,
                          onToggle: (state) async =>
                              onChangeLanguage(state, context),
                          duration: const Duration(milliseconds: 360),
                          activeIcon: const Text('AR'),
                          inactiveIcon: const Text('EN'),
                        ),
                      ),
                    ),
                    if (user.userRole?.toUpperCase() == 'Student'.toUpperCase())
                      ListTile(
                        leading: const Icon(IconBroken.User),
                        title: const Text(
                          LocaleKeys.change_to_doctor,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ).tr(),
                        trailing: FittedBox(
                          child: FlutterSwitch(
                            value: false,
                            onToggle: (state) => showCupertinoDialog(
                              context: context,
                              builder: (context) {
                                return ChangeAccountToDoctorDialog(
                                  onConfirm: () async => await cubit
                                      .convertStudentAccountToDoctorAccount(
                                          userId),
                                );
                              },
                            ),
                            duration: const Duration(milliseconds: 360),
                          ),
                        ),
                      ),
                    SizedBox(height: 5.h),
                    const Divider(thickness: 4),
                    SizedBox(height: 10.h),
                    CustomTextFormFieldLogin(
                      width: size.width * .8,
                      hintText: LocaleKeys.password,
                      obscureText: cubit.obscurePassword,
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(cubit.obscurePassword
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () => cubit.toggleVisibilityPassword(),
                      ),
                      textEditingController: cubit.newPasswordController,
                      validator: validatePassword,
                    ),
                    SizeHelper.defSizedBoxField,
                    CustomLoginButtonWidget(
                      title: LocaleKeys.update_password,
                      minWidth: size.width * .8,
                      onPressed: () async {
                        if (cubit.formKey.currentState!.validate()) {
                          await cubit.updateUserPassword();
                        }
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void handleConvertStudentStates(SettingsState state, BuildContext context) {
    if (state is ConvertAccountLoading) {
      context.pop();
      showCustomProgressIndicator(context);
    }
    if (state is ConvertAccountError) {
      context.pop();
      showCustomSnackBar(
        context,
        msg: isArabic(context)
            ? state.model.messageAr ?? ''
            : state.model.messageEn ?? '',
        backgroundColor: ColorsPalette.errorColor,
      );
    }
    if (state is ConvertAccountSuccess) {
      context.pushNamedAndRemoveUntil(
        LoginPage.routeName,
        predicate: (route) => false,
      );
      showCustomSnackBar(
        context,
        msg: isArabic(context)
            ? state.model.messageAr ?? ''
            : state.model.messageEn ?? '',
        backgroundColor: ColorsPalette.successColor,
      );
    }
  }

  void handleUpdatePasswordStates(SettingsState state, BuildContext context) {
    if (state is UpdateUserPasswordLoading) {
      showCustomProgressIndicator(context);
    }
    if (state is UpdateUserPasswordError) {
      context.pop();
      showCustomSnackBar(
        context,
        msg: isArabic(context)
            ? state.model.messageAr ?? ''
            : state.model.messageEn ?? '',
        backgroundColor: ColorsPalette.errorColor,
      );
    }
    if (state is UpdateUserPasswordSuccess) {
      context.pop();
      showCustomSnackBar(
        context,
        msg: isArabic(context)
            ? state.model.messageAr ?? ''
            : state.model.messageEn ?? '',
        backgroundColor: ColorsPalette.successColor,
      );
    }
  }

  Future<void> onChangeLanguage(bool state, BuildContext context) async {
    {
      if (state) {
        await context.setLocale(const Locale('ar'));
      } else {
        await context.setLocale(const Locale('en'));
      }
      await WidgetsBinding.instance.performReassemble();
      // setState(() {});
    }
  }
}
