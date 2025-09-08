import 'package:drift/drift.dart';
import '../db_helper.dart';
import '../tables/notes.dart';

part 'notes_dao.g.dart';

@DriftAccessor(tables: [Notes])
class NotesDao extends DatabaseAccessor<DbHelper> with _$NotesDaoMixin {
  NotesDao(DbHelper db) : super(db);

  Future<void> insertNote(NotesCompanion note) =>
      into(notes).insertOnConflictUpdate(note);

  Future<Note?> getNoteForVisitedId(int visitedId) =>
      (select(notes)..where((n) => n.id.equals(visitedId))).getSingleOrNull();

  
}
