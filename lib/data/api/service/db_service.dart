import 'package:recallapp/data/api/dto/word_dto.dart';
import 'package:recallapp/model/word_model.dart';

abstract class DbService {
  Future<WordDTO> getWord(String word);
  Future<List<WordDTO>> getAllWords();
  Future<void> saveWord(WordModel word);
  Future<void> deleteWord(WordModel word);
}
