import 'package:recallapp/data/api/dto/word_dto.dart';
import 'package:recallapp/model/word_model.dart';

extension WordMapper on WordDTO {
  WordModel toDomain() {
    return WordModel(
      word: word,
      translations: translations,
      successfulRecalls: successfulRecalls,
    );
  }
}
