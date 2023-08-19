import 'package:hive_flutter/adapters.dart';
import 'package:recallapp/data/api/dto/word_dto.dart';
import 'package:recallapp/data/api/service/db_service.dart';
import 'package:recallapp/model/word_model.dart';

class HiveService extends DbService {
  bool isInit = false;

  Future<void> initHive() async {
    if (!isInit) {
      await Hive.initFlutter();
      isInit = true;
    }
  }

  @override
  Future<WordDTO> getWord(String word) async {
    try {
      await initHive();

      final wordBox = Hive.isBoxOpen('words')
          ? Hive.box('words')
          : await Hive.openBox('words');

      final Map<String, dynamic> wordDetails = wordBox.get(word);

      return WordDTO.fromDb({
        'word': word,
        'translations': wordDetails['translations'],
        'successfulRecalls': wordDetails['successfulRecalls'],
      });
    } catch (err) {
      throw Exception(err);
    }
  }

  @override
  Future<List<WordDTO>> getAllWords() async {
    try {
      await initHive();

      final wordBox = Hive.isBoxOpen('words')
          ? Hive.box('words')
          : await Hive.openBox('words');

      final wordMap = wordBox.toMap();
      final List<WordDTO> allWords = [];

      wordMap.forEach((word, wordDetails) {
        allWords.add(WordDTO.fromDb({
          'word': word,
          'translations': wordDetails['translations'],
          'successfulRecalls': wordDetails['successfulRecalls'],
        }));
      });

      return allWords;
    } catch (err) {
      throw Exception(err);
    }
  }

  @override
  Future<void> saveWord(WordModel word) async {
    try {
      await initHive();

      final wordBox = Hive.isBoxOpen('words')
          ? Hive.box('words')
          : await Hive.openBox('words');

      return wordBox.put(word.word, {
        'translations': word.translations,
        'successfulRecalls': word.successfulRecalls,
      });
    } catch (err) {
      throw Exception(err);
    }
  }

  @override
  Future<void> deleteWord(WordModel word) async {
    try {
      await initHive();

      final wordBox = Hive.isBoxOpen('words')
          ? Hive.box('words')
          : await Hive.openBox('words');

      return wordBox.delete(word.word);
    } catch (err) {
      throw Exception(err);
    }
  }
}
