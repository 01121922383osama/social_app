import 'package:flutter_bloc/flutter_bloc.dart';

class AuthToggle extends Cubit<int> {
  AuthToggle() : super(0);
  void toggle(int value) {
    emit(value);
  }
}

class AuthObsecureCubit extends Cubit<bool> {
  AuthObsecureCubit() : super(true);
  void change() {
    emit(!state);
  }
}
