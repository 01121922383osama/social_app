import 'package:social_app/features/chat/data/models/message_mode.dart';
import 'package:social_app/features/chat/domain/repositories/chat_repo.dart';

class GetStreamMessageUsecase {
  final ChatRepo _chatRepo;

  GetStreamMessageUsecase({required ChatRepo chatRepo}) : _chatRepo = chatRepo;

  Stream<List<MessageModel>> call({required String chatId}) {
    return _chatRepo.getMessages(chatId: chatId);
  }
}
