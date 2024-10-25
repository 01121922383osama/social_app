part of 'chat_cubit.dart';

sealed class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

final class ChatInitial extends ChatState {
  const ChatInitial();

  @override
  List<Object> get props => [];
}

final class ChatLoading extends ChatState {
  const ChatLoading();
  @override
  List<Object> get props => [];
}

final class ChatSuccess extends ChatState {
  final List<UserModel> users;

  const ChatSuccess({required this.users});

  @override
  List<Object> get props => [users];
}

final class ChatFailure extends ChatState {
  final String message;

  const ChatFailure({required this.message});
  @override
  List<Object> get props => [];
}
