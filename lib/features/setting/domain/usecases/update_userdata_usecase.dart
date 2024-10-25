import 'package:fpdart/fpdart.dart';
import 'package:social_app/core/error/fialure_server.dart';
import 'package:social_app/features/auth/data/models/user_models.dart';
import 'package:social_app/features/setting/domain/repositories/setting_repo.dart';

class UpdateUserdataUsecase {
  final SettingRepo _repo;

  UpdateUserdataUsecase({required SettingRepo repo}) : _repo = repo;

  Future<Either<FialureServer, void>> call({required UserModel user}) async {
    return await _repo.updateUserData(user: user);
  }
}
