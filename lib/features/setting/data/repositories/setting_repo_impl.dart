import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:social_app/core/error/fialure_server.dart';
import 'package:social_app/features/auth/data/models/user_models.dart';
import 'package:social_app/features/setting/data/datasources/remoteDataSouce/setting_remote_data_source.dart';
import 'package:social_app/features/setting/domain/repositories/setting_repo.dart';

class SettingRepoImpl implements SettingRepo {
  final SettingRemoteDataSource _dataSource;

  SettingRepoImpl({required SettingRemoteDataSource dataSource})
      : _dataSource = dataSource;
  @override
  Future<Either<FialureServer, UserModel>> getUserData() {
    return _dataSource.getUserData();
  }

  @override
  Future<Either<FialureServer, void>> updateUserData(
      {required UserModel user}) async {
    return _dataSource.updateUserData(user: user);
  }

  @override
  Future<Either<FialureServer, String>> ulpoadeImage(
      {required String userId, required File file , required String path}) async {
    return await _dataSource.ulpoadeImage(userId: userId, file: file , path: path);
  }
}
