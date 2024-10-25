import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/features/setting/domain/usecases/get_user_data_usecase.dart';

import '../../../auth/data/models/user_models.dart';

part 'setting_state.dart';

class SettingCubit extends Cubit<SettingState> {
  final GetUserDataUsecase _dataUsecase;
  SettingCubit({required GetUserDataUsecase dataUsecase})
      : _dataUsecase = dataUsecase,
        super(SettingInitial());

  Future<void> getUserData() async {
    emit(const SettingLoading());
    final result = await _dataUsecase.call();
    result.fold(
      (l) => emit(SettingFailure(errorMessage: l.errorMessage)),
      (r) => emit(SettingSuccess(userModel: r)),
    );
  }
}
