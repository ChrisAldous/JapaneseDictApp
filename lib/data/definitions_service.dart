import 'definitions.dart';

class DefinitionsService {
  Definitions definitions;
  late List<JapaneseList> readingsList;

  DefinitionsService({required this.definitions}) {
    readingsList = definitions.words;
  }

  int readingsSize(List<JapaneseList> readingsList) {
    return readingsList.length;
  }

  List<String> giveOtherReadings() {
    if (readingsSize(readingsList) != 1) {
      List<JapaneseList> otherReadings = readingsList.sublist(1);
      return otherReadings.map((word) {
        String kanji = word.word;
        String kana = word.reading;
        return "$kanji: $kana";
      }).toList();
    } else {
      return [];
    }
  }
}
