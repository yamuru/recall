import 'package:recallapp/data/api/dto/word_dto.dart';
import 'package:recallapp/data/api/request/word_query.dart';

abstract class ApiService {
  Future<WordDTO> searchWord(WordQuery body);
}
