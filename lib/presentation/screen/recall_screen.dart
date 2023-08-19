import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recallapp/bloc/recall/recall_cubit.dart';
import 'package:recallapp/bloc/words/words_cubit.dart';
import 'package:recallapp/presentation/widgets/recall_round.dart';

class RecallScreen extends StatelessWidget {
  const RecallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final RecallCubit recallCubit = RecallCubit(
      wordsCubit: context.read<WordsCubit>(),
    );

    return BlocBuilder<RecallCubit, RecallState>(
      bloc: recallCubit,
      builder: (context, state) {
        Widget mainContent = const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Загрузка...',
            textAlign: TextAlign.center,
          ),
        );

        if (state is RecallImpossible) {
          mainContent = const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Нужно как минимум 4 слова в словаре для Recall-сессии',
              textAlign: TextAlign.center,
            ),
          );
        }

        if (state is RecallRoundInProgress) {
          mainContent = RecallRound(
            round: state.round,
            onAnswer: (answer) {
              recallCubit.processRecallRoundAnswer(state.round, answer);
            },
          );
        }

        if (state is RecallAnswered) {
          mainContent = RecallRound(
            round: state.round,
            answer: state.answer,
          );
        }

        return Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 40,
            horizontal: 15,
          ),
          child: Center(
            child: mainContent,
          ),
        );
      },
    );
  }
}
