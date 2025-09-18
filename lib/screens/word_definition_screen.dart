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
        child: Icon(Icons.save),
        onPressed: () async {
          final folders = await db.foldersDao.getAllFolders();

          await openSaveFlashcardDialog(
            initialFrontKanji: widget.the_word.words[0].word,
            initialFrontKana: widget.the_word.words[0].reading,
            initialBack: widget.the_word.definition.join(', '),
            folderList: folders,
            onCreateNewFolder: () async {
              // Show another dialog to get folder name
              final nameController = TextEditingController();
              final result = await showDialog<String>(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('New Folder'),
                  content: TextField(
                    controller: nameController,
                    decoration: InputDecoration(hintText: 'Enter folder name'),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop(nameController.text);
                      },
                      child: Text('Create'),
                    ),
                  ],
                ),
              );

              if (result != null && result.trim().isNotEmpty) {
                await db.foldersDao.insertFolder(
                  FlashFoldersCompanion(name: drift.Value(result.trim())),
                );
              }
            },

            onSave:
                ({
                  required String frontKanji,
                  required String frontKana,
                  required String back,
                  required int folderId,
                }) async {
                  await db.flashcardsDao.insertFlashCard(
                    frontKanji,
                    frontKana: frontKana,
                    back: back,
                    folderId: folderId,
                  );

                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text('Flashcard saved!')));
                },
          );
        },
      ),
    );
  }

  Future<void> openSaveFlashcardDialog({
    required String initialFrontKanji,
    required String initialFrontKana,
    required String initialBack,
    required List<FlashFolder> folderList,
    required Future<void> Function() onCreateNewFolder,
    required Future<void> Function({
      required String frontKanji,
      required String frontKana,
      required String back,
      required int folderId,
    }) onSave,
  }) async {
    const int createNewFolderId = -1;

    final kanjiController = TextEditingController(text: initialFrontKanji);
    final kanaController = TextEditingController(text: initialFrontKana);
    final backController = TextEditingController(text: initialBack);

    int selectedFolderId = folderList.isEmpty ? createNewFolderId : folderList.first.id;

    await showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          final dropdownItems = <DropdownMenuItem<int>>[
            DropdownMenuItem(
              value: createNewFolderId,
              child: Text('➕ Create new folder'),
            ),
            ...folderList.map((folder) => DropdownMenuItem(
                  value: folder.id,
                  child: Text(folder.name),
                )),
          ];

          bool isSaveEnabled =
              selectedFolderId != createNewFolderId &&
              kanaController.text.trim().isNotEmpty &&
              backController.text.trim().isNotEmpty;

          return AlertDialog(
            title: Text("Save As FlashCard"),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButton<int>(
                    value: selectedFolderId,
                    isExpanded: true,
                    onChanged: (value) async {
                      if (value == createNewFolderId) {
                        await onCreateNewFolder();
                        Navigator.of(context).pop(); // close and reopen
                        return;
                      }
                      setState(() {
                        selectedFolderId = value!;
                      });
                    },
                    items: dropdownItems,
                  ),
                  SizedBox(height: 12),

                  TextField(
                    decoration: InputDecoration(labelText: 'Front Kanji (optional)'),
                    controller: kanjiController,
                    onChanged: (_) => setState(() {}),
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: 'Front Kana'),
                    controller: kanaController,
                    onChanged: (_) => setState(() {}),
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: 'Back'),
                    controller: backController,
                    onChanged: (_) => setState(() {}),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: isSaveEnabled
                    ? () async {
                        await onSave(
                          frontKanji: kanjiController.text.trim(),
                          frontKana: kanaController.text.trim(),
                          back: backController.text.trim(),
                          folderId: selectedFolderId,
                        );
                        Navigator.of(context).pop();
                      }
                    : null,
                child: Text('Save'),
              ),
            ],
          );
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
