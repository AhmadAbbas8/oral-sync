import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:oralsync/core/helpers/check_language.dart';
import 'package:oralsync/core/helpers/custom_progress_indicator.dart';
import 'package:oralsync/core/helpers/extensions/navigation_extensions.dart';
import 'package:oralsync/core/helpers/general_validators.dart';
import 'package:oralsync/core/helpers/snackbars.dart';
import 'package:oralsync/core/service_locator/service_locator.dart';
import 'package:oralsync/core/utils/assets_manager.dart';

import 'package:oralsync/core/utils/size_helper.dart';
import 'package:oralsync/features/Auth/presentation/widgets/custom_login_button_widget.dart';


import '../../../../translations/locale_keys.g.dart';
import '../manager/contact_us_cubit/contact_us_cubit.dart';
import '../widgets/contact_us_form_field_widget.dart';

class ContactUsPage extends StatelessWidget {
  static const routeName = '/ContactUsPage';

  const ContactUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return BlocProvider(
      create: (context) => ContactUsCubit(
        contactUsRepo: ServiceLocator.instance(),
      ),
      child: Scaffold(
        appBar: _buildAppBar(),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Image.asset(
                AssetsManager.contactUsImage,
              ),
            ),
            BlocConsumer<ContactUsCubit, ContactUsState>(
              listener: stateHandler,
              builder: (context, state) {
                var cubit = context.read<ContactUsCubit>();
                return SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: cubit.formKey,
                      child: Column(
                        children: [
                          SizeHelper.defSizedBoxField,
                          ContactUsFormField(
                            hintText: LocaleKeys.full_name,
                            textEditingController: cubit.nameController,
                          ),
                          SizeHelper.defSizedBoxField,
                          ContactUsFormField(
                            hintText: LocaleKeys.email,
                            textEditingController: cubit.emailController,
                          ),
                          SizeHelper.defSizedBoxField,
                          ContactUsFormField(
                            textEditingController: cubit.phoneController,
                            hintText: LocaleKeys.phone_number,
                          ),
                          SizeHelper.defSizedBoxField,
                          ContactUsFormField(
                            textEditingController: cubit.messageController,
                            hintText: LocaleKeys.message,
                            isRequired: true,
                            validator: generalValidator,
                            maxLine: 3,
                            minLine: 1,
                          ),
                          SizeHelper.defSizedBoxField,
                          CustomLoginButtonWidget(
                            title: LocaleKeys.send,
                            minWidth: size.width * 0.8,
                            onPressed: () =>
                                cubit.formKey.currentState!.validate()
                                    ? cubit.sendFeedBack()
                                    : '',
                          ),
                          SizeHelper.defSizedBoxField,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              IconButton(
                                onPressed: () {
                                  cubit
                                      .launchWhatsapp()
                                      .catchError((e) => log(e.toString()));
                                },
                                icon: const Icon(
                                  FontAwesomeIcons.whatsapp,
                                  size: 35,
                                  color: Colors.green,
                                ),
                              ),
                              IconButton(
                                onPressed: () => cubit
                                    .launchWhatsapp()
                                    .catchError((e) => log(e.toString())),
                                icon: const Icon(
                                  FontAwesomeIcons.google,
                                  size: 35,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  void stateHandler(BuildContext context, state) {
    if (state is SendFeedbackLoading) {
      showCustomProgressIndicator(context);
    } else if (state is SendFeedbackError) {
      context.pop();
      showCustomSnackBar(
        context,
        msg:
            isArabic(context) ? state.model.messageAr! : state.model.messageEn!,
      );
    } else if (state is SendFeedbackSuccess) {
      context.pop();
      showCustomSnackBar(
        context,
        msg:
            isArabic(context) ? state.model.messageAr! : state.model.messageEn!,
      );
    }
  }

  AppBar _buildAppBar() => AppBar(
        title: const Text(
          LocaleKeys.contact_us,
        ).tr(),
      );
}
