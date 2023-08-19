part of 'words_cubit.dart';

sealed class WordsState extends Equatable {
  const WordsState();

  @override
  List<Object?> get props => [];
}

final class WordsInitial extends WordsState {}

final class WordsSuccess extends WordsState {
  final List<WordModel> words;

  const WordsSuccess({required this.words});

  @override
  List<Object> get props => [words];
}

final class WordsFailure extends WordsState {}
