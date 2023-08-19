import 'package:flutter/material.dart';
import 'package:recallapp/model/recall_round_model.dart';
import 'package:recallapp/model/word_model.dart';
import 'package:recallapp/presentation/widgets/recall_round_option.dart';

class RecallRound extends StatefulWidget {
  const RecallRound(
      {super.key, required this.round, this.answer, this.onAnswer});

  final RecallRoundModel round;
  final WordModel? answer;
  final Function(WordModel answer)? onAnswer;

  @override
  State<RecallRound> createState() => _RecallRoundState();
}

class _RecallRoundState extends State<RecallRound>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
      lowerBound: 0,
      upperBound: 1,
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 50, 0, 80),
          child: Card(
            color: Theme.of(context).canvasColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            clipBehavior: Clip.hardEdge,
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
              child: Text(
                widget.round.rightAnswer.translationsAsString(),
                style: Theme.of(context).textTheme.headlineSmall,
                overflow: TextOverflow.clip,
                softWrap: true,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        Expanded(
          child: AnimatedBuilder(
            animation: _animationController,
            child: GridView(
              padding: const EdgeInsets.all(2),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
              children: [
                for (final option in widget.round.options)
                  RecallRoundOption(
                    option: option,
                    isSelected: option.word == widget.answer?.word,
                    rightAnswer: widget.round.rightAnswer,
                    onSelected: (selectedOption) {
                      if (widget.onAnswer != null) {
                        widget.onAnswer!(selectedOption);
                      }
                    },
                  )
              ],
            ),
            builder: (context, child) => SlideTransition(
              position: Tween(
                begin: const Offset(0.5, 0),
                end: const Offset(0, 0),
              ).animate(
                CurvedAnimation(
                  parent: _animationController,
                  curve: Curves.easeInOut,
                ),
              ),
              child: child,
            ),
          ),
        ),
      ],
    );
  }
}
