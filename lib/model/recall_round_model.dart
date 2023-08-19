import 'package:recallapp/model/word_model.dart';

class RecallRoundModel {
  final List<WordModel> options;
  final WordModel rightAnswer;

  const RecallRoundModel({
    required this.options,
    required this.rightAnswer,
  });
}
