import 'package:flutter/material.dart';
import 'package:recallapp/model/word_model.dart';

class RecallRoundOption extends StatelessWidget {
  const RecallRoundOption({
    super.key,
    required this.option,
    required this.onSelected,
    required this.isSelected,
    required this.rightAnswer,
  });

  final WordModel option;
  final Function(WordModel selectedOption) onSelected;
  final bool isSelected;
  final WordModel rightAnswer;

  @override
  Widget build(BuildContext context) {
    Color cardColor = Theme.of(context).canvasColor;

    if (isSelected && option.word == rightAnswer.word) {
      cardColor = Colors.green.shade500;
    } else if (isSelected && option.word != rightAnswer.word) {
      cardColor = Colors.deepOrange.shade400;
    }

    return InkWell(
      onTap: () {
        onSelected(option);
      },
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(16),
      child: Card(
        color: cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        clipBehavior: Clip.hardEdge,
        elevation: 4,
        child: Center(
          child: Text(
            option.word,
            style: Theme.of(context).textTheme.headlineSmall,
            overflow: TextOverflow.clip,
            softWrap: true,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
