import 'package:flutter/material.dart';
import 'package:japanese_dict/data/definitions.dart';
import 'package:kana_kit/kana_kit.dart';

class WordDefinitionScreen extends StatelessWidget {
  const WordDefinitionScreen({super.key, required this.the_word});

  final Definitions the_word;

  @override
  Widget build(BuildContext context) {
    final String kanji_word = the_word.words[0].word;
    final String kana_word = the_word.words[0].reading;
    final List<String> definitions = the_word.definition;
    final KanaKit kanaKit = KanaKit();
    // print(the_word);
    // print("-----------");
    // print(the_word.definition);

    for (JapaneseList obj in the_word.words) {
      print(obj);
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(backgroundColor: const Color.fromARGB(255, 210, 24, 11)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                (kanji_word != null && kanji_word.isNotEmpty)
                    ? kanji_word
                    : kana_word,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),

            fixedLabeledRow('Kana', kana_word),
            fixedLabeledRow('Romaji', kanaKit.toRomaji(kana_word)),

            Text(
              'Meanings:',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                definitions.map((word) => '$word').join(', '),
                style: TextStyle(fontSize: 16,), 
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget fixedLabeledRow(String label, String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Text(
              content,
              textAlign: TextAlign.right,
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
