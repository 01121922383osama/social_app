import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:social_app/core/error/fialure_server.dart';

abstract class AuthRepo {
  Future<Either<FialureServer, String>> login({
    required String email,
    required String password,
  });
  Future<Either<FialureServer, String>> signUp({
    required String email,
    required String password,
  });
  Future<void> logout();
  Future<void> forGetPassword({required String email});
  Future<UserCredential?> signInWithGoogle();
}
