import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:social_app/core/error/fialure_server.dart';
import 'package:social_app/features/setting/domain/repositories/setting_repo.dart';

class UlpoadeImageUsecase {
  final SettingRepo _repo;

  UlpoadeImageUsecase({required SettingRepo repo}) : _repo = repo;

  Future<Either<FialureServer, String>> call(
      {required String userId,
      required File file,
      required String path}) async {
    return await _repo.ulpoadeImage(userId: userId, file: file, path: path);
  }
}
