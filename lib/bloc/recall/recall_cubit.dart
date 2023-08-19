import 'dart:async';
import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:recallapp/bloc/words/words_cubit.dart';
import 'package:recallapp/model/recall_round_model.dart';
import 'package:recallapp/model/word_model.dart';

part 'recall_state.dart';

class RecallCubit extends Cubit<RecallState> {
  StreamSubscription? wordsStreamSub;
  final WordsCubit wordsCubit;

  FlutterTts flutterTts = FlutterTts();

  RecallCubit({required this.wordsCubit, this.wordsStreamSub})
      : super(RecallInitial()) {
    flutterTts.isLanguageAvailable("en-US").then((isEnglishAvailable) {
      if (isEnglishAvailable) flutterTts.setLanguage('en-US');
    });

    wordsStreamSub = wordsCubit.stream.listen((state) async {
      if (state is WordsSuccess && state.words.length < 4) {
        emit(RecallImpossible());
      } else {
        initRecallRound();
      }
    });
  }

  Future<void> initRecallRound() async {
    final WordsState wordsState = wordsCubit.state;

    if (wordsState is WordsSuccess) {
      const numberOfOptions = 4;
      List<WordModel> options = [];

      final List<WordModel> words = List.from(wordsState.words);
      words.sort(
          (el1, el2) => el1.successfulRecalls.compareTo(el2.successfulRecalls));

      final rightAnswer = words.removeAt(
        Random().nextInt(3) + (words.length - 3),
      );
      options.add(rightAnswer);

      for (int i = 0; i < numberOfOptions - 1; i++) {
        options.add(words.removeAt(Random().nextInt(words.length)));
      }

      options.shuffle();

      emit(
        RecallRoundInProgress(
          round: RecallRoundModel(
            options: options,
            rightAnswer: options[Random().nextInt(options.length)],
          ),
        ),
      );
    }
  }

  Future<void> processRecallRoundAnswer(
    RecallRoundModel round,
    WordModel answer,
  ) async {
    flutterTts.speak(answer.word);
    emit(RecallAnswered(round: round, answer: answer));

    await Future.delayed(const Duration(milliseconds: 1500));

    if (round.rightAnswer.word == answer.word) {
      wordsCubit.saveWord(
        answer.copyWith(newSuccessfulRecalls: answer.successfulRecalls + 1),
      );
    } else {
      initRecallRound();
    }
  }
}
