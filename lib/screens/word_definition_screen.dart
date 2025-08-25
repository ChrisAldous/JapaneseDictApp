import 'package:flutter/material.dart';
import 'package:japanese_dict/data/definitions.dart';
import 'package:kana_kit/kana_kit.dart';

class WordDefinitionScreen extends StatelessWidget {
  const WordDefinitionScreen({super.key, required this.the_word});

  final Definitions the_word;

  @override
  Widget build(BuildContext context) {
    final String kanji_word = the_word.words[0].word;
    final KanaKit kanaKit = KanaKit();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          backgroundColor: const Color.fromARGB(255, 210, 24, 11),
          title: Text(kanji_word),
        ),
      ),
      body: Column(
        children: [
          Text(kanaKit.toRomaji(the_word.words[0].reading))
        ],
      ),
    );
  }
}
