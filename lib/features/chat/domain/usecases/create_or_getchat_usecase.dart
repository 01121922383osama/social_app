import 'package:social_app/features/chat/domain/repositories/chat_repo.dart';

class CreateOrGetchatUsecase {
  final ChatRepo _chatRepo;

  CreateOrGetchatUsecase({required ChatRepo chatRepo}) : _chatRepo = chatRepo;

  Future<String> call({
    required String userId1,
    required String userId2,
  }) async {
    return await _chatRepo.createOrGetChat(
      userId1: userId1,
      userId2: userId2,
    );
  }
}
