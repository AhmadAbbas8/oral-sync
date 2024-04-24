part of 'contact_us_cubit.dart';

@immutable
abstract class ContactUsState {}

class ContactUsInitial extends ContactUsState {}

class SendFeedbackLoading extends ContactUsState {}

class SendFeedbackError extends ContactUsState {
  final ResponseModel model;

  SendFeedbackError({required this.model});
}

class SendFeedbackSuccess extends ContactUsState {
  final ResponseModel model;

  SendFeedbackSuccess({required this.model});
}
