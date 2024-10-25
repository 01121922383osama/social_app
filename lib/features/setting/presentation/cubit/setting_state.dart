part of 'setting_cubit.dart';

abstract class SettingState extends Equatable {
  const SettingState();

  @override
  List<Object> get props => [];
}

class SettingInitial extends SettingState {}

class SettingLoading extends SettingState {
  const SettingLoading();
}

class SettingSuccess extends SettingState {
  final UserModel userModel;
  const SettingSuccess({required this.userModel});
}

class SettingFailure extends SettingState {
  final String errorMessage;
  const SettingFailure({required this.errorMessage});
}
