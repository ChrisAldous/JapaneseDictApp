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
  late TextEditingController controller;
  int? visitedWordId;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    Future.microtask(() async {
      db = context.read<DbHelper>();
      await _saveVisitedWord();
      await _loadNoteIfExists();
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

    final visited = await db.visitedWordDao.getVisitedWord(kanji, kana);
    visitedWordId = visited?.id;
  }

  Future<void> _loadNoteIfExists() async {
    if (visitedWordId == null) return;

    final note = await db.notesDao.getNoteForVisitedId(visitedWordId!);
    if (note != null) {
      setState(() {
        controller.text = note.note;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final DefinitionsService definitionsService = DefinitionsService(
      definitions: widget.the_word,
    );
    final String kanjiWord = widget.the_word.words[0].word;
    final String kanaWord = widget.the_word.words[0].reading;
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
                (kanjiWord != null && kanjiWord.isNotEmpty)
                    ? kanjiWord
                    : kanaWord,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),

            fixedLabeledRow('Kana', kanaWord),
            fixedLabeledRow('Romaji', kanaKit.toRomaji(kanaWord)),

            Text(
              'Meanings:',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                definitions.map((word) => word).join(', '),
                style: TextStyle(fontSize: 16),
              ),
            ),

            Text(
              'Other Readings:',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                definitionsService
                    .giveOtherReadings()
                    .map((word) => word)
                    .join('\n'),
                style: TextStyle(fontSize: 16),
              ),
            ),

            Text('Notes:', style: TextStyle(fontSize: 18, color: Colors.grey)),
            TextField(
              controller: controller,
              onChanged: (value) {
                setState(() {
                  if (visitedWordId != null) {
                    db.notesDao.upsertNote(visitedWordId!, value);
                  }
                });
              },
              decoration: InputDecoration(
                hintText: controller.text.isEmpty
                    ? 'Enter notes here...'
                    : null,
                border: InputBorder.none,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
              maxLines: null,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // db.printVisitedWords();
          // db.printNotesTable();
          // db.clearDbTables();
          // openDialog();
        },
      ),
    );
  }

  // Future openDialog() =>
  //     showDialog(
  //       context: context,
  //       builder: (context) => AlertDialog(
  //         title: Text("Save As FlashCard"),
  //         content: 
  //       ));

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
