part of 'send_message_cubit.dart';

sealed class SendMessageState extends Equatable {
  const SendMessageState();

  @override
  List<Object> get props => [];
}

final class SendMessageInitial extends SendMessageState {
  const SendMessageInitial();

  @override
  List<Object> get props => [];
}

final class SendMessageLoading extends SendMessageState {
  const SendMessageLoading();

  @override
  List<Object> get props => [];
}

final class SendMessageSuccess extends SendMessageState {
  final MessageModel message;

  const SendMessageSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

final class SendMessageFailure extends SendMessageState {
  final String errorMessage;

  const SendMessageFailure({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
