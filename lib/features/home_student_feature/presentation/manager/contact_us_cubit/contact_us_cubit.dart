import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:oralsync/core/error/error_model.dart';
import 'package:oralsync/core/error/failure.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/shared_data_layer/contact_us_data_layer/contact_us_repo.dart';

part 'contact_us_state.dart';

class ContactUsCubit extends Cubit<ContactUsState> {
  ContactUsCubit({required ContactUsRepo contactUsRepo})
      : _contactUsRepo = contactUsRepo,
        super(ContactUsInitial());
  final ContactUsRepo _contactUsRepo;
  var formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  sendFeedBack() async {
    emit(SendFeedbackLoading());
    var res = await _contactUsRepo.sendFeedback(
      message: messageController.text,
      phoneNumber: phoneController.text,
      email: emailController.text,
      name: nameController.text,
    );

    res.fold(
      (failure) {
        if (failure is ServerFailure) {
          emit(SendFeedbackError(model: failure.errorModel!));
        } else if (failure is OfflineFailure) {
          emit(SendFeedbackError(model: failure.model!));
        }
      },
      (model) {
        clearData();
        emit(SendFeedbackSuccess(model: model));
      },
    );
  }

  Future<void> launchEmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'AhmadAbbass822@gmail.com',
      queryParameters: {'subject': 'Contact', 'body': 'Dear,'},
    );
    if (!await launchUrl(emailLaunchUri)) {
      throw Exception();
    }
  }

  Future<void> launchWhatsapp() async {
    if (!await launchUrl(Uri.parse('https://wa.me/+201029410206'))) {
      throw Exception('Could not launch ');
    }
  }

  clearData() {
    nameController.clear();
    emailController.clear();
    phoneController.clear();
    messageController.clear();
  }

  @override
  Future<void> close() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    messageController.dispose();
    return super.close();
  }
}
