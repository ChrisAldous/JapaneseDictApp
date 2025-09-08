import 'package:drift/drift.dart';

class VisitedWord extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get kanji => text()();
  TextColumn get kana => text()();
  TextColumn get definition => text()();
  DateTimeColumn get visitedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Set<Column>> get uniqueKey => { {kanji, kana} };
}
