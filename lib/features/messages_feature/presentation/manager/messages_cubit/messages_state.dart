part of 'messages_cubit.dart';

sealed class MessagesState extends Equatable {
  const MessagesState();

  @override
  List<Object> get props => [];
}

final class MessagesInitial extends MessagesState {}

final class SearchingMessage extends MessagesState {
  final List<StartMessageModel> messages;

  const SearchingMessage({required this.messages});

  @override
  List<Object> get props => [messages];
}

final class FetchStartMessagesLoading extends MessagesState {}

final class FetchStartMessagesError extends MessagesState {
  final ResponseModel responseModel;

  const FetchStartMessagesError({required this.responseModel});

  @override
  List<Object> get props => [responseModel];
}

final class FetchStartMessagesSuccess extends MessagesState {
  final List<StartMessageModel> messages;

  const FetchStartMessagesSuccess({required this.messages});

  @override
  List<Object> get props => [messages];
}
