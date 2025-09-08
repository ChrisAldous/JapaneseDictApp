import 'package:drift/drift.dart';
import '../db_helper.dart';
import '../tables/flashcards.dart';

part 'flashcards_dao.g.dart';

@DriftAccessor(tables: [FlashCards])
class FlashcardsDao extends DatabaseAccessor<DbHelper> with _$FlashcardsDaoMixin {
  FlashcardsDao(DbHelper db) : super(db);

}
