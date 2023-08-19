import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:recallapp/data/repository/word_repository.dart';
import 'package:recallapp/model/word_model.dart';

part 'words_state.dart';

class WordsCubit extends Cubit<WordsState> {
  final WordRepository repository;

  WordsCubit({required this.repository}) : super(WordsInitial()) {
    refresh();
  }

  Future<void> refresh() async {
    try {
      final List<WordModel> words = await repository.getAllWords();
      emit(WordsSuccess(words: words));
    } catch (_) {
      emit(WordsFailure());
    }
  }

  Future<void> saveWord(WordModel word) async {
    try {
      await repository.saveWord(word);
      refresh();
    } catch (_) {
      emit(WordsFailure());
    }
  }

  Future<void> deleteWord(WordModel word) async {
    try {
      await repository.deleteWord(word);
      refresh();
    } catch (_) {
      emit(WordsFailure());
    }
  }
}
