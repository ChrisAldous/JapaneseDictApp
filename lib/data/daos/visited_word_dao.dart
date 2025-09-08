import 'package:drift/drift.dart';
import '../db_helper.dart';
import '../tables/visited_word.dart';

part 'visited_word_dao.g.dart';

@DriftAccessor(tables: [VisitedWord])
class VisitedWordDao extends DatabaseAccessor<DbHelper>
    with _$VisitedWordDaoMixin {
  VisitedWordDao(DbHelper db) : super(db);

  Future<List<VisitedWordData>> getAllVisitedWords() =>
      select(visitedWord).get();

  Future<int> insertVisitedWord(VisitedWordCompanion word) {
    return into(visitedWord).insert(word, mode: InsertMode.insertOrIgnore);
  }

  Future<bool> recordExists({
    required String kanji,
    required String kana,
  }) async {
    final query = select(visitedWord)
      ..where((tbl) => tbl.kana.equals(kana) & tbl.kanji.equals(kanji));

    return (await query.get()).isNotEmpty;
  }
}
