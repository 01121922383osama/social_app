import 'package:social_app/features/auth/domain/repositories/auth_repo.dart';

class LogoutUsecases {
  final AuthRepo _authRepo;

  LogoutUsecases({required AuthRepo authRepo}) : _authRepo = authRepo;
  Future<void> call() async {
    await _authRepo.logout();
  }
}
