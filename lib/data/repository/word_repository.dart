import 'package:recallapp/data/api/dto/word_dto.dart';
import 'package:recallapp/data/api/request/word_query.dart';
import 'package:recallapp/data/api/service/api_service.dart';
import 'package:recallapp/data/api/service/db_service.dart';
import 'package:recallapp/data/mapper/word_mapper.dart';
import 'package:recallapp/model/word_model.dart';

class WordRepository {
  final ApiService api;
  final DbService db;

  WordRepository({required this.api, required this.db});

  Future<WordModel> searchWord({
    required String word,
  }) async {
    try {
      final body = WordQuery(word: word);
      final result = await api.searchWord(body);
      return result.toDomain();
    } catch (err) {
      throw Exception(err);
    }
  }

  Future<List<WordModel>> getAllWords() async {
    try {
      final List<WordDTO> allWords = await db.getAllWords();
      final List<WordModel> result = [];

      for (int i = 0; i < allWords.length; i++) {
        result.add(allWords[i].toDomain());
      }

      return result;
    } catch (err) {
      throw Exception(err);
    }
  }

  Future<WordModel> getWord(String word) async {
    try {
      final WordDTO result = await db.getWord(word);

      return result.toDomain();
    } catch (err) {
      throw Exception(err);
    }
  }

  Future<void> deleteWord(WordModel word) async {
    try {
      await db.deleteWord(word);
    } catch (err) {
      throw Exception(err);
    }
  }

  Future<void> saveWord(WordModel word) async {
    try {
      await db.saveWord(word);
    } catch (err) {
      throw Exception(err);
    }
  }
}
