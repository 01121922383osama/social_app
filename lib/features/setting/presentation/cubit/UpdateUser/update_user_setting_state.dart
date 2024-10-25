part of 'update_user_setting_cubit.dart';

sealed class UpdateUserSettingState extends Equatable {
  const UpdateUserSettingState();

  @override
  List<Object> get props => [];
}

final class UpdateUserSettingInitial extends UpdateUserSettingState {}

final class UpdateUserLoading extends UpdateUserSettingState {
  const UpdateUserLoading();
}

final class UpdateUserSuccess extends UpdateUserSettingState {
  const UpdateUserSuccess();
}

final class UpdateUserFailure extends UpdateUserSettingState {
  final String errorMessage;
  const UpdateUserFailure({required this.errorMessage});
}
