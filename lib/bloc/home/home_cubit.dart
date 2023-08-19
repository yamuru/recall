import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:recallapp/bloc/words/words_cubit.dart';
import 'package:recallapp/data/repository/word_repository.dart';
import 'package:recallapp/model/word_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final WordRepository repository;
  final WordsCubit wordsCubit;

  HomeCubit({
    required this.repository,
    required this.wordsCubit,
  }) : super(HomeInitial());

  Future<WordModel?> searchWordDb(String word) async {
    final wordsState = wordsCubit.state;
    if (wordsState is WordsSuccess) {
      final index = wordsState.words
          .indexWhere((WordModel wordModel) => wordModel.word == word);

      if (index != -1) {
        return wordsState.words[index];
      }
    }
    return null;
  }

  Future<WordModel> searchWordApi(String word) async {
    return await repository.searchWord(word: word);
  }

  Future<void> searchWord(String word) async {
    try {
      emit(HomeSearchInProgress());

      WordModel result;

      // Searching in db first, returning with isSaved = true if found
      final WordModel? possibleWordInDb = await searchWordDb(word);

      if (possibleWordInDb != null) {
        result = possibleWordInDb;
        emit(HomeSuccess(result: result, isSaved: true));
      } else {
        result = await searchWordApi(word);
        emit(HomeSuccess(result: result));
      }
    } catch (_) {
      emit(HomeFailure());
    }
  }

  Future<void> saveWord(WordModel word) async {
    try {
      await wordsCubit.saveWord(word);
      emit(HomeSuccess(result: word, isSaved: true));
    } catch (_) {
      emit(HomeFailure());
    }
  }
}
