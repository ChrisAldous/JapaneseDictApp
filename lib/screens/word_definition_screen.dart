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
    final KanaKit kanaKit = KanaKit();

    for (JapaneseList obj in the_word.words) {
      print(obj);
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(backgroundColor: const Color.fromARGB(255, 210, 24, 11)),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                (kanji_word != null && kanji_word.isNotEmpty)
                    ? kanji_word
                    : kana_word,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              fixedLabeledRow('Hiragana', kana_word),
              fixedLabeledRow('Romaji', kanaKit.toRomaji(kana_word)),
            ],
          ),
        ),
      ),
    );
  }

  Widget fixedLabeledRow(String label, String content) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 100,
          child: Text(label, textAlign: TextAlign.left,),
        ),
        Flexible(child: Text(content))
      ],
    );
  }
}
