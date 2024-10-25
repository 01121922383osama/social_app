import 'package:social_app/features/auth/data/models/user_models.dart';
import 'package:social_app/features/chat/data/models/message_mode.dart';

abstract class ChatRepo {
  Stream<List<UserModel>> getUsers();
  Future<String> createOrGetChat({
    required String userId1,
    required String userId2,
  });
  Future<void> sendMessage({
    required String chatId,
    required MessageModel message,
  });
  Stream<List<MessageModel>> getMessages({required String chatId});
}
