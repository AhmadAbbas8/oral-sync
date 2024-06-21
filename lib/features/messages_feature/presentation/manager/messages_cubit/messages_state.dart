part of 'messages_cubit.dart';

sealed class MessagesState extends Equatable {
  const MessagesState();

  @override
  List<Object> get props => [];
}

final class MessagesInitial extends MessagesState {}

final class SearchingMessage extends MessagesState {
  final List<StartMessageModel> messages;

  SearchingMessage({required this.messages});

  @override
  // TODO: implement props
  List<Object> get props => [messages];
}

final class FetchStartMessagesLoading extends MessagesState {}

final class FetchStartMessagesError extends MessagesState {
  final ResponseModel responseModel;

  FetchStartMessagesError({required this.responseModel});

  @override
  // TODO: implement props
  List<Object> get props => [responseModel];
}

final class FetchStartMessagesSuccess extends MessagesState {
  final List<StartMessageModel> messages;

  FetchStartMessagesSuccess({required this.messages});

  @override
  // TODO: implement props
  List<Object> get props => [messages];
}
