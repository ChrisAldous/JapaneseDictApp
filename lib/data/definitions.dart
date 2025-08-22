class Definitions {
  late List<JapaneseList> words;
  late List<String> definition;
  int? id;

  Definitions({required this.words, required this.definition});

  Definitions.fromJSON(Map<String, dynamic> map) {
    List<dynamic> japaneseList = map['japanese'] ?? [];
    words = japaneseList.map((item) => JapaneseList.fromJSON(item)).toList();

    final List<dynamic> sensesList = map['senses'] ?? [];
    definition = sensesList
        .expand(
          (sense) => (sense['english_definitions'] as List).cast<String>(),
        )
        .toList();
  }

  @override
  String toString() => 'Definitions{japanese: $words, definition: $definition}';
}

class JapaneseList {
  final String word;
  final String reading;

  JapaneseList({required this.word, required this.reading});

  JapaneseList.fromJSON(Map<String, dynamic> map)
    : word = map['word'] ?? '',
      reading = map['reading'] ?? '';

  @override
  String toString() => 'JapaneseList{word: $word, reading: $reading}';
}
