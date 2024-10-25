import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/features/chat/data/models/message_mode.dart';
import 'package:social_app/features/chat/domain/usecases/sen_message_usecase.dart';

part 'send_message_state.dart';

class SendMessageCubit extends Cubit<SendMessageState> {
  final SendMessageUsecase _messageUsecase;
  SendMessageCubit({
    required SendMessageUsecase messageUsecase,
  })  : _messageUsecase = messageUsecase,
        super(const SendMessageInitial());

  void sendMessage({
    required String chatId,
    required MessageModel message,
  }) async {
    try {
      emit(const SendMessageLoading());
      await _messageUsecase.call(
        chatId: chatId,
        message: message,
      );
    } catch (e) {
      emit(SendMessageFailure(errorMessage: e.toString()));
    }
  }
}
