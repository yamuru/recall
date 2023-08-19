import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recallapp/bloc/words/words_cubit.dart';
import 'package:recallapp/presentation/widgets/words_list.dart';

class MyVocabularyScreen extends StatelessWidget {
  const MyVocabularyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WordsCubit, WordsState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 15,
          ),
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  child: Text(
                    'Мой словарь',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                if (state is WordsSuccess && state.words.isNotEmpty)
                  WordsList(words: state.words)
                else
                  const Text('Слова не найдены'),
              ],
            ),
          ),
        );
      },
    );
  }
}
