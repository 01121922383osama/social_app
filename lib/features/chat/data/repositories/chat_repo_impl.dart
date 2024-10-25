import 'package:social_app/features/auth/data/models/user_models.dart';
import 'package:social_app/features/chat/data/datasources/remote/chat_remote_data_source.dart';
import 'package:social_app/features/chat/data/models/message_mode.dart';
import 'package:social_app/features/chat/domain/repositories/chat_repo.dart';

class ChatRepoImpl extends ChatRepo {
  final ChatRemoteDataSource _chatRemoteDataSource;

  ChatRepoImpl({required ChatRemoteDataSource chatRemoteDataSource})
      : _chatRemoteDataSource = chatRemoteDataSource;
  @override
  Future<String> createOrGetChat({
    required String userId1,
    required String userId2,
  }) async {
    return await _chatRemoteDataSource.createOrGetChat(
      userId1: userId1,
      userId2: userId2,
    );
  }

  @override
  Stream<List<MessageModel>> getMessages({required String chatId}) {
    return _chatRemoteDataSource.getMessages(chatId: chatId);
  }

  @override
  Stream<List<UserModel>> getUsers() {
    return _chatRemoteDataSource.getUsers();
  }

  @override
  Future<void> sendMessage({
    required String chatId,
    required MessageModel message,
  }) async {
    await _chatRemoteDataSource.sendMessage(
      chatId: chatId,
      message: message,
    );
  }
}
