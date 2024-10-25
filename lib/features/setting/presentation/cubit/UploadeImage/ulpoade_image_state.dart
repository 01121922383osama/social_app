part of 'ulpoade_image_cubit.dart';

sealed class UlpoadeImageState extends Equatable {
  const UlpoadeImageState();

  @override
  List<Object> get props => [];
}

final class UlpoadeImageInitial extends UlpoadeImageState {}

final class UlpoadeImageSuccess extends UlpoadeImageState {
  final String success;

  const UlpoadeImageSuccess({required this.success});

  @override
  List<Object> get props => [success];
}

final class UlpoadeImageFailure extends UlpoadeImageState {
  final String errorMessage;
  const UlpoadeImageFailure({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
