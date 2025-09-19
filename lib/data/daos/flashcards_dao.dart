import 'package:drift/drift.dart';
import '../db_helper.dart';
import '../tables/flashcards.dart';

part 'flashcards_dao.g.dart';

@DriftAccessor(tables: [FlashCards])
class FlashcardsDao extends DatabaseAccessor<DbHelper>
    with _$FlashcardsDaoMixin {
  FlashcardsDao(DbHelper db) : super(db);

  Future<List<FlashCard>> getAllCards() async {
    return select(flashCards).get();
  }

  Future<List<FlashCard>> getAllFlashCardsInDeck(int deckId) async {
    final query = select(flashCards)..where((tbl) => tbl.folder.equals(deckId));
    return query.get();
  }

  Future<int> insertFlashCard(
    String frontKanji, {
    required String frontKana,
    required String back,
    required int folderId,
  }) async {
    final card = FlashCardsCompanion(
      front_kanji: Value(frontKanji ?? ''),
      front_kana: Value(frontKana),
      back: Value(back),
      folder: Value(folderId),
    );
    return into(flashCards).insert(card);
  }

  // Future<int> deleteFlashCard() async {}
}
