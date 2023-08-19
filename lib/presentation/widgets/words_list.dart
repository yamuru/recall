import 'package:flutter/material.dart';
import 'package:recallapp/model/word_model.dart';
import 'package:recallapp/presentation/widgets/words_list_item.dart';

class WordsList extends StatelessWidget {
  final List<WordModel> words;

  const WordsList({super.key, required this.words});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: words.length,
          itemBuilder: (ctx, index) {
            return WordsListItem(word: words[index]);
          }),
    );
  }
}
