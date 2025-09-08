import 'package:drift/drift.dart';
import '../db_helper.dart';
import '../tables/folders.dart';

part 'folders_dao.g.dart';

@DriftAccessor(tables: [FlashFolders])
class FoldersDao extends DatabaseAccessor<DbHelper> with _$FoldersDaoMixin {
  FoldersDao(DbHelper db) : super(db);
}
