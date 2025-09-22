import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:japanese_dict/data/db_helper.dart';
import 'package:japanese_dict/data/daos/folders_dao.dart';
import 'package:japanese_dict/data/tables/folders.dart';
import 'package:japanese_dict/screens/flashcard_deck_screen.dart';
import 'package:japanese_dict/screens/widgets/custom_drawer.dart';
import 'package:provider/provider.dart';

class FoldersScreen extends StatefulWidget {
  const FoldersScreen({super.key});

  @override
  State<FoldersScreen> createState() => _FoldersScreenState();
}

class _FoldersScreenState extends State<FoldersScreen> {
  late DbHelper db;
  TextEditingController controller = TextEditingController();
  List<FlashFolder> folderList = [];

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      db = context.read<DbHelper>();
      await _getFolderList();
    });
  }

  Future<void> _getFolderList() async {
    final foldersDao = db.foldersDao;
    final fetchedFolders = await foldersDao.getAllFolders();

    setState(() {
      folderList = fetchedFolders;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          backgroundColor: const Color.fromARGB(255, 210, 24, 11),
          title: Text('Japanese Dictionary'),
        ),
      ),
      drawer: CustomDrawer(),
      body: folderList.isEmpty
          ? Center(child: Text("No folders found."))
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12.0,
                mainAxisSpacing: 12.0,
                childAspectRatio: 1,
              ),

              itemCount: folderList.length,
              itemBuilder: (context, index) {
                final folder = folderList[index];
                return Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: CustomGridTiles(folder),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openDialog();
        },
        backgroundColor: Color.fromARGB(255, 210, 24, 11),
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget CustomGridTiles(FlashFolder folder) {
    return InkWell(
      onLongPress: () => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Do you want to delete this Folder?'),
          content: Text('All flashcards in folder will also be deleted'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('CANCEL'),
            ),
            TextButton(
              onPressed: () async {
                await db.flashcardsDao.deleteFlashCardByFolderId(folder.id);
                await db.foldersDao.deleteFolderByName(folder.name);
                await _getFolderList();
                Navigator.of(context).pop();
              },
              child: Text('DELETE'),
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) =>
                FlashcardDeckScreen(deckName: folder.name),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(12.0),
        child: Stack(
          alignment: AlignmentGeometry.center,
          children: [
            Expanded(
              flex: 1,
              child: Icon(Icons.folder, size: 100, color: Colors.grey),
            ),
            Text(
              '${folder.name}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future openDialog() => showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text("Create new Folder"),
      content: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: 'New folder name...',
          border: const OutlineInputBorder(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('CANCEL', style: TextStyle(color: Colors.red)),
        ),
        TextButton(
          onPressed: () async {
            final folder = controller.text.trim();

            if (folder.isEmpty) {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Folder name cannot be empty"),
                  duration: Duration(seconds: 3),
                ),
              );
              return;
            }

            final exists = await db.foldersDao.recordExists(folderName: folder);

            if (exists) {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Folder named $folder already exists"),
                  duration: Duration(seconds: 3),
                ),
              );
            } else {
              await db.foldersDao.insertFolder(
                FlashFoldersCompanion(name: Value(folder)),
              );

              await _getFolderList();
              controller.clear();
              Navigator.of(context).pop();

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Successfully saved $folder into Folders!'),
                  duration: Duration(seconds: 3),
                ),
              );
            }
          },
          child: Text('SUBMIT', style: TextStyle(color: Colors.red)),
        ),
      ],
    ),
  );
}
