import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:social_app/features/auth/data/models/user_models.dart';

import '../../../../core/error/fialure_server.dart';

abstract class SettingRepo {
  Future<Either<FialureServer, UserModel>> getUserData();
  Future<Either<FialureServer, void>> updateUserData({required UserModel user});
  Future<Either<FialureServer, String>> ulpoadeImage({
    required String userId,
    required File file,
    required String path,
  });
}
