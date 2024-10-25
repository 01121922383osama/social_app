import 'package:fpdart/fpdart.dart';
import 'package:social_app/features/auth/domain/repositories/auth_repo.dart';

import '../../../../core/error/fialure_server.dart';

class LoginUsecases {
  final AuthRepo _authRepo;
  LoginUsecases({required AuthRepo auth}) : _authRepo = auth;

  Future<Either<FialureServer, String>> call({
    required String email,
    required String password,
  }) async {
    return await _authRepo.login(email: email, password: password);
  }
}
