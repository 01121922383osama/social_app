import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/features/auth/data/models/user_models.dart';
import 'package:social_app/features/chat/domain/usecases/get_stream_user_usecase.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final GetStreamUserUsecase _getStreamUserUsecase;
  ChatCubit({
    required GetStreamUserUsecase getStreamUserUsecase,
  })  : _getStreamUserUsecase = getStreamUserUsecase,
        super(const ChatInitial());
  void getUsers() async {
    emit(const ChatLoading());
    _getStreamUserUsecase.call().listen((users) {
      emit(ChatSuccess(users: users));
    }).onError((e) {
      emit(ChatFailure(message: e.toString()));
    });
  }
}
