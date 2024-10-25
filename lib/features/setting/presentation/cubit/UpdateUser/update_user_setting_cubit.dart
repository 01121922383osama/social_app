import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/features/auth/data/models/user_models.dart';
import 'package:social_app/features/setting/domain/usecases/update_userdata_usecase.dart';

part 'update_user_setting_state.dart';

class UpdateUserSettingCubit extends Cubit<UpdateUserSettingState> {
  final UpdateUserdataUsecase _userdataUsecase;
  UpdateUserSettingCubit({required UpdateUserdataUsecase userdata})
      : _userdataUsecase = userdata,
        super(UpdateUserSettingInitial());

  Future<void> updateUserData({required UserModel user}) async {
    emit(const UpdateUserLoading());
    final result = await _userdataUsecase.call(user: user);
    result.fold(
      (l) => emit(UpdateUserFailure(errorMessage: l.errorMessage)),
      (r) => emit(const UpdateUserSuccess()),
    );
  }
}
