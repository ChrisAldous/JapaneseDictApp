import 'package:drift/drift.dart';
import 'package:japanese_dict/data/tables/folders.dart';

class FlashCards extends Table {
  TextColumn get front_kanji => text()();
  TextColumn get front_kana => text().nullable()();
  TextColumn get back => text()();
  IntColumn get folder => integer().references(FlashFolders, #id)();
}
