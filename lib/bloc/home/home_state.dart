part of 'home_cubit.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

final class HomeInitial extends HomeState {}

final class HomeSearchInProgress extends HomeState {}

final class HomeSuccess extends HomeState {
  final WordModel result;
  final bool isSaved;

  const HomeSuccess({required this.result, this.isSaved = false});

  @override
  List<Object?> get props => [result, isSaved];
}

final class HomeFailure extends HomeState {}
