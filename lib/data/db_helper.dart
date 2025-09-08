import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:japanese_dict/data/daos/flashcards_dao.dart';
import 'package:japanese_dict/data/daos/folders_dao.dart';
import 'package:japanese_dict/data/daos/notes_dao.dart';
import 'package:japanese_dict/data/daos/visited_word_dao.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'tables/flashcards.dart';
import 'tables/folders.dart';
import 'tables/notes.dart';
import 'tables/visited_word.dart';
import 'daos/flashcards_dao.dart';
import 'daos/folders_dao.dart';
import 'daos/visited_word_dao.dart';
import 'daos/notes_dao.dart';

part 'db_helper.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory(); // from path_provider
    final file = File(p.join(dir.path, 'japanese_database.sqlite'));
    return NativeDatabase(file, logStatements: true);
  });
}

@DriftDatabase(
  tables: [FlashCards, FlashFolders, Notes, VisitedWord],
  daos: [VisitedWordDao, NotesDao, FoldersDao, FlashcardsDao],
)
class DbHelper extends _$DbHelper {
  DbHelper() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<void> printVisitedWords() async {
    final words = await visitedWordDao.getAllVisitedWords();
    for (var word in words) {
      print(
        'ID: ${word.id}, Kanji: ${word.kanji}, Kana: ${word.kana}, Def: ${word.definition}',
      );
    }
  }

  Future<void> clearDbTables() async {
    await batch((batch) {
      batch.deleteAll(visitedWord);
      batch.deleteAll(notes);
      batch.deleteAll(flashCards);
      batch.deleteAll(flashFolders);
    });
  }
}
