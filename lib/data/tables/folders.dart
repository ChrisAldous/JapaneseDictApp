import 'package:drift/drift.dart';

class FlashFolders extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
}