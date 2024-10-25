import 'package:social_app/features/auth/data/models/user_models.dart';
import 'package:social_app/features/chat/domain/repositories/chat_repo.dart';

class GetStreamUserUsecase {
  final ChatRepo _chatRepo;

  GetStreamUserUsecase({required ChatRepo chatRepo}) : _chatRepo = chatRepo;

  Stream<List<UserModel>> call() {
    return _chatRepo.getUsers();
  }
}
