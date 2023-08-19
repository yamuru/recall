import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:recallapp/data/api/dto/word_dto.dart';
import 'package:recallapp/data/api/request/word_query.dart';
import 'package:recallapp/data/api/service/api_service.dart';

class DictionaryService extends ApiService {
  static const _baseURL =
      'https://dictionary.yandex.net/api/v1/dicservice.json/';

  final Dio _dio = Dio(
    BaseOptions(baseUrl: _baseURL),
  )..interceptors.add(PrettyDioLogger());

  @override
  Future<WordDTO> searchWord(WordQuery body) async {
    try {
      final response = await _dio.get(
        '/lookup',
        queryParameters: body.toApi(),
      );

      return WordDTO.fromApi(response.data);
    } catch (err) {
      throw Exception(err);
    }
  }
}
