import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recallapp/bloc/words/words_cubit.dart';
import 'package:recallapp/model/word_model.dart';

class WordsListItem extends StatelessWidget {
  final WordModel word;

  const WordsListItem({super.key, required this.word});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).cardColor,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
      clipBehavior: Clip.hardEdge,
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(18, 0, 4, 0),
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: Row(
            children: [
              Text(word.word, style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                flex: 5,
                child: Text(
                  '(${word.translationsAsString()})',
                  style: Theme.of(context).textTheme.bodySmall,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  maxLines: 3,
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  final WordsCubit wordsCubit = context.read<WordsCubit>();
                  wordsCubit.deleteWord(word);
                },
                icon: const Icon(Icons.close),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
