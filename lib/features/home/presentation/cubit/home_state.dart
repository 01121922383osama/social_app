part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {
  const HomeInitial();

  @override
  List<Object> get props => [];
}

class HomeLoading extends HomeState {
  const HomeLoading();
  @override
  List<Object> get props => [];
}

class HomeSuccess extends HomeState {
  final PostModel post;
  const HomeSuccess({required this.post});
  @override
  List<Object> get props => [post];
}

class HomeFailure extends HomeState {
  final String errorMessage;

  const HomeFailure({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
