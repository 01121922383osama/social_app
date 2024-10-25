part of 'creat_chat_cubit.dart';

sealed class CreatChatState extends Equatable {
  const CreatChatState();

  @override
  List<Object> get props => [];
}

final class CreatChatInitial extends CreatChatState {
  const CreatChatInitial();

  @override
  List<Object> get props => [];
}

final class CreatChatLoading extends CreatChatState {
  const CreatChatLoading();

  @override
  List<Object> get props => [];
}

final class CreatChatSuccess extends CreatChatState {
  final String chatId;
  const CreatChatSuccess({required this.chatId});

  @override
  List<Object> get props => [chatId];
}

final class CreatChatFailure extends CreatChatState {
  final String message;
  const CreatChatFailure({required this.message});

  @override
  List<Object> get props => [message];
}
