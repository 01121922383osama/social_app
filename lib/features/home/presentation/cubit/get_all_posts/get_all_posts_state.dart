part of 'get_all_posts_cubit.dart';

sealed class GetAllPostsState extends Equatable {
  const GetAllPostsState();

  @override
  List<Object> get props => [];
}

final class GetAllPostsInitial extends GetAllPostsState {
  const GetAllPostsInitial();
}

final class GetAllPostsLoading extends GetAllPostsState {
  const GetAllPostsLoading();
}

final class GetAllPostsSuccess extends GetAllPostsState {
  final List<PostModel> posts;

  const GetAllPostsSuccess({required this.posts});

  @override
  List<Object> get props => [posts];
}

final class GetAllPostsFailure extends GetAllPostsState {
  final String errorMessage;

  const GetAllPostsFailure({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
