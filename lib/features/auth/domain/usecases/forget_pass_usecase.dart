import 'package:social_app/features/auth/domain/repositories/auth_repo.dart';

class ForgetPassUsecase {
  final AuthRepo _authRepo;

  ForgetPassUsecase({required AuthRepo authRepo}) : _authRepo = authRepo;

  Future<void> call({required String email}) async {
    return await _authRepo.forGetPassword(email: email);
  }
}
