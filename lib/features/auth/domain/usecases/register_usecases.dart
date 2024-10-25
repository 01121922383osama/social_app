import 'package:fpdart/fpdart.dart';
import 'package:social_app/features/auth/domain/repositories/auth_repo.dart';

import '../../../../core/error/fialure_server.dart';

class RegisterUsecases {
  final AuthRepo _authRepo;
  RegisterUsecases({required AuthRepo auth}) : _authRepo = auth;

  Future<Either<FialureServer, String>> call({
    required String email,
    required String password,
  }) async {
    return await _authRepo.signUp(email: email, password: password);
  }
}
