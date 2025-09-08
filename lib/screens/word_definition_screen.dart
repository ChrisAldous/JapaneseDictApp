import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:japanese_dict/data/db_helper.dart';
import 'package:japanese_dict/data/definitions.dart';
import 'package:japanese_dict/data/definitions_service.dart';
import 'package:kana_kit/kana_kit.dart';
import 'package:japanese_dict/data/tables/visited_word.dart';
import 'package:japanese_dict/data/daos/visited_word_dao.dart';
import 'package:provider/provider.dart';

class WordDefinitionScreen extends StatefulWidget {
  const WordDefinitionScreen({super.key, required this.the_word});

  final Definitions the_word;

  @override
  State<WordDefinitionScreen> createState() => _WordDefinitionScreenState();
}

class _WordDefinitionScreenState extends State<WordDefinitionScreen> {
  late DbHelper db;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      db = context.read<DbHelper>();
      _saveVisitedWord();
    });
  }

  Future<void> _saveVisitedWord() async {
    final word = widget.the_word;
    final kanji = word.words[0].word;
    final kana = word.words[0].reading;
    final definition = word.definition.join(', ');

    final kanjiToAdd = kanji.isNotEmpty ? kanji : '';

    final exists = await db.visitedWordDao.recordExists(
      kanji: kanjiToAdd,
      kana: kana,
    );

    if (!exists) {
      final visitedWord = VisitedWordCompanion.insert(
        kanji: kanji.isNotEmpty ? drift.Value(kanji) : drift.Value.absent(),
        kana: kana,
        definition: definition,
      );

      await db.visitedWordDao.insertVisitedWord(visitedWord);
    }
  }

  @override
  Widget build(BuildContext context) {
    final DefinitionsService definitionsService = DefinitionsService(
      definitions: widget.the_word,
    );
    final String kanji_word = widget.the_word.words[0].word;
    final String kana_word = widget.the_word.words[0].reading;
    final List<String> definitions = widget.the_word.definition;
    final KanaKit kanaKit = KanaKit();

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
                style: TextStyle(fontSize: 16),
              ),
            ),

            Text(
              'Other Readings:',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            Text(
              definitionsService
                  .giveOtherReadings()
                  .map((word) => '$word')
                  .join('\n'),
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          db.printVisitedWords();
        },
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
