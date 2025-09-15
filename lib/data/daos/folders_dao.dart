import 'package:drift/drift.dart';
import '../db_helper.dart';
import '../tables/folders.dart';

part 'folders_dao.g.dart';

@DriftAccessor(tables: [FlashFolders])
class FoldersDao extends DatabaseAccessor<DbHelper> with _$FoldersDaoMixin {
  FoldersDao(DbHelper db) : super(db);

  Future<bool> recordExists({required String folderName}) async {
    final query = select(flashFolders)
      ..where((tbl) => tbl.name.equals(folderName));
    return (await query.get()).isNotEmpty;
  }

  Future<List<FlashFolder>> getAllFolders() async {
    return select(flashFolders).get();
  }

  Future<FlashFolder?> selectedFolder({required String folderName}) async {
    final query = select(flashFolders)
      ..where((tbl) => tbl.name.equals(folderName));
    return query.getSingleOrNull();
  }

  Future<int> insertFolder(FlashFoldersCompanion folder) async {
    return into(flashFolders).insert(folder);
  }

  Future<int> deleteFolderByName(String folderName) async {
    return (delete(
      flashFolders,
    )..where((tbl) => tbl.name.equals(folderName))).go();
  }

  Future<bool> updateFolderName(String oldName, String newName) async {
    final rowUpdated =
        await (update(flashFolders)..where((tbl) => tbl.name.equals(oldName)))
            .write(FlashFoldersCompanion(name: Value(newName)));

    return rowUpdated > 0;
  }
}
