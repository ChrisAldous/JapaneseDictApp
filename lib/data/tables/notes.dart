import 'package:drift/drift.dart';
import 'package:japanese_dict/data/tables/visited_word.dart';

class Notes extends Table {
  IntColumn get id => integer().references(VisitedWord, #id)();
  TextColumn get note => text()();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}
