import 'package:social_app/features/auth/domain/repositories/auth_repo.dart';

class LoginWithGoogleUsecase {
  final AuthRepo _authRepo;

  LoginWithGoogleUsecase({required AuthRepo authRepo}) : _authRepo = authRepo;

  Future<void> call() async {
    await _authRepo.signInWithGoogle();
  }
}
