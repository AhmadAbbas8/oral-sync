import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:oralsync/core/error/error_model.dart';
import 'package:oralsync/core/error/failure.dart';
import 'package:oralsync/core/shared_data_layer/actions_data_layer/actions_repo.dart';
import 'package:oralsync/core/shared_data_layer/actions_data_layer/model/ratings_model.dart';
import 'package:oralsync/features/messages_feature/data/repo/messages_repo.dart';

part 'profile_view_from_patient_state.dart';

class ProfileViewFromPatientCubit extends Cubit<ProfileViewFromPatientState> {
  ProfileViewFromPatientCubit({
    required this.actionsRepo,
    required this.messagesRepo,
  }) : super(ProfileViewFromPatientInitial());

  final ActionsRepo actionsRepo;
  final MessagesRepo messagesRepo;

  createReserve({
    required String doctorId,
    required String location,
  }) async {
    emit(CreateReserveLoading());
    var res = await actionsRepo.createReserve(
      doctorId: doctorId,
      status: "Scheduled",
      location: location,
      dateAppointment: DateFormat('yyyy/MM/dd', 'EN').format(DateTime.now()),
      timeAppointment: DateFormat('HH:mm:ss').format(DateTime.now()),
      patientNotes: 'patientNotes',
      doctorNotes: 'doctorNotes',
      paymentMethod: 'Free',
      fee: 0.0,
    );
    res.fold(
      (failure) {
        if (failure is ServerFailure) {
          emit(CreateReserveError(responseModel: failure.errorModel!));
        } else if (failure is OfflineFailure) {
          emit(CreateReserveError(responseModel: failure.model!));
        }
      },
      (model) => emit(CreateReserveSuccess(responseModel: model)),
    );
  }

  getAllRates(String userId) async {
    emit(GetAllRatesLoading());
    var res = await actionsRepo.getAllRates(userId);
    res.fold(
      (failure) {
        if (failure is OfflineFailure) {
          emit(GetAllRatesError(model: failure.model!));
        } else if (failure is ServerFailure) {
          emit(GetAllRatesError(model: failure.errorModel!));
        }
      },
      (rates) => emit(GetAllRatesSuccess(rates: rates)),
    );
  }

  startNewConversation(String receiverId) async {
    emit(StartNewConversationLoading());
    var res = await messagesRepo.startNewConversation(receiverId: receiverId);
    res.fold(
      (l) {
        if (l is OfflineFailure) {
          emit(StartNewConversationError(model: l.model!));
        } else if (l is ServerFailure) {
          emit(StartNewConversationError(model: l.errorModel!));
        }
      },
      (model) => emit(StartNewConversationSuccess(model: model)),
    );
  }
}
