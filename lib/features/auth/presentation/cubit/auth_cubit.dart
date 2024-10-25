import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/core/error/server_exception.dart';
import 'package:social_app/features/auth/domain/usecases/forget_pass_usecase.dart';
import 'package:social_app/features/auth/domain/usecases/login_usecases.dart';
import 'package:social_app/features/auth/domain/usecases/login_with_google_usecase.dart';
import 'package:social_app/features/auth/domain/usecases/logout_usecases.dart';
import 'package:social_app/features/auth/domain/usecases/register_usecases.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUsecases _loginUsecases;
  final RegisterUsecases _registerUsecases;
  final LogoutUsecases _logoutUsecases;
  final ForgetPassUsecase _forgetPassUsecase;
  final LoginWithGoogleUsecase _loginWithGoogleUsecase;
  AuthCubit({
    required LoginUsecases loginUsecases,
    required RegisterUsecases registerUsecases,
    required LogoutUsecases logoutUsecases,
    required ForgetPassUsecase forgetPassUsecase,
    required LoginWithGoogleUsecase loginWithGoogleUsecase,
  })  : _loginUsecases = loginUsecases,
        _registerUsecases = registerUsecases,
        _logoutUsecases = logoutUsecases,
        _forgetPassUsecase = forgetPassUsecase,
        _loginWithGoogleUsecase = loginWithGoogleUsecase,
        super(const AuthInitial());

  final nameSignUp = TextEditingController();
  final emailSignUp = TextEditingController();
  final passwordSignUp = TextEditingController();
  final rePasswordSignUp = TextEditingController();
  final emailSignIn = TextEditingController();
  final passwordSignIn = TextEditingController();
  final forgetEmail = TextEditingController();

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(const AuthLoading());
    final result = await _loginUsecases.call(email: email, password: password);
    result.fold((l) {
      emit(AuthFailure(errorMessage: l.errorMessage));
    }, (r) {
      emit(const AuthSuccess());
    });
  }

  Future<void> register({
    required String email,
    required String password,
  }) async {
    emit(const AuthLoading());
    final result = await _registerUsecases.call(
      email: email,
      password: password,
    );
    result.fold((l) {
      emit(AuthFailure(errorMessage: l.errorMessage));
    }, (r) {
      emit(const AuthSuccess());
    });
  }

  Future<void> logout() async {
    await _logoutUsecases.call();
  }

  Future<void> forgetPassword({required String email}) async {
    try {
      await _forgetPassUsecase.call(email: email);
    } on ServerException catch (e) {
      emit(AuthFailure(errorMessage: e.errorMessage));
    }
  }

  void loginWithGoogle() async {
    try {
      await _loginWithGoogleUsecase.call();
      emit(const AuthSuccess());
    } on ServerException catch (e) {
      emit(AuthFailure(errorMessage: e.errorMessage));
    }
  }

  @override
  Future<void> close() {
    nameSignUp.clear();
    emailSignUp.clear();
    passwordSignUp.clear();
    rePasswordSignUp.clear();
    emailSignIn.clear();
    passwordSignIn.clear();
    forgetEmail.clear();
    return super.close();
  }
}
