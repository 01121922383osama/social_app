import 'package:flutter_bloc/flutter_bloc.dart';

class TriggerCubit extends Cubit<int> {
  TriggerCubit() : super(0);
  void trigger({required int page}) {
    emit(page);
  }
}
