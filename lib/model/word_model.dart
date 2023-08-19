class WordModel {
  final String word;
  final List<String> translations;
  final int successfulRecalls;

  const WordModel({
    required this.word,
    required this.translations,
    this.successfulRecalls = 0,
  });

  @override
  String toString() {
    return 'WordModel: { word: $word, translations: $translations, recalls: $successfulRecalls }';
  }

  String translationsAsString() {
    final toString = translations.toString();
    return toString.substring(1, toString.length - 1);
  }

  WordModel copyWith({
    String? newWord,
    List<String>? newTranslations,
    int? newSuccessfulRecalls,
  }) {
    return WordModel(
      word: newWord ?? word,
      translations: newTranslations ?? translations,
      successfulRecalls: newSuccessfulRecalls ?? successfulRecalls,
    );
  }
}
