import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/features/home/data/models/post.dart';
import 'package:social_app/features/home/domain/usecases/upload_post_usecase.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final UploadPostUsecase _postUsecase;
  HomeCubit({
    required UploadPostUsecase postUsecase,
  })  : _postUsecase = postUsecase,
        super(const HomeInitial());
  Future<void> uploadPost({required PostModel post}) async {
    emit(const HomeLoading());
    final result = await _postUsecase.call(post: post);
    result.fold(
      (l) => emit(HomeFailure(errorMessage: l.errorMessage)),
      (r) => emit(HomeSuccess(post: r)),
    );
  }
}
