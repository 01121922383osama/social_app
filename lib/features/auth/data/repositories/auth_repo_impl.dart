import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:social_app/core/error/fialure_server.dart';
import 'package:social_app/core/error/server_exception.dart';
import 'package:social_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:social_app/features/auth/domain/repositories/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDatasource _datasource;

  AuthRepoImpl({required AuthRemoteDatasource datasource})
      : _datasource = datasource;
  @override
  Future<Either<FialureServer, String>> login({
    required String email,
    required String password,
  }) async {
    final result = await _datasource.login(
      email: email,
      password: password,
    );
    try {
      return Right(result);
    } on ServerException catch (e) {
      return Left(FialureServer(errorMessage: e.errorMessage));
    }
  }

  @override
  Future<void> logout() async {
    await _datasource.logout();
  }

  @override
  Future<Either<FialureServer, String>> signUp({
    required String email,
    required String password,
  }) async {
    final result = await _datasource.signUp(email: email, password: password);
    try {
      return Right(result);
    } on ServerException catch (e) {
      return Left(FialureServer(errorMessage: e.errorMessage));
    }
  }

  @override
  Future<void> forGetPassword({required String email}) async {
    try {
      await _datasource.forGetPassword(email: email);
    } on ServerException catch (e) {
      throw ServerException(errorMessage: e.errorMessage);
    }
  }

  @override
  Future<UserCredential?> signInWithGoogle() async {
    try {
      return await _datasource.signInWithGoogle();
    } on ServerException catch (e) {
      throw ServerException(errorMessage: e.errorMessage);
    }
  }
}
