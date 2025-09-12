import 'package:drift/drift.dart';
import '../db_helper.dart';
import '../tables/notes.dart';

part 'notes_dao.g.dart';

@DriftAccessor(tables: [Notes])
class NotesDao extends DatabaseAccessor<DbHelper> with _$NotesDaoMixin {
  NotesDao(DbHelper db) : super(db);

  Future<void> upsertNote(int visitedWordId, String note) =>
      into(notes).insertOnConflictUpdate(
        NotesCompanion(id: Value(visitedWordId), note: Value(note)),
      );

  Future<Note?> getNoteForVisitedId(int visitedId) =>
      (select(notes)..where((n) => n.id.equals(visitedId))).getSingleOrNull();

  Future<List<Note>> getAllNotes() => select(notes).get();
}
