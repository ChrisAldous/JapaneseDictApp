class Definitions {
  late List<JapaneseList> words;
  late List<String> definition;
  int? id;

  Definitions({required this.words, required this.definition});

  Definitions.fromJSON(Map<String, dynamic> map) {
    List<dynamic> japaneseList = map['japanese'] ?? [];
    words = japaneseList.map((item) => JapaneseList.fromJSON(item)).toList();
    words = combineReadings();

    final List<dynamic> sensesList = map['senses'] ?? [];
    definition = sensesList
        .expand(
          (sense) => (sense['english_definitions'] as List).cast<String>(),
        )
        .toList();
  }

  List<JapaneseList> combineReadings() {
    List<JapaneseList> result = [];
    for (int i = 0; i < words.length; i++) {
      JapaneseList currentItem = words[i];

      if (i != 0) {
        if (currentItem.word == result.last.word) {
          final combinedReadings = result.last.reading;
          final addedReading = currentItem.reading;
          result.last.reading = '$combinedReadings, $addedReading';
        } else {
          result.add(currentItem);
        }
      } else {
        result.add(currentItem);
      }
    }
    print(result);
    return result;
  }

  @override
  String toString() => 'Definitions{japanese: $words, definition: $definition}';
}

class JapaneseList {
  final String word;
  String reading;

  JapaneseList({required this.word, required this.reading});

  JapaneseList.fromJSON(Map<String, dynamic> map)
    : word = map['word'] ?? '',
      reading = map['reading'] ?? '';

  @override
  String toString() => 'JapaneseList{word: $word, reading: $reading}';
}
