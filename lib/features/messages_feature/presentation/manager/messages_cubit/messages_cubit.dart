import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:oralsync/core/cache_helper/cache_storage.dart';
import 'package:oralsync/core/cache_helper/shared_prefs_keys.dart';
import 'package:oralsync/core/error/error_model.dart';
import 'package:oralsync/core/error/failure.dart';
import 'package:oralsync/features/Auth/data/models/user_model.dart';
import 'package:oralsync/features/messages_feature/data/repo/messages_repo.dart';

import '../../../data/models/start_message_model.dart';

part 'messages_state.dart';

class MessagesCubit extends Cubit<MessagesState> {
  MessagesCubit({
    required this.messagesRepo,
    required this.cacheStorage,
  }) : super(MessagesInitial());
  final MessagesRepo messagesRepo;

  final CacheStorage cacheStorage;
  List<StartMessageModel> messages = [];
  bool isSearched = false;
  List<StartMessageModel> searchingMessages = [];
  final searchController = TextEditingController();

  Future<void> getStartMessages() async {
    messages.clear();
    emit(FetchStartMessagesLoading());
    var res = await messagesRepo.getAllStartMessages();
    res.fold((failure) {
      if (failure is OfflineFailure) {
        emit(FetchStartMessagesError(responseModel: failure.model!));
      } else if (failure is ServerFailure) {
        emit(FetchStartMessagesError(responseModel: failure.errorModel!));
      }
    }, (messages) {
      this.messages = messages;
      emit(FetchStartMessagesSuccess(messages: messages));
    });
  }

  void searchMessages(String text) {
    searchingMessages = checkRole() ? messages
        .where((element) =>
    element.sender?.name?.toUpperCase().contains(text.toUpperCase()) ??
        false)
        .toList() : messages
        .where((element) =>
    element.receiver?.name?.toUpperCase().contains(text.toUpperCase()) ??
        false)
        .toList();
    emit(SearchingMessage(messages: searchingMessages));
  }

  bool checkRole() {
    var userJson = cacheStorage.getData(key: SharedPrefsKeys.user);
    var userDecoded = json.decode(userJson);
    var user = UserModel.fromJson(userDecoded);
    var role = user.userRole?.toUpperCase() ?? '';
    if (role == 'Doctor'.toUpperCase() || role == 'Student'.toUpperCase()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<void> close() {
    searchController.dispose();
    return super.close();
  }
}
