import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/features/chat/data/models/message_mode.dart';
import 'package:social_app/features/chat/domain/usecases/create_or_getchat_usecase.dart';
import 'package:social_app/features/chat/domain/usecases/get_stream_message_usecase.dart';

part 'creat_chat_state.dart';

class CreatChatCubit extends Cubit<CreatChatState> {
  final CreateOrGetchatUsecase _createOrGetchatUsecase;
  final GetStreamMessageUsecase _messageUsecase;
  CreatChatCubit({
    required CreateOrGetchatUsecase createOrGetchatUsecase,
    required GetStreamMessageUsecase messageUsecase,
  })  : _createOrGetchatUsecase = createOrGetchatUsecase,
        _messageUsecase = messageUsecase,
        super(const CreatChatInitial());

  Future<String> createChat(
      {required String userId1, required String userId2}) async {
    emit(const CreatChatLoading());
    final chatId = await _createOrGetchatUsecase.call(
      userId1: userId1,
      userId2: userId2,
    );
    getMessages(chatId: chatId);
    emit(CreatChatSuccess(chatId: chatId));
    return chatId;
  }

  Stream<List<MessageModel>> getMessages({required String chatId}) {
    return _messageUsecase.call(chatId: chatId);
  }
}
