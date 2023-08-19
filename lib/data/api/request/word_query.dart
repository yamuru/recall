import 'package:recallapp/util/env.dart';

class WordQuery {
  final String word;

  WordQuery({
    required this.word,
  });

  Map<String, dynamic> toApi() {
    return {
      'key': Env.apiKey,
      'text': word,
      'lang': 'en-ru',
    };
  }
}
