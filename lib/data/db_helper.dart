import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'tables/flashcards.dart';
import 'tables/folders.dart';
import 'tables/notes.dart';
import 'tables/visited_word.dart';

part 'db_helper.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory(); // from path_provider
    final file = File(p.join(dir.path, 'japanese_database.sqlite'));
    return NativeDatabase(file, logStatements: true);  });
}

@DriftDatabase(tables: [FlashCards, FlashFolders, Notes, VisitedWord])
class DbHelper extends _$DbHelper {
  DbHelper() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}
