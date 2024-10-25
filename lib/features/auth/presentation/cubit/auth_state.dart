part of 'auth_cubit.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {
  const AuthInitial();
  @override
  List<Object> get props => [];
}

final class AuthLoading extends AuthState {
  const AuthLoading();

  @override
  List<Object> get props => [];
}

final class AuthSuccess extends AuthState {
  const AuthSuccess();

  @override
  List<Object> get props => [];
}

final class AuthFailure extends AuthState {
  final String errorMessage;

  const AuthFailure({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
