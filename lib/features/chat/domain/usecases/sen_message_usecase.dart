import 'package:social_app/features/chat/data/models/message_mode.dart';
import 'package:social_app/features/chat/domain/repositories/chat_repo.dart';

class SendMessageUsecase {
  final ChatRepo _chatRepo;

  SendMessageUsecase({required ChatRepo chatRepo}) : _chatRepo = chatRepo;
  Future<void> call({
    required String chatId,
    required MessageModel message,
  }) async {
    return await _chatRepo.sendMessage(
      chatId: chatId,
      message: message,
    );
  }
}
