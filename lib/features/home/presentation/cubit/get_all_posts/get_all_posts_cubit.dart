import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/features/home/data/models/post.dart';
import 'package:social_app/features/home/domain/usecases/get_all_post_usecase.dart';

part 'get_all_posts_state.dart';

class GetAllPostsCubit extends Cubit<GetAllPostsState> {
  final GetAllPostUseCase _allPostUseCase;
  GetAllPostsCubit({required GetAllPostUseCase allPostUseCase})
      : _allPostUseCase = allPostUseCase,
        super(const GetAllPostsInitial());
  Future<List<PostModel>> getAllPosts() async {
    emit(const GetAllPostsLoading());
    final posts = await _allPostUseCase.call();
    return posts.fold(
      (l) {
        emit(GetAllPostsFailure(errorMessage: l.errorMessage));
        return [];
      },
      (r) {
        emit(GetAllPostsSuccess(posts: r));
        return r;
      },
    );
  }
}
