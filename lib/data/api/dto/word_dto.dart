const maxTranslations = 2;

class WordDTO {
  final String word;
  final List<String> translations;
  final int successfulRecalls;

  WordDTO({
    required this.word,
    required this.translations,
    this.successfulRecalls = 0,
  });

  factory WordDTO.fromApi(Map<String, dynamic> map) {
    final word = map['def'][0]['text'];
    final List<String> translations = [];

    final List definitions = map['def'];

    // Change API?
    for (int i = 0; i < definitions.length; i++) {
      final List singleDefTranslations = definitions[i]['tr'];
      int translationsFromSingleDef = 0;
      for (var trs in singleDefTranslations) {
        if (translationsFromSingleDef > 0 && definitions.length - 1 > i) {
          translationsFromSingleDef = 0;
          break;
        }

        translations.add(trs['text']);
        translationsFromSingleDef += 1;

        if (translations.length >= maxTranslations) break;
      }
      if (translations.length >= maxTranslations) break;
    }

    return WordDTO(word: word, translations: translations);
  }

  WordDTO.fromDb(Map<String, dynamic> map)
      : word = map['word'],
        translations = map['translations'],
        successfulRecalls = map['successfulRecalls'];

  @override
  String toString() {
    return 'WordDTO: { word: $word, translations: $translations, successfulRecalls: $successfulRecalls }';
  }
}
